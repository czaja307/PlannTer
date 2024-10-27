
import SwiftUI

struct ScreenTitle: View {
    let title: String

    var body: some View {
            
        HStack{
            Image(systemName: "chevron.left")
                .font(.screenTitle)
                .foregroundColor(.customPrimaryText)
                .padding(.trailing, 50)
            Text(title)
                .font(.screenTitle)
                .foregroundColor(.customPrimaryText)
                .multilineTextAlignment(.center)
            Spacer()
        }.padding(40)
    }
}

#Preview {
    ScreenTitle(title: "Screen Title")
}
