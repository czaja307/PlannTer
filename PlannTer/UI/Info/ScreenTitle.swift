
import SwiftUI

struct ScreenTitle: View {
    let title: String

    var body: some View {
            
        HStack{
            Image(systemName: "chevron.left")
                .font(.mainText)
                .foregroundColor(.primaryText)
                .padding(.trailing, 50)
            Text(title)
                .font(.mainText)
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(40)
    }
}

#Preview {
    ScreenTitle(title: "Screen Title")
}
