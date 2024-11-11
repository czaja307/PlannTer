import Foundation

class PerenualAPI {
    private let apiKey = "YOUR_API_KEY"  // Wstaw swój API Key
    private let baseUrl = "https://api.perenual.com/v1/plants"  // Przykładowa baza URL

    // Wyszukiwanie roślin po nazwie
    func fetchPlants(completion: @escaping ([PlantModel]?, Error?) -> Void) {
        guard let url = URL(string: baseUrl) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError(domain: "No Data", code: 0, userInfo: nil))
                return
            }

            do {
                let decoder = JSONDecoder()
                let plantData = try decoder.decode([PlantModel].self, from: data)
                completion(plantData, nil)
            } catch {
                completion(nil, error)
            }
        }

        task.resume()
    }
}
