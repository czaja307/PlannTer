import SwiftUI

struct RoomDetailsView: View {
    @StateObject private var controller = RoomDetailsController()
    
    var body: some View {
        NavigationView {
            List(MockPlant.plants) { plant in
                VStack(alignment: .leading) {
                    Text(plant.name).font(.headline)
                    
                    HStack {
                        Text("Water level: ")
                        Text(String(plant.waterLevel))
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
