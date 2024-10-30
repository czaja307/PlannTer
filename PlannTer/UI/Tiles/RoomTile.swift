
import SwiftUI

struct RoomTile: View {
    let roomName : String
    let roomWarnings : Int
    let numPlants : Int
    
    private let size : CGFloat = 2 * UIScreen.main.bounds.width/3
    private let mainPadding: CGFloat = 20
    
    
    var body: some View {
        VStack(spacing: mainPadding) {
            Text(roomName)
                .padding(mainPadding)
                .font(.mainText)
                .multilineTextAlignment(.center)
                .foregroundColor(.primaryText)
            HStack(spacing: mainPadding) {
                Spacer()
                InfoBubble(value: numPlants, image: Image("PlantSymbol"), size: (size - 3 * mainPadding)/3)
                Spacer()
                InfoBubble(value: roomWarnings, image: Image("PlantSymbol"), size: (size - 3 * mainPadding)/3)
                Spacer()
            }
            .padding(mainPadding/2)
        }
        .padding(mainPadding)
        .frame(width: size, height: size)
        .background(Color.primaryBackground)
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
                image
                Text("\(value)")
            }
        }
        .frame(width:size, height:size)
        .background(Color.secondaryBackground)
        .cornerRadius(size/2)
    }
}
