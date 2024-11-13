//
//  RoomModel.swift
//  PlannTer
//
//  Created by huj(zawodev) on 13/11/2024.
//

import Foundation

// Enum do reprezentowania 8 kierunków geograficznych
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
    var id: UUID = UUID()  // Unikalny identyfikator pokoju
    var name: String  // Nazwa pokoju
    var direction: Direction  // Kierunek geograficzny oświetlenia
    var plants: [PlantModel]  // Lista roślin w pokoju

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

    // Funkcja do zaktualizowania kierunku oświetlenia
    mutating func updateDirection(to newDirection: Direction) {
        direction = newDirection
    }
}
