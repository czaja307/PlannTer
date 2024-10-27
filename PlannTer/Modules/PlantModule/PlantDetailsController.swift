import Foundation

class PlantDetailsController: ObservableObject {
    @Published var plant: PlantModel
    
    init(plant: PlantModel) {
        self.plant = plant
    }
}