struct LargeButton : View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: .infinity, height:80)
                .font(.mainText)
                .foregroundColor(.primaryText)
                .background(.secondaryBackground)
                .padding()
                .cornerRadius(15)
                .shadow(color: Color(.brown), radius: 5, x: 2, y: 4)
        }

    }
}