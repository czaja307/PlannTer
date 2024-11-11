import SwiftUI

struct PlantDetailsView: View {
    //CZA: idk why it work like this but it builds
    @StateObject private var controller = PlantDetailsController(plant: PlantModel(id: UUID(), name: "Edytka", imageUrl: "AddSymbol", waterRequirement: 500, waterPortionSize: 500))


    var body: some View {
         ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScreenTitle(title: controller.plant.name)
                    .padding(.top, 20)
                Spacer()
            } 
        }
    }
}
