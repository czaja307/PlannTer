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
    let depthWaterRequirement: DepthWaterRequirement?
    let volumeWaterRequirement: VolumeWaterRequirement?
    let wateringPeriod: String?
    let wateringGeneralBenchmark: WateringGeneralBenchmark?
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
    
    // computed property: wateringAmount
    var wateringAmount: Int? {
        // obliczenie ilości wody w mililitrach
        if let volumeStr = volumeWaterRequirement?.value,
           let volume = Double(volumeStr),
           let unit = volumeWaterRequirement?.unit?.lowercased() {
            switch unit {
            case "mm":
                return Int(volume * 1000) // mm -> ml
            case "feet":
                return Int(volume * 28_316.8) // feet -> ml
            case "inches":
                return Int(volume * 16_387.064) // inches -> ml
            default:
                return nil
            }
        }
        
        if let depthStr = depthWaterRequirement?.value,
           let depth = Double(depthStr),
           let unit = depthWaterRequirement?.unit?.lowercased() {
            switch unit {
            case "mm":
                return Int(depth * 500) // uproszczona zależność (np. połowa w mililitrach)
            case "inches":
                return Int(depth * 500 * 2) // uproszczenie dla inches (np. 2x więcej niż dla mm)
            default:
                return nil
            }
        }
        
        // fallback na podstawie watering
        switch watering?.lowercased() {
        case "frequent": return 900
        case "average": return 400
        case "minimum": return 200
        case "none": return 0
        default: return nil
        }
    }
    
    // computed property: wateringFreq
    var wateringFreq: Int? {
        // obliczenie częstotliwości podlewania w dniach
        if let benchmark = wateringGeneralBenchmark?.value {
            let range = benchmark.split(separator: "-").compactMap { Int($0) }
            if range.count == 2 {
                let average = (range[0] + range[1]) / 2
                return average
            }
        }
        
        // fallback na podstawie watering
        switch watering?.lowercased() {
        case "frequent": return 1
        case "average": return 3
        case "minimum": return 7
        case "none": return nil
        default: return nil
        }
    }
}

// additional structs
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

// new structs
struct DepthWaterRequirement: Codable {
    let unit: String?
    let value: String?
}

struct VolumeWaterRequirement: Codable {
    let unit: String?
    let value: String?
}

struct WateringGeneralBenchmark: Codable {
    let value: String?
    let unit: String?
}
