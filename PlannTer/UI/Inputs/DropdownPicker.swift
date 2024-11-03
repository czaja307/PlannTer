import SwiftUI

struct DropdownPicker: View {
    let title: String
    let options: [String]
    
    @State private var isExpanded = false
    @State private var selectedOption: String
    
    init(title: String, options: [String]) {
        self.title = title
        self.options = options
        self._selectedOption = State(initialValue: options.first ?? "")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
            
            VStack(spacing: 0) {
                dropdownHeader
                if isExpanded {
                    dropdownOptions
                        .transition(.move(edge: .bottom))
                }
            }
            .background(Color.white.opacity(0.3))
            .cornerRadius(3)
        }
        .foregroundColor(.additionalText)
    }
    
    private var dropdownHeader: some View {
        HStack {
            Text(selectedOption)
            Spacer()
            Image(systemName: "chevron.right")
                .rotationEffect(.degrees(isExpanded ? 90 : 0))
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .background(Color.white.opacity(0.3))
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.primaryText),
            alignment: .bottom
        )
        .onTapGesture {
            toggleExpanded()
        }
    }
    
    private var dropdownOptions: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                    Spacer()
                    if selectedOption == option {
                        Image(systemName: "checkmark")
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 20)
                .onTapGesture {
                    selectOption(option)
                }
            }
        }
    }
    
    private func toggleExpanded() {
        withAnimation(.snappy) {
            isExpanded.toggle()
        }
    }
    
    private func selectOption(_ option: String) {
        selectedOption = option
        toggleExpanded()
    }
}

#Preview {
    DropdownPicker(title: "Units", options: ["metric", "imperial"])
}
