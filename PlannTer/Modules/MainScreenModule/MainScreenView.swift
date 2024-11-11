import SwiftUI

struct MainScreenView: View {
    @StateObject private var controller = MainScreenController()
    
    var body: some View {
        NavigationView() {
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
}


//struct HorizontalScrollView<T: Identifiable, Content: View>: View {
//    let items: [T]
//    let filter: (T) -> Bool
//    let content: (T) -> Content
//
//    init(items: [T], filter: @escaping (T) -> Bool, @ViewBuilder content: @escaping (T) -> Content) {
//        self.items = items
//        self.filter = filter
//        self.content = content
//    }
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 35) {
//                ForEach(items.filter(filter)) { item in
//                    content(item)
//                }
//            }
//            .padding()
//        }
//    }
//}


struct Tiles: View{
    var roomsList : [RoomModel]
    private var appendTop: Bool
    
    init(roomsList:[RoomModel]) {
        self.roomsList = roomsList
        appendTop = roomsList.count % 2 == 0 ? true : false
    }
    
    var body: some View{
        //        NavigationView{
        VStack{
            //                RoomHorizontalScrollView(roomsList: roomsList, appendTop: appendTop, even: true)
            
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
            //                HorizontalScrollView(items: appendTop ? roomsList : roomsList + [RoomModel.addRoomPlaceholder], filter: { $0.id.uuidString.hashValue % 2 == 1 }) { room in
            //                    if room.id == RoomModel.addRoomPlaceholder.id {
            //                        NavigationLink(destination: RoomEditView()) {
            //                            AddRoomTile(listPosition: roomsList.count)
            //                        }
            //                    } else {
            //                        RoomTile(roomName: room.name, roomWarnings: room.numWarnings, numPlants: room.plants.count, listPosition: Int(room.id.uuidString.hashValue))
            //                    }
            //                }
            //                .padding(.leading, 35)
        }
        //        }
    }
}

//struct RoomHorizontalScrollView: View {
//    let roomsList: [RoomModel]
//    let appendTop: Bool
//    let even: Bool
//
//    var filteredRooms: [RoomModel] {
//        let modifiedList = appendTop == even ? roomsList + [RoomModel.addRoomPlaceholder] : roomsList
//        return modifiedList.filter { $0.id.uuidString.hashValue % 2 == (even ? 0 : 1) }
//    }
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 35) {
//                ForEach(items.filter(filter)) { item in
//                    content(item)
//                }
//            }
//            .padding()
//        }
//
//
//        HorizontalScrollView(items: filteredRooms) { room in
//            if room.id == RoomModel.addRoomPlaceholder.id {
//                NavigationLink(destination: RoomEditView()) {
//                    AddRoomTile(listPosition: roomsList.count)
//                }
//            } else {
//                RoomTile(
//                    roomName: room.name,
//                    roomWarnings: room.numWarnings,
//                    numPlants: room.plants.count,
//                    listPosition: Int(room.id.uuidString.hashValue)
//                )
//            }
//        }
//        .padding(.leading, even ? 0 : 35)
//    }
//}

#Preview {
    MainScreenView()
}
