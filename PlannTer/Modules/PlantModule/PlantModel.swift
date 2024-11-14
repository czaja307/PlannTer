import Foundation

struct PlantModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var imgUrl: String
    var waterLevel: Int
    var waterPortionSize: Int
}

struct MockPlant {
    static let samplePlant = PlantModel(id: UUID(), name: "Test Plant", imgUrl: "", waterLevel: 21, waterPortionSize: 37)
    
    static let plants = [samplePlant, samplePlant, samplePlant, samplePlant]
}
