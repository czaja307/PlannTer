import SwiftUI

struct CreatePlantTile: View {
    var body: some View {
        VStack {
            Text("Add Plant")
                .font(.buttonText)
                .foregroundColor(Color.primaryText)
                .padding(.top, 16)
            Spacer()
            ZStack {
                Circle()
                    .fill(.white.opacity(0.6))
                    .frame(width: 60, height: 60)
                Image("AddSymbol")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
        }
        .padding(15)
        .frame(height: 180)
        .frame(maxWidth: .infinity)
        .background(Color.secondaryBackground)
        .cornerRadius(15)
        .shadow(color: Color.secondaryText.opacity(0.5), radius: 3.3, x: 2, y: 4)
    }
}

#Preview {
    CreatePlantTile()
}
