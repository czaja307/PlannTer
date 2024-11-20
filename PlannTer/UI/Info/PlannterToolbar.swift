import SwiftUI

struct PlannterToolbar: ViewModifier {
    let title: String
    let presentationMode: Binding<PresentationMode>
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss() // Custom back action
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.trailing, 50)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                }
            }
    }
}

extension View {
    func customToolbar(title: String, presentationMode: Binding<PresentationMode>) -> some View {
        self.modifier(PlannterToolbar(title: title, presentationMode: presentationMode))
    }
}
