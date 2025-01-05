import Foundation

class PlantService {
    static let shared = PlantService() // singleton

    private let api = PerenualAPI()
    private var plantList: [PlantData] = []
    private var isPlantListLoaded = false
    private let topCategoriesCount = 5 // number of categories to return

    // private constructor
    private init() {}

    // method to load plant list from API
    func loadPlantList(completion: @escaping ([PlantData]) -> Void) {
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

    // method to get plant details by ID
    func getPlantDetails(for id: Int, completion: @escaping (PlantDetails?) -> Void) {
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

    // method to get top N unique categories by number of elements
    func _OLD_getUniqueCategories(completion: @escaping ([String]) -> Void) {
        loadPlantList { plants in
            let categoryCounts: [String: Int] = plants.reduce(into: [:]) { counts, plant in
                if let category = plant.category { // ignorujemy nil
                    counts[category, default: 0] += 1
                }
            }
            let sortedCategories = categoryCounts.sorted { $0.value > $1.value }
            
            print("Sorted categories with counts:")
            for (category, count) in sortedCategories {
                print("\(category): \(count)")
            }
            
            let topCategories = sortedCategories.prefix(self.topCategoriesCount).map { $0.key }
            completion(topCategories)
        }
    }
    
    func getUniqueCategories(completion: @escaping ([String]) -> Void) {
        let predefinedCategories = ["begonia", "fern", "fig", "plant", "maple", "ear", "palm"] // statyczna lista kategorii
        
        loadPlantList { plants in
            let categoryCounts: [String: Int] = plants.reduce(into: [:]) { counts, plant in
                if let category = plant.category { // ignorujemy nil
                    counts[category, default: 0] += 1
                }
            }
            let filteredCategories = categoryCounts.filter { predefinedCategories.contains($0.key) }
            let sortedCategories = filteredCategories.sorted { $0.value > $1.value }
            
            // debug: wypisz przefiltrowane kategorie i ich liczbę wystąpień
            print("Filtered categories with counts:")
            for (category, count) in sortedCategories {
                print("\(category): \(count)")
            }
            
            let resultCategories = sortedCategories.map { $0.key }
            completion(resultCategories)
        }
    }




    // method to get unique species for a given category
    func getUniqueSpeciesForCategory(_ category: String, completion: @escaping ([String]) -> Void) {
        loadPlantList { plants in
            let species = Set(plants.filter { $0.category == category }.compactMap { $0.species })
            completion(Array(species))
        }
    }

    // method to find plant ID for given category and species
    func findPlantId(forCategory category: String, species: String, completion: @escaping (Int) -> Void) {
        loadPlantList { plants in
            let matchingPlants = plants.filter { $0.category == category && $0.species == species }
            completion(matchingPlants.first?.id ?? -1)
        }
    }
}
