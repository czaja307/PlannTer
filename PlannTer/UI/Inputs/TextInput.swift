import SwiftUI

struct TextInput: View {
    let title: String
    let prompt: String
    
    @FocusState.Binding private var isActive: Bool

    @State private var inputText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.note)
            TextField(prompt, text: $inputText)
                .frame(height: 50)
                .padding(.horizontal, 20)
                .background(Color.white.opacity(0.3))
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.primaryText),
                    alignment: .bottom
                )
                .cornerRadius(3)
                .font(.secondaryText)
                .focused($isActive)
               
        }
        .foregroundColor(.additionalText)
    }
}
//
//#Preview {
//    TextInput(title: "Your name", prompt: "Mary Jane")
//}
