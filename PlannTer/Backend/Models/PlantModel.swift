import Foundation

struct PlantModel: Identifiable, Codable {
    var id: UUID // unique local ID
    var plantId: Int? // plant ID from API
    var roomId: Int?

    var name: String // plant name
    var description: String?
    var imageUrl: String? // URL of the plant's image
    var category: String? // category (from API)
    var species: String? // species (from API)

    var waterAmountInML: Int? // water amount in ml
    var dailySunExposure: Int? // required daily sunlight exposure (hours)
    var nextWateringDate: Date? // next watering date
    var prevWateringDate: Date? // last watering date

    var details: PlantDetails? // plant details from API

    // initialization based on PlantDetails
    init(details: PlantDetails, waterAmount: Int, sunlightHours: Int, nextWatering: Date) {
        self.id = UUID()
        self.plantId = details.id
        self.name = details.commonName ?? "Unknown Plant"
        self.imageUrl = details.defaultImage?.regularURL ?? ""
        self.category = details.category
        self.species = details.species
        self.description = details.description
        self.details = details
        self.waterAmountInML = waterAmount
        self.dailySunExposure = sunlightHours
        self.prevWateringDate = Date() // assume watered at initialization
        self.nextWateringDate = nextWatering
    }

    // manual initialization
    init(id: UUID = UUID(), plantId: Int? = nil, roomId: Int? = nil, name: String = "Unnamed Plant",
         description: String? = nil, imageUrl: String? = nil, category: String? = nil, species: String? = nil,
         waterAmountInML: Int? = nil, dailySunExposure: Int? = nil, nextWateringDate: Date? = nil,
         prevWateringDate: Date? = nil, details: PlantDetails? = nil) {
        self.id = id
        self.plantId = plantId
        self.roomId = roomId
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.category = category
        self.species = species
        self.waterAmountInML = waterAmountInML
        self.dailySunExposure = dailySunExposure
        self.nextWateringDate = nextWateringDate
        self.prevWateringDate = prevWateringDate
        self.details = details
    }

    // fetch details from API and create plant model
    static func createFromApi(plantId: Int, service: PlantService, completion: @escaping (PlantModel?) -> Void) {
        service.getPlantDetails(for: plantId) { details in
            guard let details = details else {
                print("Failed to fetch plant details for plant ID: \(plantId)")
                completion(nil)
                return
            }
            
            // Example logic for calculating water and sunlight needs
            let waterAmount = 500 // Assume 500ml as default
            let sunlightHours = 6 // Assume 6 hours as default
            let nextWatering = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
            
            // Initialize the plant model
            let plant = PlantModel(details: details, waterAmount: waterAmount, sunlightHours: sunlightHours, nextWatering: nextWatering)
            completion(plant)
        }
    }

    // example plant
    static var examplePlant = PlantModel(name: "Example Plant", waterAmountInML: 500, dailySunExposure: 6,
                                         nextWateringDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
                                         prevWateringDate: Date())
    
    // function to get a plant from API
    static var exampleApiPlant: PlantModel {
        get {
            // jak raz zaladowany plant istnieje to go zwracam
            if let plant = _exampleApiPlant {
                return plant
            }
            
            // placeholder na czas ładowania danych z API
            _exampleApiPlant = PlantModel(name: "Loading...", waterAmountInML: 0, dailySunExposure: 0,
                                          nextWateringDate: Date(), prevWateringDate: Date())
            
            // ładujemy roślinę asynchronicznie
            PlantModel.createFromApi(plantId: 3, service: PlantService()) { plant in
                _exampleApiPlant = plant // Po załadowaniu, aktualizujemy plant
            }
            
            return _exampleApiPlant!
        }
    }
    private static var _exampleApiPlant: PlantModel?
    
    static var examplePlants = [
        examplePlant,
        examplePlant
    ]

    // water the plant
    mutating func waterThePlant() {
        self.prevWateringDate = Date()
        self.nextWateringDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())
    }

    // check for errors
    var notificationsCount: Int {
        guard let nextWateringDate = nextWateringDate else { return 1 }
        return nextWateringDate < Date() ? 1 : 0
    }
    
    var isWatered: Bool {
        return false
    }
    
    var progress: Double {
        return 0.4
    }
}
