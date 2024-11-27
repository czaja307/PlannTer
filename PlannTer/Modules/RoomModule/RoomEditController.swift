import Foundation

class RoomEditController: ObservableObject {
    
    @Published var windows = Array(repeating: false, count: 9)
    
    func selectedWindow(index: Int) {
        windows[index].toggle()
    }
    
    func saveRoom() {
        
    }
}
