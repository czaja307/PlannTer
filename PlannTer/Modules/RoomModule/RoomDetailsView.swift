import SwiftUI

struct RoomDetailsView: View {
    @StateObject private var controller = RoomDetailsController()

    var body: some View {
        NavigationView {
            List(PlantModel.examplePlants) { plant in
                VStack(alignment: .leading) {
                    Text(plant.name).font(.headline)
                    
                    HStack {
                        Text("Water level: ")
                        Text(String(plant.waterAmountInML))
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    RoomDetailsView()
}
