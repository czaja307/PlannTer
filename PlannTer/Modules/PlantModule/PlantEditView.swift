import SwiftUI

struct PlantEditView: View {
    @StateObject private var controller = PlantEditController()
    
    var body: some View {
         ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScreenTitle(title: "Plant Settings")
                    .padding(.top, 20)
                Spacer()
            } 
        }
    }
}
