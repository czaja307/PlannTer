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
            .roomToolbar(title: title, sunHours: 5, presentationMode: presentationMode)
            .background(Color.primaryBackground)
        
    }
}

#Preview {
    RoomDetailsView(title:"Title")
}
