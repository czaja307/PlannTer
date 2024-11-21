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
//                                .font(.imageScale(.large))
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

struct Tiles: View {
    var roomsList : [RoomModel]
    private var appendTop: Bool
    
    init(roomsList:[RoomModel]) {
        self.roomsList = roomsList
        appendTop = roomsList.count % 2 == 0 ? true : false
    }
    
    var body: some View {
        VStack {
            // to gowno nie dziala nie wiem kto to pisal ale sie nie kompiluje
            /*
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 100) {
                    ForEach(Array(roomsList.enumerated()).filter { $0.offset % 2 == 0 }, id: \.1.id) { i, room in
                        RoomTile(roomName: room.name, roomWarnings: room.numWarnings, numPlants: room.plants.count, listPosition: i)
                    }
                    if (appendTop) {
                        AddRoomTile(listPosition: 0)
                            .padding(.leading, 20)
                    }
                }
                .padding()
                HStack(spacing: 100) {
                    ForEach(Array(roomsList.enumerated()).filter { $0.offset % 2 == 1 }, id: \.1.id) { i, room in
                        NavigationLink(destination: RoomDetailsView()) {
                            RoomTile(roomName: room.name, roomWarnings: room.numWarnings, numPlants: room.plants.count, listPosition: i)
                        }
                    }
                    if (!appendTop) {
                        AddRoomTile(listPosition: 1)
                            .padding(.leading, 20)
                    }
                }
                .padding(.leading, 200)
            }
            .frame(width: 500)
             */
        }
    }
}

#Preview {
    MainScreenView()
}
