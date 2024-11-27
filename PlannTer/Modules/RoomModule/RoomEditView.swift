import SwiftUI

struct RoomEditView: View {
    @StateObject private var controller = RoomEditController()
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode

    
    @State private var dummyInputText: String = ""

    let columns: [GridItem] = [
            GridItem(.flexible()), // First column
            GridItem(.flexible()), // Second column
            GridItem(.flexible())  // Third column
        ]
    
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
                
                TextInput(title: "Give your room a memorable name", prompt: "Green Sanctuary", inputText: $dummyInputText, isActive: $isFocused)
                    .padding(20)
                Spacer()
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(0..<9, id: \.self) { index in
                                if(index != 4){
                                    if(controller.windows[index]) {
                                        Button(action: {controller.selectedWindow(index: index)}){
                                            Image("GreenGrid\(index)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 70, height: 70)
                                        }
                                    }
                                    else {
                                        Button(action: {controller.selectedWindow(index: index)}){
                                            Image("Grid\(index)")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 70, height: 70)
                                        }
                                    }
                                }else{
                                    Image("Grid4")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                }
                            }
                        }
                        .frame(width: 230, height: 230)
                
                Spacer()
                LargeButton(title: "Save room", action: controller.saveRoom)
                    .padding(20)
            }
        }
         .navigationBarBackButtonHidden(true)
         .customToolbar(title: "Edit Room", presentationMode: presentationMode)
    }
}


#Preview {
    RoomEditView()
}
