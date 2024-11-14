import SwiftUI

struct RoomEditView: View {
    @StateObject private var controller = RoomEditController()
    @FocusState private var isFocused: Bool
    
    var body: some View {
         ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
             Color.clear
                 .contentShape(Rectangle())
                 .onTapGesture {
                     isFocused = false
                 }
            VStack {
                ScreenTitle(title: "Room Settings")
                    .padding(.top, 20)
                
                TextInput(title: "Give your room a memorable name", prompt: "Green Sanctuary", isActive: $isFocused)
                    .padding(20)
                Spacer()
                LargeButton(title: "Save room", action: controller.saveRoom)
            }
        }
    }
}


#Preview {
    RoomEditView()
}
