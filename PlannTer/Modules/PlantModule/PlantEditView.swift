import SwiftUI

struct PlantEditView: View {
    @StateObject private var controller = PlantDetailsController(plant: MockPlant.samplePlant)
    @State private var waterDate = Date()
    @State private var waterDays: Int = 7
    @State private var waterAmount: Int = 200
    @State private var sunExposure: Int = 8
    @State private var conditioningDate = Date()
    @State private var conditioningDays: Int = 30
    
    
    var body: some View {
        ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                TopBarView(title: controller.plant.name)
                PlantImageSection()
                SliderSection(
                    value: $waterDays, title: "Watering interval", unit: "days", range: 1...30, step: 1
                )
                SliderSection(
                    value: $waterAmount, title: "Water amount", unit: "ml", range: 50...1000, step: 50
                )
                SliderSection(
                    value: $sunExposure, title: "Sun exposure", unit: "h", range: 0...12, step: 1
                )
                SliderSection(
                    value: $conditioningDays, title: "Conditioning interval", unit: "days", range: 1...90, step: 1
                )
                Spacer()
            }
        }
    }
}


private struct PlantImageSection: View {
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(0.4))
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
                Image(.edytka)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .cornerRadius(15)
            }
            VStack {
                Button(action: {}) {
                    Label("Green room", systemImage: "chevron.down")
                        .font(.note)
                        .frame(width: 180, height: 30)
                }
                .buttonBorderShape(.capsule)
                .tint(.additionalBackground)
                
                Button(action: {}) {
                    Label("Green room", systemImage: "chevron.down")
                        .font(.note)
                        .frame(width: 180, height: 30)
                }
                .buttonBorderShape(.capsule)
                .tint(.additionalBackground)
                
                Button(action: {}) {
                    Text("Climbing")
                        .font(.note)
                        .frame(width: 180, height: 30)
                }
                .buttonBorderShape(.capsule)
                .tint(.additionalBackground)
                
            }
            .buttonStyle(.borderedProminent)
            .padding(.leading, 10)
        }
        .padding(.horizontal, 40)
    }
}

private struct SliderSection: View {
    @Binding var value: Int
    var title: String
    var unit: String
    var range: ClosedRange<Double>
    var step: Double
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title):")
                Spacer()
                Text("\(value) \(unit)")
            }
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .padding(.top, 20)
            .font(.custom("Roboto", size: 20))
            .foregroundColor(.primaryText)
            
            Slider(
                value: Binding(
                    get: { Double(value) },
                    set: { value = Int($0) }
                ),
                in: range,
                step: step,
                minimumValueLabel: Text("\(Int(range.lowerBound)) \(unit)"),
                maximumValueLabel: Text("\(Int(range.upperBound)) \(unit)"),
                label: {
                    Text(unit)
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    PlantEditView()
}
