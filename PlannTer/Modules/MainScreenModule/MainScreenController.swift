import Foundation

class MainScreenController: ObservableObject {
    @Published var rooms: [RoomModel] = MockRoom.rooms
}
