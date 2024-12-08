import SwiftUI
import SwiftData

struct RoomEditView: View {
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @Bindable var room: RoomModel
    @Query var roomList: [RoomModel]
    @State var nameExists: Bool = false
    
    @State private var roomName: String = ""
    @State private var origName: String = ""
    @State private var windows = Array(repeating: false, count: 9)
    private let dirNames = [
        Direction.northWest, Direction.north, Direction.northEast,
        Direction.west, Direction.west, Direction.east,
        Direction.southWest, Direction.south, Direction.southEast
    ]
    
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
                    .onAppear() {
                        origName = roomName
                    }
                    .onChange(of: roomName) {
                        let found = RoomModel.getRoom(name: roomName, fromRooms: roomList)
                        nameExists = (found != nil) && (roomName != origName)
                    }
                if(nameExists) {
                    Text("A room with such a name already exists, choose a different name!")
                        .padding(.horizontal, 30)
                        .font(.note)
                        .foregroundColor(Color.red)
                }
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
            .onAppear() {
                roomName = room.name
                let windows = dirNames.map { room.directions.contains($0) }
            }
        }
        .navigationBarBackButtonHidden(true)
        .customToolbar(title: "Edit room", presentationMode: presentationMode)
    }
    
    private func selectedWindow(index: Int) {
        windows[index].toggle()
    }
    
    private func saveRoom() {
        if (!nameExists && roomName != "") {
            var dirs: [Direction] = []
            for (i, v) in windows.enumerated() { if(v){dirs.append(dirNames[i])}}
            room.directions = dirs
            room.name = roomName
            context.insert(room)
            do {
                try context.save()
            } catch {
                print("Failed to save room: \(error)")
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    RoomEditView(room: RoomModel.exampleRoom)
}
