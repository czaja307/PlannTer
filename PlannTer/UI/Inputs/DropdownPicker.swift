struct DropdownPicker: View {
    let title: String
    let options: [String]


    @State private  var isExpanded = false
    @State private var selectedOption = options[0]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.note)
            
            VStack {
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
                .cornerRadius(3)
                .font(.subtitle)
                .onTapGesture (withAnimation: .snappy) {
                    isExpande.toggle()
                }
            
            
                if isExpanded {
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
                            .font(.subtitle)
                            .onTapGesture (withAnimation: .snappy) {
                                selectedOption = option
                                isExpanded.toggle()
                            }
                        }
                    }
                    .transition(.move(edge: .bottom))
                }
            }
            .background(Color.white.opacity(0.3))
            
        }
        .foregroundColor(.additionalText)
    }
}

#Preview {
    DropdownPicker(title: "Units", options: ["metric", "imperial"])
}
