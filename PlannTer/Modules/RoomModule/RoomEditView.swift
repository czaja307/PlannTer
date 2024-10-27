import SwiftUI

struct RoomEditView: View {
    @StateObject private var controller = RoomEditController()
    
    var body: some View {
         ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScreenTitle(title: "Room Settings")
                    .padding(.top, 20)
                Spacer()
            } 
        }
    }
}
