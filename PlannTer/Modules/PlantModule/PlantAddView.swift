import SwiftUI
import SwiftData

struct PlantAddView: View {
    @Environment(\.modelContext) private var context
    @Bindable var room: RoomModel
    
    //Sliders info
    @State private var waterDate = Date()
    @State private var waterDays: Int = 7
    @State private var waterAmount: Int = 200
    @State private var sunExposure: Int = 8
    @State private var conditioningDate = Date()
    @State private var conditioningDays: Int = 30
    @FocusState private var isActive: Bool
    //Sliders info
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var plantName: String = ""
    
    var body: some View {
        ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    // Set expandedDropdown to false to close any open dropdown
                    isActive = false
                }
            VStack {
                PlantImageSection()
                TextInput(title: "Name your plant", prompt: "Edytka", inputText: $plantName, isActive: $isActive)
                    .frame(width: 0.9 * UIScreen.main.bounds.width)
                SliderSection(
                    value: $waterDays, title: "Watering interval", unit: "days", range: 1...30, step: 1, sColor: .green
                )
                SliderSection(
                    value: $waterAmount, title: "Water amount", unit: "ml", range: 50...1000, step: 50, sColor: .blue
                )
                SliderSection(
                    value: $sunExposure, title: "Sun exposure", unit: "h", range: 0...12, step: 1, sColor: .yellow
                )
                SliderSection(
                    value: $conditioningDays, title: "Conditioning interval", unit: "days", range: 1...90, step: 1, sColor: .pink
                )
                Spacer()
                HStack{
                    Spacer()
                    MiniButton(title: "Reset", action:{})
                    Spacer()
                    MiniButton(title: "Save", action: savePlant)
                    Spacer()
                }
                .frame(width: 0.9 * UIScreen.main.bounds.width)
            }
        }
        
        .navigationBarBackButtonHidden(true)
        .customToolbar(title: "Add plant", presentationMode: presentationMode)
    }
    
    private func savePlant() {
        let nextWatering = Calendar.current.date(byAdding: .day, value: waterDays, to: Date())

        
        let newPlant = PlantModel(room: room, name: plantName, imageUrl: "ExamplePlant", category: "Jan", species: "Paweł", waterAmountInML: waterAmount, dailySunExposure: sunExposure, nextWateringDate: Date(), prevWateringDate: Date())
        context.insert(newPlant)
        
        do {
            try context.save()
        } catch {
            print("Failed to save plant: \(error)")
        }
        
        presentationMode.wrappedValue.dismiss()
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
                        .font(.secondaryText)
                        .frame(width: 180, height: 30)
                }
                .buttonBorderShape(.capsule)
                .tint(.additionalBackground)
                
                Button(action: {}) {
                    Label("Green room", systemImage: "chevron.down")
                        .font(.secondaryText)
                        .frame(width: 180, height: 30)
                }
                .buttonBorderShape(.capsule)
                .tint(.additionalBackground)
                
                Button(action: {}) {
                    Label("Green room", systemImage: "chevron.down")
                        .font(.secondaryText)
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
    let sColor: Color
    
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
            .tint(sColor)
        }
    }
}

private struct MiniButton : View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .font(.buttonText)
                .padding(10)
                .foregroundColor(.secondaryText)
                .background(.additionalBackground)
                .cornerRadius(10)
                .shadow(color: Color(.brown), radius: 3, x: 2, y: 4)
        }
        .frame(width: 160, height: 80)
    }
}

