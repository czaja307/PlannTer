
import SwiftUI

struct AppTitle: View {
    var body: some View {
            VStack {
                HStack{
                    Spacer()
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("PlannTer")
                        .font(.title)
                        .foregroundColor(.customPrimaryText)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                Text("Your plant planner")
                    .font(.subtitle)
                    .foregroundColor(.customPrimaryText)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
            }
    }
}

#Preview{
    AppTitle()
}
