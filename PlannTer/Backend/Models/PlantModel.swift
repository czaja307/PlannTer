import Foundation
import SwiftData

@Model
class PlantModel: Identifiable, Codable {
    var id: UUID
    var plantId: Int?
    var room: RoomModel?
    
    var name: String
    var descriptionText: String?
    var imageUrl: String?
    var category: String?
    var species: String?
    var waterAmountInML: Int?
    var dailySunExposure: Int?
    var nextWateringDate: Date?
    var prevWateringDate: Date?
    var details: PlantDetails?
    
    // Initializers
    init(details: PlantDetails, waterAmount: Int, sunlightHours: Int, nextWatering: Date) {
        self.id = UUID()
        self.plantId = details.id
        self.name = details.commonName ?? "Unknown Plant"
        self.imageUrl = details.defaultImage?.regularURL ?? ""
        self.category = details.category
        self.species = details.species
        self.descriptionText = details.description
        self.details = details
        self.waterAmountInML = waterAmount
        self.dailySunExposure = sunlightHours
        self.prevWateringDate = Date()
        self.nextWateringDate = nextWatering
    }
    
    init(id: UUID = UUID(), plantId: Int? = nil, room: RoomModel? = nil, name: String = "Unnamed Plant",
         description: String? = nil, imageUrl: String? = nil, category: String? = nil, species: String? = nil,
         waterAmountInML: Int? = nil, dailySunExposure: Int? = nil, nextWateringDate: Date? = nil,
         prevWateringDate: Date? = nil, details: PlantDetails? = nil) {
        self.id = id
        self.plantId = plantId
        self.room = room
        self.name = name
        self.descriptionText = description
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
    
    // CodingKeys
    enum CodingKeys: String, CodingKey {
        case id, plantId, name, descriptionText, imageUrl, category, species
        case waterAmountInML, dailySunExposure, nextWateringDate, prevWateringDate, details
    }
    
    // Decodable implementation
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        plantId = try container.decodeIfPresent(Int.self, forKey: .plantId)
        name = try container.decode(String.self, forKey: .name)
        descriptionText = try container.decodeIfPresent(String.self, forKey: .descriptionText)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        species = try container.decodeIfPresent(String.self, forKey: .species)
        waterAmountInML = try container.decodeIfPresent(Int.self, forKey: .waterAmountInML)
        dailySunExposure = try container.decodeIfPresent(Int.self, forKey: .dailySunExposure)
        nextWateringDate = try container.decodeIfPresent(Date.self, forKey: .nextWateringDate)
        prevWateringDate = try container.decodeIfPresent(Date.self, forKey: .prevWateringDate)
        details = try container.decodeIfPresent(PlantDetails.self, forKey: .details)
    }
    
    // Encodable implementation
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(plantId, forKey: .plantId)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(descriptionText, forKey: .descriptionText)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(species, forKey: .species)
        try container.encodeIfPresent(waterAmountInML, forKey: .waterAmountInML)
        try container.encodeIfPresent(dailySunExposure, forKey: .dailySunExposure)
        try container.encodeIfPresent(nextWateringDate, forKey: .nextWateringDate)
        try container.encodeIfPresent(prevWateringDate, forKey: .prevWateringDate)
        try container.encodeIfPresent(details, forKey: .details)
    }
    
    // Example Plant
    static var examplePlant = PlantModel(name: "Example Plant", imageUrl: "ExamplePlant", waterAmountInML: 500, dailySunExposure: 6,
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
    func waterThePlant() {
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
