import Foundation

class MainScreenController: ObservableObject {
    @Published var rooms: [RoomModel] = [RoomModel.exampleRoom, RoomModel.exampleRoom]
}
