import SwiftUI

struct SettingsView: View {
    @StateObject private var controller = SettingsController()
    
    var body: some View {
         ZStack {
             Rectangle().fill(Color.customPrimaryBackground)
                 .edgesIgnoringSafeArea(.all)
//            Color(.customPrimaryBackground)
//                .edgesIgnoringSafeArea(.all)
            VStack {
                ScreenTitle(title: "Settings")
                    .padding(.top, 20)
                Spacer()
            } 
        }
    }
}

#Preview{
    SettingsView()
}