//
//  RoomModel.swift
//  PlannTer
//
//  Created by zawodev on 13/11/2024.
//

import Foundation
import SwiftData

// enum do 8 kierunków geograficznych (deprecated)
enum Direction: String, Codable, CaseIterable {
    case north = "N"
    case northEast = "NE"
    case east = "E"
    case southEast = "SE"
    case south = "S"
    case southWest = "SW"
    case west = "W"
    case northWest = "NW"
}

struct ApproxSunlight { //now this is fucking dumb
    let sunlightHours: [String: Int]
    static let average: ApproxSunlight = ApproxSunlight(sunlightHours: [
        "N": 2,
        "NE": 3,
        "E": 4,
        "SE": 5,
        "S": 5,
        "SW": 5,
        "W": 4,
        "NW": 3
    ])
    //usage:
    //ApproxSunlight.average.sunlightHours["S"]
    //ApproxSunlight.average.sunlightHours[Direction.north] (works too)
}

@Model
class RoomModel: Identifiable, Codable {
    var id: UUID = UUID()  // unikalne id
    @Attribute(.unique)
    var name: String  // nazwa pokoju
    var directions: [Direction]  // tablica kierunków oświetlenia
    @Relationship(deleteRule: .cascade, inverse: \PlantModel.room)
    var plants: [PlantModel]  // lista roślin w pokoju

    init(name: String, directions: [Direction], plants: [PlantModel]) {
        self.id = UUID()
        self.name = name
        self.directions = directions
        self.plants = plants
    }

    enum CodingKeys: String, CodingKey {
        case id, name, directions, plants
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        directions = try container.decode([Direction].self, forKey: .directions)
        plants = try container.decode([PlantModel].self, forKey: .plants) // Decode array of PlantModel
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(directions, forKey: .directions)
        try container.encode(plants, forKey: .plants) // Encode array of PlantModel
    }
    
    var notificationsCount: Int {
        return plants.reduce(0) { $0 + $1.notificationsCount } //fancy sumowanie kwiatkow
    }
    
    var plantCount: Int {
        return plants.count
    }

    static var exampleRoom: RoomModel {
        return RoomModel(
            name: "Example Room",
            directions: [.north, .east],
            plants: [
                PlantModel.examplePlant,
                PlantModel.examplePlant
            ]
        )
    }
    
    static func getRoom(name: String, fromRooms: [RoomModel]) -> RoomModel? {
        return fromRooms.first { $0.name == name }
    }
}
