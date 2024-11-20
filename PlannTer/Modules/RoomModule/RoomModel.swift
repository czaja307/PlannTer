import Foundation

enum WindowPosition: String, Codable {
    case north
    case northEast = "north-east"
    case east
    case southEast = "south-east"
    case south
    case southWest = "south-west"
    case west
    case northWest = "north-west"
}

struct RoomModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var plants: [PlantModel]
    var windows: [WindowPosition]
    var numWarnings : Int
}

struct MockRoom {
    static let sampleRoom = RoomModel(name: "Test Room", plants: MockPlant.plants, windows: [.southEast, .south], numWarnings: 3)
    static let otherRoom = RoomModel(name: "Other Room", plants: MockPlant.plants, windows: [.north], numWarnings: 0)
    static let rooms = [sampleRoom, otherRoom, otherRoom, sampleRoom, otherRoom, otherRoom, sampleRoom]
}

extension RoomModel {
    static let placeholder = RoomModel(id: UUID(), name: "Add Room", plants: [], windows:[], numWarnings: 0)
}
