import SwiftUI

struct RoomDetailsView: View {
    @Bindable var room: RoomModel
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode // To handle back navigation
    var body: some View {
        ScrollView(.vertical){
            ForEach(room.plants) { plant in
                NavigationLink(destination: PlantDetailsView(plant: plant)){
                    PlantTile(plant: plant, deleteAction: deleteAction)
                }
                
            }
            NavigationLink(destination: PlantAddView(room: room)){
                CreatePlantTile()
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical, 10)
        .navigationBarBackButtonHidden(true)
        .roomToolbar(title: room.name, sunHours: 5, presentationMode: presentationMode, room: room)
        .ignoresSafeArea()
        .background(Color.primaryBackground)
    }
    
    func deleteAction(plant: PlantModel) {
        let idToRemove = room.plants.firstIndex(of: plant)
        if(idToRemove != nil){
            room.plants.remove(at: idToRemove!)
            context.delete(plant)
        }
    }
}
