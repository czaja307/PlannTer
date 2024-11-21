import SwiftUI

struct RoomDetailsView: View {
    let title : String
    @StateObject private var controller = RoomDetailsController()
    @Environment(\.presentationMode) var presentationMode // To handle back navigation
    var body: some View {
        
            ScrollView(.vertical){
                ForEach(PlantModel.examplePlants) { plant in
                    NavigationLink(destination: PlantDetailsView()){
                        PlantTile(plant: plant)
                    }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width)
                NavigationLink(destination: PlantEditView(title: "Add Plant")){
                    CreatePlantTile()
                }
            
            }
            .navigationBarBackButtonHidden(true)
            .customToolbar(title: title, presentationMode: presentationMode)
        
    }
        
}

#Preview {
    RoomDetailsView(title:"Title")
}
