import SwiftUI

struct RoomDetailsView: View {
    @Bindable var room: RoomModel
    @StateObject private var controller = RoomDetailsController()
    @Environment(\.presentationMode) var presentationMode // To handle back navigation
    var body: some View {
        ScrollView(.vertical){
            ForEach(room.plants) { plant in
                NavigationLink(destination: PlantDetailsView(plant: plant)){
                    PlantTile(plant: plant)
                }
                
            }
            NavigationLink(destination: PlantAddView(room: room)){
                CreatePlantTile()
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical, 10)
        .navigationBarBackButtonHidden(true)
        .roomToolbar(title: room.name, sunHours: 5, presentationMode: presentationMode)
        .ignoresSafeArea()
        .background(Color.primaryBackground)
    }
}
