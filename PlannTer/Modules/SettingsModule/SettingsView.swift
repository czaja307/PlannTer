import SwiftUI

struct SettingsView: View {
    @StateObject private var controller = SettingsController()
    
    var body: some View {
         ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScreenTitle(title: "Settings")
                    .padding(.top, 20)
                Spacer()
            } 
        }
    }
}
