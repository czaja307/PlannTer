import SwiftUI

struct PlantTile: View {
    @State var plant: PlantModel

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Image(plant.imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 8) {
                Text(plant.name)
                    .font(Font.custom("Roboto", size: 25))
                    .foregroundColor(Color.primaryText)
                
                Text("Add water: \(plant.waterAmountInML)ml")
                    .font(Font.custom("Roboto", size: 16))
                    .foregroundColor(Color.primaryText)

                //ProgressView(value: plant.progress).progressViewStyle(LinearProgressViewStyle()).frame(height: 8)
                
                let progressBarWidth: CGFloat = 140
                let progressBarHeight: CGFloat = 20

                ZStack(alignment: .leading) {
                    // RIGHT (0-100%)
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: progressBarWidth * 1.00, height: progressBarHeight) // 25% szerokości

                    // MIDDLE (0-75%)
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: progressBarWidth * 0.75, height: progressBarHeight) // 50% szerokości

                    // LEFT (0-25%)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: progressBarWidth * 0.25, height: progressBarHeight) // 25% szerokości

                    // pionowa kreska wskazująca postęp
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 2, height: progressBarHeight)
                        .position(x: CGFloat(plant.progress) * progressBarWidth, y: progressBarHeight / 2)
                }
                .cornerRadius(8)  // Zaokrąglone rogi paska

            }
            .padding(.vertical, 8)
            
            VStack(spacing: 10) {
                Button(action: { plant.tryToWater() }) {
                    Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "checkmark.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(plant.isWatered ? .green : .red)
                }
                .disabled(plant.isWatered)
                
                ZStack(alignment: .topTrailing) {
                    Image(systemName: plant.notificationsCount > 0 ? "exclamationmark.triangle.fill" : "hand.thumbsup.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(plant.notificationsCount > 0 ? .yellow : .green)
                    
                    Text(plant.notificationsCount > 0 ? "\(plant.notificationsCount)" : "")
                        .font(.subheadline)
                        .foregroundColor(Color.primaryText)
                }
            }
            .padding(.leading, 10)
        }
        .padding(15)
        .frame(width: 350, height: 130, alignment: .top)
        .background(Color.primaryBackground)
        .cornerRadius(15)
        .shadow(color: Color.secondaryText.opacity(0.5), radius: 3.3, x: 2, y: 4)
    }
}

#Preview {
    PlantTile(plant: PlantModel.examplePlant)
    PlantTile(plant: PlantModel.examplePlant)
    CreatePlantTile()
    CreatePlantTile()
}
