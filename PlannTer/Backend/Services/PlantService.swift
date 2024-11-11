import Foundation

class PlantService {
    private let api = PerenualAPI()

    func getPlants(completion: @escaping ([PlantModel]?, Error?) -> Void) {
        api.fetchPlants { plants, error in
            if let error = error {
                print("Error fetching plants: \(error)")
                completion(nil, error)
                return
            }

            guard let plants = plants else {
                completion(nil, NSError(domain: "No Plants Found", code: 0, userInfo: nil))
                return
            }

            completion(plants, nil)
        }
    }
}
