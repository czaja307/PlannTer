import SwiftUI

struct RoomTile: View {
    let room: RoomModel
    let listPosition : Int
    let deleteAction: (RoomModel) -> ()
    
    private let size : CGFloat = 2 * UIScreen.main.bounds.width/3
    private let mainPadding: CGFloat = 20
    private var fgColor : Color {
        listPosition % 2 == 0 ? Color.secondaryBackground : Color.primaryBackground
    }
    private var bgColor : Color {
        listPosition % 2 == 0 ? Color.primaryBackground : Color.secondaryBackground
    }
    @State private var isNavigatingToEditView = false
    
    var body: some View {
        ZStack(alignment: .top){
            VStack(spacing: 5) {
                Text(room.name)
                    .padding(mainPadding)
                    .font(.mainText)
                    .lineLimit(2)
                    .foregroundColor(Color.primaryText)
                    .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .center
                        )
                HStack(spacing: mainPadding) {
                    Spacer()
                    InfoBubble(color: fgColor, value: room.plants.count, image: Image("PlantSymbol"), size: (size - 2 * mainPadding)/3)
                    Spacer()
                    InfoBubble(color: fgColor, value: room.notificationsCount, image: Image("WarnSymbol"), size: (size - 2 * mainPadding)/3)
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
        .contextMenu {
            Button(action: {
                isNavigatingToEditView = true
            }) {
                Label("Edit", systemImage: "gearshape.fill")
            }
            
            Button (role: .destructive){
                deleteAction(room)
            }label:{
                Label("Delete", systemImage: "trash")
            }
        }
        .background(
            NavigationLink(destination: RoomEditView(room: room ), isActive: $isNavigatingToEditView) {
                EmptyView()
            }
            .hidden()
        )
    }
}

struct InfoBubble: View{
    let color : Color
    let value : Int
    let image : Image
    let size : CGFloat
    
    var body: some View {
        VStack() {
            HStack() {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size/1.3, height: size/1.3)
                Text("\(value)")
                    .font(.note)
                    .foregroundColor(.primaryText)
                    .offset(x: -15)
                    
            }
            .font(.note)
        }
        .frame(width:size, height:size)
        .background(color)
        .cornerRadius(size/2)
    }
}

#Preview {
    RoomTile(room: RoomModel.exampleRoom, listPosition: 0, deleteAction: {_ in})
    RoomTile(room: RoomModel.exampleRoom, listPosition: 1, deleteAction: {_ in})
}
