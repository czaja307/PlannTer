import SwiftUI

struct MainScreenView: View {
    @StateObject private var controller = MainScreenController()
    
    var body: some View {
        ZStack {
            Image("CorkBackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            VStack {
                AppTitle()
                    .padding(.top, 20)
                Spacer()
            } 
        }.background(white)
    }
}


#Preview {
    MainScreenView()
}
