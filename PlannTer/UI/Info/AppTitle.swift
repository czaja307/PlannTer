
import SwiftUI

struct AppTitle: View {
    var body: some View {
            VStack {
                HStack{
                    Spacer()
                    Image("AppIcon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.leading, 20)
                    Text("PlannTer")
                        .font(.title)
                        .foregroundColor(.primaryText)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Text("Your plant planner")
                    .font(.subtitle)
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
            }
    }
}
