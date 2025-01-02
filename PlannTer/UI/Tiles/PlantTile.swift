import SwiftUI
import AVFoundation

struct PlantTile: View {
    @Environment(SettingsModel.self) private var settings
    @Environment(\.presentationMode) var presentationMode // To handle back navigation
    @State var plant: PlantModel
    @State private var isNavigatingToEditView = false
    @State private var uiImg: UIImage? = nil
    @State private var audioPlayer: AVAudioPlayer?
    
    let deleteAction: (PlantModel) -> ()
    
    private var waterAmountText: String {
        let amountInML = plant.waterAmountInML ?? 0
        switch settings.measurementUnitSystem {
        case "Imperial":
            let amountInOunces = Double(amountInML) * 0.033814
            return String(format: "%.1f oz", amountInOunces)
        default:
            return "\(amountInML)ml"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 15) {
                if (uiImg != nil) {
                    Image(uiImage: uiImg!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (geometry.size.width - 30) * 0.35, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    Image(plant.imageUrl!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: (geometry.size.width - 30) * 0.35, height: geometry.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
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
                            Text(waterAmountText)
                                .font(.largeSlimText)
                                .foregroundColor(Color.primaryText)
                            
                            Button(action: {
                                plant.waterThePlant(settings: settings)
                                playWateringSound()
                            }) {
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
            .onAppear() {
                if (plant.imageUrl != nil && plant.imageUrl != "ExamplePlant") {
                    uiImg = LocalFileManager.instance.getImage(name: plant.imageUrl!)
                }
            }
        }
        .padding(15)
        .frame(height: 180, alignment: .center)
        .background(Color.secondaryBackground)
        .cornerRadius(15)
        .shadow(color: Color.secondaryText.opacity(0.5), radius: 3.3, x: 2, y: 4)
        .contextMenu {
            Button(action: {
                isNavigatingToEditView = true
            }) {
                Label("Edit", systemImage: "gearshape.fill")
            }
            
            Button (role: .destructive){
                deleteAction(plant)
            }label:{
                Label("Delete", systemImage: "trash")
            }
        }
        .background(
            NavigationLink(destination: PlantEditView(plant: plant), isActive: $isNavigatingToEditView) {
                EmptyView()
            }
                .hidden()
        )
    }
    
    func playWateringSound() {
        if let path = Bundle.main.path(forResource: "water-sound", ofType: "wav") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
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
    PlantTile(plant: PlantModel.examplePlant, deleteAction: {_ in})
    PlantTile(plant: PlantModel.examplePlant, deleteAction: {_ in})
    CreatePlantTile()
}
