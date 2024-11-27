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

    func fetchPlantList(completion: @escaping (Result<[PlantData], Error>) -> Void) {
        let urlString = "\(baseURL)/species-list?key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

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
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                completion(.success(apiResponse.data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }


    func fetchPlantDetails(plantID: Int, completion: @escaping (Result<PlantDetails, Error>) -> Void) {
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
