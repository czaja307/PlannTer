import SwiftUI
import SwiftData

struct MainScreenView: View {
    @Environment(SettingsModel.self) private var settings
    @Environment(\.modelContext) private var context
    @Query var roomList: [RoomModel]
    
    var body: some View {

        NavigationStack{
            ZStack {
                Image("CorkBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5)
                VStack {
                    AppTitle()
                        .padding(.top, 20)
                    Tiles(roomsList: roomList, deleteAction: deleteAction)

                } 
                VStack{
                    Spacer()
                    HStack{
                        NavigationLink(destination: SettingsView(settings: settings)) {
                            Image(systemName: "gear")
                                .foregroundColor(.primaryText)
                                .accessibilityIdentifier("settingsButton")
                        }
                        .frame(width: 70, height: 70)
                        .background(Color(.primaryBackground))
                        .cornerRadius(45)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.bottom, 20)

            }.background(.white)
        }
        
    }
    
    func deleteAction(room: RoomModel) {
        for plant in room.plants {
            plant.room = RoomModel.exampleRoom
            if (plant.imageUrl != nil && plant.imageUrl != "ExamplePlant") {
                LocalFileManager.instance.deleteImage(name: plant.imageUrl!)
            }
            context.delete(plant)
        }

        context.delete(room)
        do {
            try context.save()
        } catch {}
    }
}

struct Tiles: View{
    var roomsList: [RoomModel]
    let deleteAction: (RoomModel) -> Void
    private var appendTop: Bool
    
    init(roomsList:[RoomModel], deleteAction: @escaping (RoomModel) -> Void) {
        self.roomsList = roomsList
        self.roomsList.removeAll { $0.name.isEmpty }
        appendTop = roomsList.count % 2 == 1 ? true : false
        self.deleteAction = deleteAction
    }
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            VStack{
                RoomScrollView(rooms: evenIndexedRooms, appendTile: appendTop, isTop: true, deleteAction: deleteAction)
                RoomScrollView(rooms: oddIndexedRooms, appendTile: !appendTop, isTop: false, deleteAction: deleteAction)
                
            }
        }.frame(width: 400)
    }
    private var evenIndexedRooms: [RoomModel] {
           roomsList.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }
       }
       
    private var oddIndexedRooms: [RoomModel] {
           roomsList.enumerated().filter { $0.offset % 2 == 1 }.map { $0.element }
       }
}


struct RoomScrollView: View {
    let rooms: [RoomModel]
    let appendTile: Bool
    let tilePosition: Int
    let deleteAction: (RoomModel) -> Void
    
    init(rooms: [RoomModel], appendTile: Bool, isTop: Bool, deleteAction: @escaping (RoomModel) -> Void) {
        self.rooms = rooms
        self.appendTile = appendTile
        self.tilePosition = isTop ? 0 : 1
        self.deleteAction = deleteAction
    }
    
    
    var body: some View {
        
            HStack(spacing: 100) {
                ForEach(rooms) { room in
                    NavigationLink(destination: RoomDetailsView(room: room)) {
                        RoomTile(room: room, listPosition: tilePosition, deleteAction: deleteAction)
                    }
                }
                if appendTile {
                    NavigationLink(destination: RoomAddView()) {
                        AddRoomTile(listPosition: tilePosition)
                            .padding(.leading, 20)
                    }
                }
            }
            .padding(.top, 50)
            .padding(.leading, CGFloat(tilePosition * 100))
            .padding(.bottom, 2)
        
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SettingsModel.self, RoomModel.self, PlantModel.self, configurations: config)
    let mockSettings = SettingsModel()


    MainScreenView()
            .modelContainer(container)
            .environment(mockSettings)
}
