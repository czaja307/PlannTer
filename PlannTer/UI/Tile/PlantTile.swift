import SwiftUI

struct PlantTile: View {
    @State var plant: PlantModel

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: plant.imgUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 8) {
                Text(plant.name)
                    .font(Font.custom("Roboto", size: 25))
                    .foregroundColor(Color.primaryText)
                    .frame(width: 180, height: 35, alignment: .leading)

                HStack {
                    Text("Add: \(plant.waterPortionSize) ml")
                        .font(.subheadline)
                        .foregroundColor(Color.secondaryText)
                    Spacer()
                    Button(action: {
                        plant.water()
                    }) {
                        Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(plant.isWatered ? .green : Color.secondaryText)
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                HStack {
                    ProgressView(value: plant.progress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(height: 8)
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: plant.notificationsCount > 0 ? "exclamationmark.triangle.fill" : "hand.thumbsup.fill")
                            .foregroundColor(plant.notificationsCount > 0 ? .yellow : .green)
                        Text(plant.notificationsCount > 0 ? "\(plant.notificationsCount)" : "")
                            .font(.subheadline)
                            .foregroundColor(Color.primaryText)
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .padding(15)
        .frame(width: 350, height: 130, alignment: .top)
        .background(Color.primaryBackground)
        .cornerRadius(15)
        .shadow(color: Color.secondaryText.opacity(0.5), radius: 3.3, x: 2, y: 4)
    }
}

#Preview {
    var examplePlant = PlantModel(name: "Edyta", imgUrl: "AddSymbol", waterLevel: 200, waterPortionSize: 20)
    PlantTile(plant: examplePlant)
}
