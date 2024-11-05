import SwiftUI

struct LargeButton : View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .font(.buttonText)
                .foregroundColor(.primaryText)
                .background(.secondaryBackground)
                .padding()
                .cornerRadius(15)
                .shadow(color: Color(.brown), radius: 5, x: 2, y: 4)
        }
        .frame(height: 80)
    }
}
