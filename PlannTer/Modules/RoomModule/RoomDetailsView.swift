import SwiftUI

struct RoomDetailsView: View {
    @StateObject private var controller = RoomDetailsController()
    
    var body: some View {
         ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
               
                Spacer()
            } 
        }
    }
}
