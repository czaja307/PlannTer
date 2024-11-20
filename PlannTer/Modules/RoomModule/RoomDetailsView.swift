import SwiftUI

struct RoomDetailsView: View {
    let title : String
    @StateObject private var controller = RoomDetailsController()
    @Environment(\.presentationMode) var presentationMode // To handle back navigation
    var body: some View {
        VStack {
            if /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/ {
                NavigationView {
                    List(MockPlant.plants) { plant in
                        VStack(alignment: .leading) {
                            Text(plant.name).font(.headline)
                            
                            HStack {
                                Text("Water level: ")
                                Text(String(plant.waterLevel))
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .navigationBarBackButtonHidden(true)
                .customToolbar(title: title, presentationMode: presentationMode)
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
        }
    }
}

#Preview {
    RoomDetailsView(title: "Test")
}
