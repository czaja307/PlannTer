import SwiftUI

struct MainScreenView: View {
    @StateObject private var controller = MainScreenController()
    
    var body: some View {
        NavigationView{
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
                } 
                VStack{
                    Spacer()
                    HStack{
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .foregroundColor(.primaryText)
//                                .font(.imageScale(.large))
                        }
                        .frame(width: 70, height: 70)
                        .background(Color(.primaryBackground))
                        .cornerRadius(45)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 20)   
            }.background(.white)
        }
    }
}


#Preview {
    MainScreenView()
}
