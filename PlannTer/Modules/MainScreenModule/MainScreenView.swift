import SwiftUI

struct MainScreenView: View {
    @StateObject private var controller = MainScreenController()
    
    var body: some View {

        NavigationView{
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

                        Tiles(roomsList: controller.rooms)

                } 
                VStack{
                    Spacer()
                    HStack{
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .foregroundColor(.primaryText)
                        }
                        .frame(width: 70, height: 70)
                        .background(Color(.primaryBackground))
                        .cornerRadius(45)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)   

            }.background(.white)
        }
        
    }
}

struct Tiles: View{
    var roomsList : [RoomModel]
    private var appendTop: Bool
    
    init(roomsList:[RoomModel]) {
        self.roomsList = roomsList
        appendTop = roomsList.count % 2 == 0 ? true : false
    }
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            VStack{
                RoomScrollView(rooms: evenIndexedRooms, appendTile: appendTop, isTop: true)
                RoomScrollView(rooms: oddIndexedRooms, appendTile: !appendTop, isTop: false)
                
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
    
    init(rooms: [RoomModel], appendTile: Bool, isTop: Bool) {
        self.rooms = rooms
        self.appendTile = appendTile
        self.tilePosition = isTop ? 0 : 1
    }
    
    
    var body: some View {
        
            HStack(spacing: 100) {
                ForEach(rooms) { room in
                    NavigationLink(destination: RoomDetailsView(title: room.name)) {
                        RoomTile(roomName: room.name, roomWarnings: room.numWarnings, numPlants: room.plants.count, listPosition: tilePosition)
                    }
                }
                if appendTile {
                    NavigationLink(destination: RoomEditView()) {
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
    MainScreenView()
}
