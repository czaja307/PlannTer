//
//  RoomModel.swift
//  PlannTer
//
//  Created by zawodev on 13/11/2024.
//

import Foundation

// enum do 8 kierunków geograficznych
enum Direction: String, Codable, CaseIterable {
    case north = "North"
    case northEast = "North-East"
    case east = "East"
    case southEast = "South-East"
    case south = "South"
    case southWest = "South-West"
    case west = "West"
    case northWest = "North-West"
}


struct RoomModel: Codable, Identifiable {
    var id: UUID = UUID()  // unikalne id
    var name: String  // nazwa pokoju
    var directions: [Direction]  // tablica kierunków oświetlenia
    var plants: [PlantModel]  // lista roślin w pokoju

    // Funkcja do dodawania rośliny do pokoju
    mutating func addPlant(_ plant: PlantModel) {
        plants.append(plant)
    }

    // Funkcja do usuwania rośliny z pokoju po ID
    mutating func removePlant(byId plantId: UUID) {
        plants.removeAll { $0.id == plantId }
    }

    // Funkcja do zaktualizowania nazwy pokoju
    mutating func updateRoomName(to newName: String) {
        name = newName
    }

    // Funkcja do zaktualizowania kierunków oświetlenia
    mutating func updateDirections(to newDirections: [Direction]) {
        directions = newDirections
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
}
