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
    let family: String?
    let type: String?
    let watering: String?
    let wateringGeneralBenchmark: WateringGeneralBenchmark?
    let sunlight: [String]?
    let descriptionText: String?
    let defaultImage: DefaultImage?

    var name: String{
        commonName ?? "flowering-maple"
    }
    
    // computed property: category (last word of commonName)
    var category: String? {
        guard let name = commonName else { return nil }
        let components = name.split { $0 == " " || $0 == "-" }
        return components.last.map(String.init)
    }

    // computed property: species (all but the last word of commonName)
    var species: String? {
        guard let name = commonName else { return nil }
        let components = name.split { $0 == " " || $0 == "-" }
        guard components.count > 1 else { return nil }
        return components.dropLast().joined(separator: " ")
    }
    
    // computed property: imageUrl
    var imageUrl: String {
        return defaultImage?.originalURL ??
               defaultImage?.regularURL ??
               defaultImage?.mediumURL ??
               defaultImage?.smallURL ??
               defaultImage?.thumbnail ??
               "ExamplePlant"
    }

    // computed property: wateringAmount
    var wateringAmount: Int {
        switch watering?.lowercased() {
        case "frequent": return 900
        case "average": return 400
        case "minimum": return 200
        case "none": return 0
        default: return 400 // default value
        }
    }

    // computed property: wateringFreq
    var wateringFreq: Int {
        if let benchmark = wateringGeneralBenchmark?.value {
            let range = benchmark.split(separator: "-").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
            if range.count == 2 {
                return (range[0] + range[1]) / 2
            } else if range.count == 1 {
                return range[0]
            }
        }
        return 3 // default value
    }
    
    var conditioningFreq: Int {
        return wateringFreq * 2
    }

    // computed property: sunhours
    var sunhours: Int {
        guard let sunlightArray = sunlight else { return 3 } // default
        let sunlightMapping: [String: Int] = [
            "full_shade": 0,
            "part_shade": 1,
            "sun-part_shade": 3,
            "full_sun": 5
        ]
        let formattedArray = sunlightArray.map { $0.lowercased().replacingOccurrences(of: " ", with: "_") }
        let hoursArray = formattedArray.compactMap { sunlightMapping[$0] }
        return !hoursArray.isEmpty ? Int(round(Double(hoursArray.reduce(0, +)) / Double(hoursArray.count))) : 3
    }

    private enum CodingKeys: String, CodingKey {
        case id, commonName = "common_name", family, type, watering, wateringGeneralBenchmark, sunlight, descriptionText = "description", defaultImage
    }
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

struct WateringGeneralBenchmark: Codable {
    let value: String?
}
