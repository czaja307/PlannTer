import SwiftUI

struct RoomDetailsView: View {
    @State private var refresh = false
    @Bindable var room: RoomModel
    @State private var tempList : [PlantModel] = []
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode // To handle back navigation
    var body: some View {
        ScrollView(.vertical){
            ForEach(tempList) { plant in
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
        .roomToolbar(title: room.name, sunHours: Int(room.getsunlight), presentationMode: presentationMode, room: room)
        .ignoresSafeArea()
        .background(Color.primaryBackground)
        .onAppear {
            tempList = room.plants
        }
    }
    
    func deleteAction(plant: PlantModel) {
        let idToRemove = room.plants.firstIndex(of: plant)
        if(idToRemove != nil){
            tempList.remove(at: idToRemove!)
            if (plant.imageUrl != nil && plant.imageUrl != "ExamplePlant") {
                LocalFileManager.instance.deleteImage(name: plant.imageUrl!)
            }
            context.delete(plant)
            do {
                try context.save()
            } catch {}
            refresh.toggle()
            
        }
    }
}
