import Foundation

final class PlantService {
    private static let api = PerenualAPI()
    private static var plantList: [PlantData] = []
    private static var isPlantListLoaded = false

    // metoda do załadowania listy roślin z API
    static func loadPlantList(completion: @escaping ([PlantData]) -> Void) {
        if isPlantListLoaded {
            completion(plantList)
            return
        }
        
        api.fetchPlantList { result in
            switch result {
            case .success(let plants):
                self.plantList = plants
                self.isPlantListLoaded = true
                completion(plants)
            case .failure(let error):
                print("Error fetching plant list: \(error.localizedDescription)")
                completion([])
            }
        }
    }

    // metoda do pobrania szczegółów rośliny po ID
    static func getPlantDetails(for id: Int, completion: @escaping (PlantDetails?) -> Void) {
        api.fetchPlantDetails(plantID: id) { result in
            switch result {
            case .success(let details):
                completion(details)
            case .failure(let error):
                print("Error fetching plant details: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    // metoda zwracająca listę unikalnych kategorii
    static func getUniqueCategories(completion: @escaping ([String]) -> Void) {
        loadPlantList { plants in
            let categories = Set(plants.compactMap { $0.category })
            completion(Array(categories))
        }
    }
    

    // metoda zwracająca listę unikalnych gatunków dla danej kategorii
    static func getUniqueSpeciesForCategory(_ category: String, completion: @escaping ([String]) -> Void) {
        loadPlantList { plants in
            let species = Set(plants.filter { $0.category == category }.compactMap { $0.species })
            completion(Array(species))
        }
    }

    // metoda zwracająca ID rośliny dla podanej kategorii i gatunku
    static func findPlantId(forCategory category: String, species: String, completion: @escaping (Int) -> Void) {
        loadPlantList { plants in
            let matchingPlants = plants.filter { $0.category == category && $0.species == species }
            completion(matchingPlants.first?.id ?? -1)
        }
    }
}
