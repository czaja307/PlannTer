import SwiftUI

struct PlantDetailsView: View {
    @StateObject private var controller = PlantDetailsController()
    


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
