import Foundation
import SwiftData

@Model
class PlantModel: Identifiable, Codable {
    var id: UUID
    var plantId: Int?
    var room: RoomModel
    
    var name: String
    var descriptionText: String?
    var imageUrl: String?
    var category: String?
    var species: String?
    var waterAmountInML: Int?
    var wateringFreq: Int?
    var conditioningFreq: Int?
    var dailySunExposure: Int?
    //var nextWateringDate: Date?
    var prevWateringDate: Date?
    var prevConditioningDate: Date?
    var details: PlantDetails?
    
    // dynamic computed properties for next dates
    var nextWateringDate: Date {
        guard let prevWateringDate = prevWateringDate, let wateringFreq = wateringFreq else {
            return Date() // default to today if data is unavailable
        }
        return Calendar.current.date(byAdding: .day, value: wateringFreq, to: prevWateringDate) ?? Date()
    }
    
    var nextConditioningDate: Date {
        guard let prevConditioningDate = prevConditioningDate, let conditioningFreq = conditioningFreq else {
            return Date() // default to today if data is unavailable
        }
        return Calendar.current.date(byAdding: .day, value: conditioningFreq, to: prevConditioningDate) ?? Date()
    }
    
    // Initializers
    init(plant: PlantModel) {
        self.id = UUID()
        self.plantId = plant.plantId
        self.name = plant.name
        self.room = RoomModel.exampleRoom
        self.imageUrl = plant.imageUrl
        self.category = plant.category
        self.species = plant.species
        self.descriptionText = plant.descriptionText
        self.details = plant.details
        self.waterAmountInML = plant.waterAmountInML
        self.wateringFreq = plant.wateringFreq
        self.conditioningFreq = plant.conditioningFreq
        self.dailySunExposure = plant.dailySunExposure
        self.prevWateringDate = plant.prevWateringDate
        self.prevConditioningDate = plant.prevConditioningDate
    }
    
    init(details: PlantDetails, conditioniingFreq: Int? = nil) {
        self.id = UUID()
        self.plantId = details.id
        self.name = details.name
        self.room = RoomModel.exampleRoom
        self.imageUrl = details.imageUrl
        self.category = details.category
        self.species = details.species
        self.descriptionText = details.descriptionText
        self.details = details
        self.waterAmountInML = details.wateringAmount
        self.wateringFreq = details.wateringFreq
        self.conditioningFreq = conditioningFreq
        self.dailySunExposure = details.sunhours
        self.prevWateringDate = Calendar.current.date(byAdding: .day, value: -(details.wateringFreq), to: Date())
        self.prevConditioningDate = conditioniingFreq == nil ? nil : Date()
       
    }
    
    init(id: UUID = UUID(), plantId: Int? = nil, room: RoomModel, name: String = "Unnamed Plant",
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
        self.prevWateringDate = Calendar.current.date(byAdding: .day, value: -(wateringFreq ?? 7), to: Date())
        self.wateringFreq = wateringFreq
        self.prevConditioningDate = prevWateringDate
        self.conditioningFreq = conditioningFreq
        self.details = details
    }
    
    // fetch details from API and create plant model
    static func createFromApi(plantId: Int, completion: @escaping (PlantModel?) -> Void) {
        PlantService.shared.getPlantDetails(for: plantId) { details in
            guard let details = details else {
                print("Failed to fetch plant details for plant ID: \(plantId)")
                completion(nil)
                return
            }
            
            // Initialize the plant model
            let plant = PlantModel(details: details, conditioniingFreq: 2) //losowe conditionning TO BE CHANGED!!!
            completion(plant)
        }
    }
    
    // CodingKeys
    enum CodingKeys: String, CodingKey {
        case id, plantId, name, room, descriptionText, imageUrl, category, species
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
        room = try container.decode(RoomModel.self, forKey: .room)
        descriptionText = try container.decodeIfPresent(String.self, forKey: .descriptionText)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        species = try container.decodeIfPresent(String.self, forKey: .species)
        waterAmountInML = try container.decodeIfPresent(Int.self, forKey: .waterAmountInML)
        dailySunExposure = try container.decodeIfPresent(Int.self, forKey: .dailySunExposure)
        prevWateringDate = try container.decodeIfPresent(Date.self, forKey: .prevWateringDate)
        wateringFreq = try container.decodeIfPresent(Int.self, forKey: .wateringFreq)
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
        try container.encode(room, forKey: .room)
        try container.encodeIfPresent(descriptionText, forKey: .descriptionText)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(species, forKey: .species)
        try container.encodeIfPresent(waterAmountInML, forKey: .waterAmountInML)
        try container.encodeIfPresent(dailySunExposure, forKey: .dailySunExposure)
        try container.encodeIfPresent(prevWateringDate, forKey: .prevWateringDate)
        try container.encodeIfPresent(wateringFreq, forKey: .wateringFreq)
        try container.encodeIfPresent(prevConditioningDate, forKey: .prevConditioningDate)
        try container.encodeIfPresent(conditioningFreq, forKey: .conditioningFreq)
        try container.encodeIfPresent(details, forKey: .details)
    }
    
    // Example Plant
    static var examplePlant = PlantModel(room: RoomModel.exampleRoom, name: "Example Plant", imageUrl: "ExamplePlant", waterAmountInML: 500, dailySunExposure: 6,
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
            _exampleApiPlant = PlantModel(room: RoomModel.exampleRoom, name: "Loading...", waterAmountInML: 0, dailySunExposure: 0,
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
    func waterThePlant(settings: SettingsModel) {
        self.prevWateringDate = Date() // ustaw dzisiejszą datę jako prevWateringDate
        let username = settings.username.isEmpty ? "there" : settings.username
        dispatchNotification(identifier: self.id.description, title: self.name + " is thirsty!", body: "Hey \(username), your plant needs to drink some water.", date: self.nextWateringDate)
    }
    
    func conditionThePlant(settings: SettingsModel) {
        self.prevConditioningDate = Date() // ustaw dzisiejszą datę jako prevWateringDate
        let username = settings.username.isEmpty ? "there" : settings.username
        dispatchNotification(identifier: self.id.description, title: self.name + " needs some care!", body: "Hey \(username), your plant might be a bit hungry", date: self.nextConditioningDate)
    }

    
    // check for errors
    var notificationsCount: Int {
        print(name)
        print(wateringFreq)
        print(nextWateringDate)
        print(prevWateringDate)
        print(conditioningFreq)
        print(nextConditioningDate)
        print(prevConditioningDate)
        var notifs = 0
        // check if nextWateringDate is overdue
        if nextWateringDate <= Date() {
            notifs += 1
        }
        // check if nextConditioningDate is overdue
        if nextConditioningDate <= Date() && (conditioningFreq != nil && conditioningFreq != 0){
            notifs += 1
        }
        return notifs
    }

    var isWatered: Bool {
        // check if nextWateringDate is in the future
        return nextWateringDate > Date()
    }
    
    var isConditioned: Bool {
        // check if nextConditioningDate is in the future
        return conditioningFreq == nil || nextConditioningDate > Date() || conditioningFreq == 0
    }

    func calculate_progress(prevWateringDate: Date?, wateringFreq: Int?) -> Double {
        // use current date if prevWateringDate is nil
        let prevDate = prevWateringDate ?? Date()
        
        // default watering frequency is 7 days if nil
        let frequency = wateringFreq ?? 7
        
        // calculate the number of seconds in a day
        let secondsInDay = 86400.0

        // calculate the time interval since the last watering
        let now = Date()
        let timeInterval = now.timeIntervalSince(prevDate)

        // calculate the number of days since the last watering
        let daysSinceWatering = timeInterval / secondsInDay

        // calculate the max interval for hydration (2 times wateringFreq)
        let maxInterval = Double(frequency * 2)

        // if the flower is over-dried
        if daysSinceWatering >= maxInterval {
            return 0.1
        }

        // calculate progress based on wateringFreq
        let progress = 1.0 - (daysSinceWatering / maxInterval)

        // ensure the result is clamped between 0.0 and 1.0
        return max(0.1, min(0.9, progress))
    }
    
    var progress: Double {
        return calculate_progress(prevWateringDate: self.prevWateringDate, wateringFreq: self.wateringFreq)
    }
}
