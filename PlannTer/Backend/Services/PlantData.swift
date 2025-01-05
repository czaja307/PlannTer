import Foundation

struct APIResponse: Codable {
    let data: [PlantData]
}

struct PlantData: Codable {
    let id: Int
    let commonName: String?
    let scientificName: [String]?
    let otherName: [String]?
    let cycle: String?
    let watering: String?
    let sunlight: [String]?
    let defaultImage: ImageData?
    
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

    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case otherName = "other_name"
        case cycle
        case watering
        case sunlight
        case defaultImage = "default_image"
    }
}


// if let imageUrl = plant.defaultImage?.thumbnail {
//   print("Thumbnail URL: \(imageUrl)")
// } else {
//   print("No image available for plant \(plant.commonName ?? "Unknown")")
// }

struct ImageData: Codable {
    let license: Int?
    let licenseName: String?
    let licenseURL: String?
    let originalURL: String?
    let regularURL: String?
    let mediumURL: String?
    let smallURL: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case license
        case licenseName = "license_name"
        case licenseURL = "license_url"
        case originalURL = "original_url"
        case regularURL = "regular_url"
        case mediumURL = "medium_url"
        case smallURL = "small_url"
        case thumbnail
    }
}
