import SwiftUI

struct PlantTile: View {
    let plantImage: Image
    let plantName: String
    let waterAmount: Int
    @State private var isWatered: Bool = false
    let progress: Double // od 0.0 -> 1.0
    let notificationsCount: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // lewa strona z obrazkiem rośliny (bez panelu frame nad nią)
            plantImage
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // prawa strona z nazwą, opisem, paskiem postępu i ikoną powiadomień
            VStack(alignment: .leading, spacing: 8) {
                
                // nazwa rośliny
                Text(plantName)
                    .font(Font.custom("Roboto", size: 25))
                    .foregroundColor(Color(red: 0.29, green: 0.23, blue: 0.19))
                    .frame(width: 168, height: 35, alignment: .leading)
                
                // panel z polem tekstowym i przyciskiem
                HStack {
                    // pole tekstowe z podpisem
                    Text("Add: \(waterAmount) ml")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    // przycisk check
                    Button(action: {
                        isWatered.toggle()
                    }) {
                        Image(systemName: isWatered ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(isWatered ? .green : .gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                HStack {
                    // progress bar
                    ProgressView(value: progress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(height: 8)
                    
                    Spacer()
                    
                    // ikona powiadomień: kciuk w górę na zielonym tle i pusty string
                    // lub wykrzyknik z liczbą powiadomień na żółtym tle i liczbą powiadomień
                    HStack(spacing: 4) {
                        Image(systemName: notificationsCount > 0 ? "exclamationmark.triangle.fill" : "hand.thumbsup.fill")
                            .foregroundColor(notificationsCount > 0 ? .yellow : .green)
                        Text(notificationsCount > 0 ? "\(notificationsCount)" : "")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .padding(15)
        .frame(width: 350, height: 180, alignment: .top)
        .background(Color(red: 0.68, green: 0.76, blue: 0.47))
        .cornerRadius(15)
        .shadow(color: Color(.brown).opacity(0.5), radius: 3.3, x: 2, y: 4)
    }
}

#Preview {
    PlantTile(plantImage: Image(systemName: "checkmark.circle.fill"), plantName: "odhal", waterAmount: 2, progress: 0.9, notificationsCount: 0)
}
