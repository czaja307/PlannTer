import SwiftUI
import SwiftData

struct RoomAddView: View {
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    
    @State private var roomName: String = ""
    @State private var windows = Array(repeating: false, count: 9)
    
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
                
                TextInput(title: "Give your room a memorable name", prompt: "Green Sanctuary", inputText: $roomName, isActive: $isFocused)
                    .padding(20)
                Spacer()
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(0..<9, id: \.self) { index in
                        if(index != 4){
                            if(windows[index]) {
                                Button(action: {selectedWindow(index: index)}){
                                    Image("GreenGrid\(index)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                }
                            }
                            else {
                                Button(action: {selectedWindow(index: index)}){
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
                LargeButton(title: "Save room", action: saveRoom)
                    .padding(20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .customToolbar(title: "Add new room", presentationMode: presentationMode)
    }
    
    private func saveRoom() {
        let newRoom = RoomModel(name: roomName, directions: [], plants: [])
        context.insert(newRoom)
        
        do {
            try context.save()
        } catch {
            print("Failed to save room: \(error)")
        }
        
        // Dismiss the view
        presentationMode.wrappedValue.dismiss()
    }
    
    private func selectedWindow(index: Int) {
        windows[index].toggle()
    }
}


