import SwiftUI

struct PlannterToolbar: ViewModifier {
    let title: String
    let presentationMode: Binding<PresentationMode>
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding(30)
                            .font(.mainText)
                            .foregroundColor(.primary)
                    }
                    
                }
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.mainText)
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
