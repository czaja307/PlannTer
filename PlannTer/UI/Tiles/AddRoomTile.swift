import SwiftUI

struct AddRoomTile: View {
    let listPosition : Int
    
    private let size : CGFloat = 2 * UIScreen.main.bounds.width/3
    private let mainPadding: CGFloat = 20
    private var fgColor : Color {
        listPosition % 2 == 0 ? Color.secondaryBackground : Color.primaryBackground
    }
    private var bgColor : Color {
        listPosition % 2 == 0 ? Color.primaryBackground : Color.secondaryBackground
    }
    
    var body: some View {
        ZStack(alignment: .top){
            VStack(spacing: mainPadding) {
                Text("Add room")
                    .padding(mainPadding)
                    .font(.mainText)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primaryText)
                HStack(spacing: mainPadding) {
                    Spacer()
                    AddBubble(color: fgColor, size: (size - 3 * mainPadding)/3)
                    Spacer()
                }
                .padding(mainPadding/2)
            }
            .padding(mainPadding)
            .frame(width: size, height: size)
            .background(bgColor)
            .cornerRadius(15)
            .shadow(color: Color(.brown), radius: 5, x: 2, y: 4)
            HStack{
                Spacer()
                Image("PinImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size/2)
                    .offset(x: 20, y: -size / 4)
                Spacer()
            }
        }
    }
}

struct AddBubble: View{
    let color : Color
    let size : CGFloat
    
    var body: some View {
        Image("AddSymbol")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:size, height:size)
            .background(color)
            .cornerRadius(size/2)
    }
}

#Preview {
    AddRoomTile(listPosition: 0)
}
