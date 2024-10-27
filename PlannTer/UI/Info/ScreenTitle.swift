
import SwiftUI

struct ScreenTitle: View {
    let title: String

    var body: some View {
            
        HStack{
            Image(systemName: "chevron.left")
                .font(.screenTitle)
                .foregroundColor(.primaryText)
                .padding(.leading, 20)
            Text(title)
                .font(.screenTitle)
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.center)

        }          
    }
}
