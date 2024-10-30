
import SwiftUI

struct RoomTile: View {
    let roomName : String
    let roomWarnings : Int
    let numPlants : Int

    private let size : CGFloat = 2 * main.bounds.width/3
    private let mainPadding: Int = 20


     var body: some View {
        VStack(spacing: mainPadding) {
            Text(roomName)
                .padding(mainPadding)
                .font(.mainText)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.primaryColor))
            HStack(spacing: mainPadding) {
                InfoBubble(value: numPlants, image: .plant, size: size - 3 * mainPadding)
                InfoBubble(value: roomWarnings, image: .exclamationMark, size: size - 3 * mainPadding)
            }
            .padding(mainPadding/2)
        }
        .padding(mainPadding)
        .frame(width: size, height: size)
        .background(Color(.PrimaryBackground))
        .cornerRadius(15)
        .shadow(color: Color(.brown), radius: 5, x: 2, y: 4)
    }
}

#Preview {
    RoomTile(roomName: "osdfijldf", roomWarnings: 3, numPlants: 3)
}


struct InfoBubble: View{
    let value : Int
    let image : Image
    let size : CGFloat

    var body: some View {
        VStack() {
            HStack() {
                Image(image)
                Text("$\value")
            }
        }
        .background( Color(.secondaryBackground) )
    }
}