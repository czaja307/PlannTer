import SwiftUI

struct CreatePlantTile: View {
    var body: some View {
        NavigationLink(destination: PlantEditView()) {
            VStack {
                Text("Add Plant")
                    .font(.headline)
                    .foregroundColor(Color.primaryText)
                    .padding(.top, 16)

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.accent)
                        .frame(width: 60, height: 60)

                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                }
                .padding(.bottom, 16)

                Spacer()
            }
            .frame(width: 350, height: 180)
            .background(Color.primaryBackground)
            .cornerRadius(15)
            .shadow(color: Color.secondaryText.opacity(0.5), radius: 3.3, x: 2, y: 4)
            .padding(15)
        }
    }
}