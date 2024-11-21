struct PlantData: Codable {
    let id: Int
    let commonName: String
    let scientificName: String
}

struct PlantDetails: Codable {
    let id: Int
    let commonName: String
    let waterRequirements: String
    let sunlightRequirements: String
    let careTips: [String]
}
