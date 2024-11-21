import SwiftUI

struct PlantDetailsView: View {
    @StateObject private var controller = PlantDetailsController(plant: PlantModel.examplePlant)
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
                WateringSection(date: $waterDate, days: $waterDays)
                WaterAmountSection(waterAmount: $waterAmount)
                SunExposureSection(sunExposure: $sunExposure)
                ConditioningSection(date: $conditioningDate, days: $conditioningDays)
                Spacer()
            }
        }
    }
}

struct TopBarView: View {
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .font(.mainText)
                .foregroundColor(.primaryText)
                .padding(.leading, 50)
            Spacer()
            Text(title)
                .font(.mainText)
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            Image(systemName: "gearshape.fill")
                .font(.mainText)
                .foregroundColor(.primaryText)
                .padding(.trailing, 50)
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
                PlantLabel(text: "Green room")
                PlantLabel(text: "Rose")
                PlantLabel(text: "Climbing")
            }
            .padding(.leading, 10)
        }
        .padding(.horizontal, 40)
    }
}

private struct WateringSection: View {
    @Binding var date: Date
    @Binding var days: Int
    
    var body: some View {
        VStack{
            HStack {
                Text("Next watering:")
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .disabled(true)
                .labelsHidden()
                .datePickerStyle(.compact)
                .padding(.trailing, 20)
                Text("\(days) days")
            }
            
        }
        .frame(width: 0.9 * UIScreen.main.bounds.width)
        .padding(.top, 20)
        .font(.custom("Roboto", size: 20))
        .foregroundColor(.primaryText)
        
        
        HStack{
            Slider(
                value: Binding(
                    get: { Double(days) },
                    set: { days = Int($0) }
                ),
                in: 1...30,
                step: 1,
                minimumValueLabel: Text("1"),
                maximumValueLabel: Text("30"),
                label: {
                    Text("Days")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
        }
    }
}

private struct WaterAmountSection: View {
    @Binding var waterAmount: Int
    
    var body: some View {
        VStack{
            HStack {
                Text("Water amount:")
                
                Spacer()
                Text("\(waterAmount) ml")
            }
            
        }
        .frame(width: 0.9 * UIScreen.main.bounds.width)
        .padding(.top, 20)
        .font(.custom("Roboto", size: 20))
        .foregroundColor(.primaryText)
        
        
        HStack{
            Slider(
                value: Binding(
                    get: { Double(waterAmount) },
                    set: { waterAmount = Int($0) }
                ),
                in: 50...1000,
                step: 50,
                minimumValueLabel: Text("50"),
                maximumValueLabel: Text("1000"),
                label: {
                    Text("Milliliters")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
        }
    }
}

private struct SunExposureSection: View {
    @Binding var sunExposure: Int
    
    var body: some View {
        VStack{
            HStack {
                Text("Sun exposure:")
                
                Spacer()
                Text("\(sunExposure) h")
            }
            
        }
        .frame(width: 0.9 * UIScreen.main.bounds.width)
        .padding(.top, 20)
        .font(.custom("Roboto", size: 20))
        .foregroundColor(.primaryText)
        
        
        HStack{
            Slider(
                value: Binding(
                    get: { Double(sunExposure) },
                    set: { sunExposure = Int($0) }
                ),
                in: 0...12,
                step: 0.25,
                minimumValueLabel: Text("0 h"),
                maximumValueLabel: Text("12 h"),
                label: {
                    Text("Hours")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
        }
    }
}

private struct ConditioningSection: View {
    @Binding var date: Date
    @Binding var days: Int
    
    var body: some View {
        VStack{
            HStack {
                Text("Next conditioning:")
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .disabled(true)
                .labelsHidden()
                .datePickerStyle(.compact)
                .padding(.trailing, 20)
                Text("\(days) days")
            }
            
        }
        .frame(width: 0.95 * UIScreen.main.bounds.width)
        .padding(.top, 20)
        .font(.custom("Roboto", size: 18))
        .foregroundColor(.primaryText)
        
        
        HStack{
            Slider(
                value: Binding(
                    get: { Double(days) },
                    set: { days = Int($0) }
                ),
                in: 1...90,
                step: 1,
                minimumValueLabel: Text("1"),
                maximumValueLabel: Text("90"),
                label: {
                    Text("Days")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
        }
    }
}

private struct PlantLabel: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            Text(text)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .frame(width: 200, height: 45, alignment: .center)
        .background(Color.additionalBackground)
        .font(.secondaryText)
        .foregroundStyle(Color.secondaryText)
        .cornerRadius(40)
    }
}

#Preview {
    PlantDetailsView()
}
