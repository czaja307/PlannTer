import SwiftUI

struct RoomEditView: View {
    @StateObject private var controller = RoomEditController()
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    
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
                
                TextInput(title: "Give your room a memorable name", prompt: "Green Sanctuary", isActive: $isFocused)
                    .padding(20)
                Spacer()
                LargeButton(title: "Save room", action: controller.saveRoom)
            }
        }
         .navigationBarBackButtonHidden(true)
         .customToolbar(title: "Edit Room", presentationMode: presentationMode)
    }
}


#Preview {
    RoomEditView()
}
