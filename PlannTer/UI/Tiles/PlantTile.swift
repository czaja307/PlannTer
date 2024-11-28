import SwiftUI

struct PlantTile: View {
    @State var plant: PlantModel

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 15) {
           
                Image(plant.imageUrl ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (geometry.size.width - 30) * 0.35, height: geometry.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack() {
                        Text(plant.name)
                            .font(.secondaryText)
                            .foregroundColor(Color.primaryText)
                    }
                    
                    HStack() {
                        Text(plant.isWatered ? "All good!" : "Add water:")
                            .font(.note)
                            .foregroundColor(Color.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if(!plant.isWatered){
                            Text("\(plant.waterAmountInML)ml")
                                .font(.largeSlimText)
                                .foregroundColor(Color.primaryText)
                            
                            Button(action: { plant.waterThePlant() }) {
                                Image("TickSymbol")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                            }
                            .padding(3)
                            .background(.white.opacity(0.6))
                            .cornerRadius(25)
                        }
                    }
                    .frame(height: 35)
                    HStack(){
                        Bar(progressBarWidth: 140, progressBarHeight: 20, progress: plant.progress)
                        HStack(spacing: 0) {
                            Image(plant.notificationsCount > 0 ? "WarnSymbol" : "ThumbsSymbol")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 30)
                                .foregroundColor(plant.notificationsCount > 0 ? .yellow : .green)
                            
                            Text(plant.notificationsCount > 0 ? "\(plant.notificationsCount)" : "")
                                .lineLimit(1)
                                .font(.note)
                                .foregroundColor(Color.primaryText)
                                .offset(x: -5)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(8)
                        .background(.white.opacity(0.6))
                        .cornerRadius(15)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
            }
        }
        .padding(15)
        .frame(height: 180, alignment: .center)
        .background(Color.secondaryBackground)
        .cornerRadius(15)
        .shadow(color: Color.secondaryText.opacity(0.5), radius: 3.3, x: 2, y: 4)
    }
}

struct Bar: View {
    
    let progressBarWidth: CGFloat
    let progressBarHeight: CGFloat
    var progress: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.waterBackground)
                .frame(width: progressBarWidth * 1.00, height: progressBarHeight)

            Rectangle()
                .fill(Color.primaryBackground)
                .frame(width: progressBarWidth * 0.75, height: progressBarHeight)
            Rectangle()
                .fill(Color.additionalBackground)
                .frame(width: progressBarWidth * 0.25, height: progressBarHeight)
            Rectangle()
                .fill(Color.black)
                .frame(width: 2, height: progressBarHeight)
                .offset(x: CGFloat(progress) * progressBarWidth)
        }
        .border(Color.black, width: 1)
        .cornerRadius(2)
    }
    
}

#Preview {
    PlantTile(plant: PlantModel.examplePlant)
    PlantTile(plant: PlantModel.examplePlant)
    CreatePlantTile()
}
