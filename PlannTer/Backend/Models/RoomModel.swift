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
    var id: UUID = UUID()  // jakieś unikalne id (nie wiem czy potrzebne tbh)
    var name: String  // nazwa pokoju
    var direction: Direction  // kierunek geograficzny oświetlenia
    var plants: [PlantModel]  // lista roślin w pokoju

    // funkcja do dodawania rośliny do pokoju
    mutating func addPlant(_ plant: PlantModel) {
        plants.append(plant)
    }

    //funkcja do usuwania rośliny z pokoju po ID
    mutating func removePlant(byId plantId: UUID) {
        plants.removeAll { $0.id == plantId }
    }

    // funkcja do zaktualizowania nazwy pokoju
    mutating func updateRoomName(to newName: String) {
        name = newName
    }

    // funkcja do zaktualizowania kierunku oświetlenia
    mutating func updateDirection(to newDirection: Direction) {
        direction = newDirection
    }
}
