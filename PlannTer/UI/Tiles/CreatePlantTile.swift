import SwiftUI

struct CreatePlantTile: View {
    var body: some View {
        VStack {
            // Tekst na górze panelu
            Text("Add Plant")
                .font(.headline)
                .foregroundColor(Color.primaryText)
                .padding(.top, 16)
            
            Spacer()

            // Panel z okrągłym przyciskiem z plusem
            ZStack {
                Circle()
                    .fill(Color.accent)
                    .frame(width: 60, height: 60)

                
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .frame(width: 60, height: 60)  // Dopasowanie ramki przycisku
                
            }

            Spacer()
        }
        .padding(15)
        .frame(width: 350, height: 130)
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
