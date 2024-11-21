import Foundation

class PlantService {
    private let api = PerenualAPI()
    private var plantList: [PlantData] = []

    func loadPlantList() {
        api.fetchPlantList { result in
            switch result {
            case .success(let plants):
                for plant in plants {
                    print("Plant ID: \(plant.id ?? -1)")
                    print("Common Name: \(plant.commonName ?? "Unknown")")
                    if let sunlight = plant.sunlight {
                        print("Sunlight requirements: \(sunlight.joined(separator: ", "))")
                    } else {
                        print("No sunlight data available")
                    }
                    print("Thumbnail: \(plant.defaultImage?.thumbnail ?? "No image available")")
                    print("------")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func getPlantDetails(for id: Int) {
        api.fetchPlantDetails(plantID: id) { result in
            switch result {
            case .success(let details):
                print("Plant Details: \(details)")
            case .failure(let error):
                print("Error fetching plant details: \(error)")
            }
        }
    }
}
