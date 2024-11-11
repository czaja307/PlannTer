import SwiftUI

struct MainScreenView: View {
    @StateObject private var controller = MainScreenController()
    
    var body: some View {
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
        }.background(.white)
    }
}


struct HorizontalScrollView<T: Identifiable, Content: View>: View {
    let items: [T]
    let filter: (T) -> Bool
    let content: (T) -> Content

    init(items: [T], filter: @escaping (T) -> Bool, @ViewBuilder content: @escaping (T) -> Content) {
        self.items = items
        self.filter = filter
        self.content = content
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 35) {
                ForEach(items.filter(filter)) { item in
                    content(item)
                }
            }
            .padding()
        }
    }
}


struct Tiles: View{
    let roomsList : [RoomModel]
    let appendTop = roomsList.count % 2 == 0
    var body: some View{
        NavigationView{
            VStack{
                HorizontalScrollView(items: appendTop ? roomsList + [RoomModel.addRoomPlaceholder] : roomsList, filter: { $0.id.uuidString.hashValue % 2 == 0 }) { room in
                    if room.id == RoomModel.addRoomPlaceholder.id {
                        NavigationLink(destination: RoomEditView()) {
                            AddRoomTile(listPosition: roomsList.count)
                        }
                    } else {
                        NavigationLink(destination: RoomDetailsView(room: room)) {
                            RoomTile(roomName: room.name, roomWarnings: room.numWarnings, numPlants: room.plants.count, listPosition: Int(room.id.uuidString.hashValue))
                        }
                    }
                }
                HorizontalScrollView(items: appendTop ? roomsList : roomsList + [RoomModel.addRoomPlaceholder], filter: { $0.id.uuidString.hashValue % 2 == 1 }) { room in
                    if room.id == RoomModel.addRoomPlaceholder.id {
                        NavigationLink(destination: RoomEditView()) {
                            AddRoomTile(listPosition: roomsList.count)
                        }
                    } else {
                        RoomTile(roomName: room.name, roomWarnings: room.numWarnings, numPlants: room.plants.count, listPosition: Int(room.id.uuidString.hashValue))
                    }
                }
                .padding(.leading, 35)
            }
        }
    }
}

#Preview {
    MainScreenView()
}
