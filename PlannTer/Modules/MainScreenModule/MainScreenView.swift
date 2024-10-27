import SwiftUI

struct MainScreenView: View {
    @StateObject private var controller = MainScreenController()
    
    var body: some View {
        ZStack {
            Image("corkBackgorund")
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                AppTitle()
                    .padding(.top, 20)
                Spacer()
            } 
        }
    }
}
