import Foundation

class PerenualAPI {
    private let apiKey = "api key here"
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
                let plantList = try decoder.decode([PlantData].self, from: data)
                completion(.success(plantList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchPlantDetails(plantID: Int, completion: @escaping (Result<PlantDetails, Error>) -> Void) {
        let urlString = "\(baseURL)/species/details/\(plantID)?key=\(apiKey)"
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
                let plantDetails = try decoder.decode(PlantDetails.self, from: data)
                completion(.success(plantDetails))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
