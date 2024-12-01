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
    var wateringFreq: Int?
    var conditioningFreq: Int?
    var dailySunExposure: Int?
    var nextWateringDate: Date?
    var prevWateringDate: Date?
    var nextConditioningDate: Date?
    var prevConditioningDate: Date?
    var details: PlantDetails?
    
    // Initializers
    init(details: PlantDetails, waterAmount: Int, sunlightHours: Int, wateringFreq: Int, conditioniingFreq: Int? = nil) {
        self.id = UUID()
        self.plantId = details.id
        self.name = details.commonName ?? "Unknown Plant"
        self.imageUrl = details.defaultImage?.regularURL ?? ""
        self.category = details.category
        self.species = details.species
        self.descriptionText = details.descriptionText
        self.details = details
        self.waterAmountInML = waterAmount
        self.wateringFreq = wateringFreq
        self.conditioningFreq = conditioningFreq
        self.dailySunExposure = sunlightHours
        self.prevWateringDate = Date()
        self.nextWateringDate =  Calendar.current.date(byAdding: .day, value: wateringFreq, to: Date())
        self.prevConditioningDate = conditioniingFreq == nil ? nil : Date()
        self.nextConditioningDate = conditioniingFreq == nil ? nil :  Calendar.current.date(byAdding: .day, value: conditioniingFreq ?? 0, to: Date())
    }
    
    init(id: UUID = UUID(), plantId: Int? = nil, room: RoomModel? = nil, name: String = "Unnamed Plant",
         description: String? = nil, imageUrl: String? = nil, category: String? = nil, species: String? = nil,
         waterAmountInML: Int? = nil, dailySunExposure: Int? = nil, nextWateringDate: Date? = nil,
         prevWateringDate: Date? = nil, wateringFreq: Int? = nil, nextConditioningDate: Date? = nil,
         prevConditioningDate: Date? = nil, conditioningFreq: Int? = nil, details: PlantDetails? = nil) {
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
        self.wateringFreq = wateringFreq
        self.nextConditioningDate = nextWateringDate
        self.prevConditioningDate = prevWateringDate
        self.conditioningFreq = conditioningFreq
        self.details = details
    }
    
    // fetch details from API and create plant model
    static func createFromApi(plantId: Int, completion: @escaping (PlantModel?) -> Void) {
        PlantService.getPlantDetails(for: plantId) { details in
            guard let details = details else {
                print("Failed to fetch plant details for plant ID: \(plantId)")
                completion(nil)
                return
            }
            
            // Example logic for calculating water and sunlight needs
            let waterAmount = 500 // Assume 500ml as default
            let sunlightHours = 6 // Assume 6 hours as default
            let wateringFreq = 3
            
            // Initialize the plant model
            let plant = PlantModel(details: details, waterAmount: waterAmount, sunlightHours: sunlightHours, wateringFreq: wateringFreq)
            completion(plant)
        }
    }
    
    // CodingKeys
    enum CodingKeys: String, CodingKey {
        case id, plantId, name, descriptionText, imageUrl, category, species
        case waterAmountInML, dailySunExposure, nextWateringDate, prevWateringDate, details
        case nextConditioningDate, prevConditioningDate
        case wateringFreq, conditioningFreq
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
        wateringFreq = try container.decodeIfPresent(Int.self, forKey: .wateringFreq)
        nextConditioningDate = try container.decodeIfPresent(Date.self, forKey: .nextConditioningDate)
        prevConditioningDate = try container.decodeIfPresent(Date.self, forKey: .prevConditioningDate)
        conditioningFreq = try container.decodeIfPresent(Int.self, forKey: .conditioningFreq)
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
        try container.encodeIfPresent(wateringFreq, forKey: .wateringFreq)
        try container.encodeIfPresent(nextConditioningDate, forKey: .nextConditioningDate)
        try container.encodeIfPresent(prevConditioningDate, forKey: .prevConditioningDate)
        try container.encodeIfPresent(conditioningFreq, forKey: .conditioningFreq)
        try container.encodeIfPresent(details, forKey: .details)
    }
    
    // Example Plant
    static var examplePlant = PlantModel(name: "Example Plant", imageUrl: "ExamplePlant", waterAmountInML: 500, dailySunExposure: 6,
                                         nextWateringDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()),
                                         prevWateringDate: Date(), wateringFreq: 3)
    
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
            PlantModel.createFromApi(plantId: 3) { plant in
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
        guard let nextConditioningDate = nextConditioningDate else { return 1 }
        var notifs = 0
        notifs += nextWateringDate < Date() ? 1 : 0
        notifs += nextConditioningDate < Date() ? 1 : 0
        return notifs
    }
    
    var isWatered: Bool {
        guard let nextWateringDate = nextWateringDate else { return false }
        return nextWateringDate > Date()
    }
    
    var progress: Double {
        return 0.4
    }
}
