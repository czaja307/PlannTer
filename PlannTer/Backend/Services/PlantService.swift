import Foundation

class PlantService {
    private let api = PerenualAPI()
    private var plantList: [PlantData] = []

    func loadPlantList() {
        api.fetchPlantList { result in
            switch result {
            case .success(let plants):
                self.plantList = plants
                print("Plant list loaded: \(plants)")
            case .failure(let error):
                print("Error loading plant list: \(error)")
            }
        }
    }

    func getPlantDetails(for id: Int) {
        api.fetchPlantDetails(plantID: id) { result in
            switch result {
            case .success(let details):
                print("Plant details: \(details)")
            case .failure(let error):
                print("Error loading plant details: \(error)")
            }
        }
    }
}
