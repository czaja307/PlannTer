//
//  PlantDetails.swift
//  PlannTer
//
//  Created by zawodev on 21/11/2024.
//

import Foundation

struct PlantDetails: Codable {
    let id: Int
    let commonName: String?
    let scientificName: [String]?
    let otherName: [String]?
    let family: String?
    let origin: [String]?
    let type: String?
    let dimension: String?
    let dimensions: Dimensions?
    let cycle: String?
    let attracts: [String]?
    let propagation: [String]?
    let hardiness: Hardiness?
    let watering: String?
    let sunlight: [String]?
    let pruningMonth: [String]?
    let seeds: Int?
    let growthRate: String?
    let careLevel: String?
    let flowers: Bool?
    let leaf: Bool?
    let leafColor: [String]?
    let cones: Bool?
    let medicinal: Bool?
    let descriptionText: String?
    let defaultImage: DefaultImage?
    
    // computed property: category (last word of commonName)
    var category: String? {
        guard let name = commonName else { return nil }
        let components = name.split(separator: " ")
        return components.last.map(String.init)
    }
    // computed property: species (all but the last word of commonName)
    var species: String? {
        guard let name = commonName else { return nil }
        let components = name.split(separator: " ")
        guard components.count > 1 else { return nil }
        return components.dropLast().joined(separator: " ")
    }
}

struct Dimensions: Codable {
    let type: String?
    let minValue: Int?
    let maxValue: Int?
    let unit: String?
}

struct Hardiness: Codable {
    let min: String?
    let max: String?
}

struct DefaultImage: Codable {
    let originalURL: String?
    let regularURL: String?
    let mediumURL: String?
    let smallURL: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case originalURL = "original_url"
        case regularURL = "regular_url"
        case mediumURL = "medium_url"
        case smallURL = "small_url"
        case thumbnail
    }
}
