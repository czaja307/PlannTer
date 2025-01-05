import Foundation

class PerenualAPI {
    //private let apiKey = "apikey"
    private lazy var apiKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Api-key") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return apiKey
    }()
    private let baseURL = "https://perenual.com/api"
    private let pageRange = 1...5 // range of pages to fetch

    func fetchPlantList(completion: @escaping (Result<[PlantData], Error>) -> Void) {
        var allPlants: [PlantData] = []
        let dispatchGroup = DispatchGroup()
        var fetchError: Error?

        for page in pageRange {
            dispatchGroup.enter()
            print("list api request")
            let urlString = "\(baseURL)/species-list?key=\(apiKey)&indoor=1&page=\(page)"
            guard let url = URL(string: urlString) else {
                fetchError = NSError(domain: "Invalid URL", code: -1, userInfo: nil)
                dispatchGroup.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    fetchError = error
                    dispatchGroup.leave()
                    return
                }

                guard let data = data else {
                    fetchError = NSError(domain: "No data", code: -1, userInfo: nil)
                    dispatchGroup.leave()
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let apiResponse = try decoder.decode(APIResponse.self, from: data)
                    allPlants.append(contentsOf: apiResponse.data)
                } catch {
                    fetchError = error
                }

                dispatchGroup.leave()
            }.resume()
        }

        dispatchGroup.notify(queue: .main) {
            if let error = fetchError {
                completion(.failure(error))
            } else {
                completion(.success(allPlants))
            }
        }
    }

    func fetchPlantDetails(plantID: Int, completion: @escaping (Result<PlantDetails, Error>) -> Void) {
        print("details api request")
        let urlString = "\(baseURL)/species/details/\(plantID)?key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let plantDetails = try decoder.decode(PlantDetails.self, from: data)
                completion(.success(plantDetails))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
