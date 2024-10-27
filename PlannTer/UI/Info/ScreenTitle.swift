
import SwiftUI

struct AppTitle: View {
    let title: String

    var body: some View {
            
        HStack{
            Text(.chevronLeft)
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
