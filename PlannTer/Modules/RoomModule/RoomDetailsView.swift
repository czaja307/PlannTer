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
                NavigationLink(destination: PlantEditView(title: "Add Plant")){
                    CreatePlantTile()
                }
                
            }
            .padding(.horizontal,10)
            .padding(.vertical, 10)
            .navigationBarBackButtonHidden(true)
            .roomToolbar(title: title, sunHours: 5, presentationMode: presentationMode)
            .ignoresSafeArea()
            .background(Color.primaryBackground)
        
    }
}

#Preview {
    RoomDetailsView(title:"Title")
}
