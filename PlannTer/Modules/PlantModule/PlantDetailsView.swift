import SwiftUI

struct PlantDetailsView: View {
    @Bindable var plant: PlantModel
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        ZStack {
            Color(.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                PlantImageSection(plant: plant)
                WateringSection(date: plant.nextWateringDate ?? Date(), days: plant.wateringFreq ?? 7)
                WaterAmountSection(waterAmountInML: plant.waterAmountInML ?? 200)
                SunExposureSection(sunExposure: plant.dailySunExposure ?? 8)
                ConditioningSection(date: plant.nextConditioningDate ?? Date(), days: plant.conditioningFreq ?? 30)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .customToolbar(title: plant.name, presentationMode: presentationMode)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: PlantEditView(plant: plant)) {
                    Image(systemName: "gearshape.fill")
                        .font(.mainText)
                        .foregroundColor(.primaryText)
                        .padding(.trailing, 50)
                }
            }
        }
    }
}

private struct PlantImageSection: View {
    @Bindable var plant: PlantModel
    
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.white.opacity(0.4))
                    .frame(width: 150, height: 150)
                    .cornerRadius(15)
                if(plant.imageUrl != "ExamplePlant") {
                    if let localImage = LocalFileManager.instance.getImage(name: plant.imageUrl!) {
                        Image(uiImage: localImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 130)
                            .cornerRadius(15)
                    }
                } else {
                    Image(plant.imageUrl!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 130)
                        .cornerRadius(15)
                }
            }
            VStack {
                PlantLabel(text: plant.room.name)
                PlantLabel(text: plant.category ?? "None")
                PlantLabel(text: plant.species ?? "None")
            }
            .padding(.leading, 10)
        }
        .padding(.horizontal, 40)
    }
}

private struct WateringSection: View {
    var date: Date
    var days: Int

    var body: some View {
        VStack {
            HStack {
                Text("Next watering:")
                DatePicker(
                    "",
                    selection: .constant(date),
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

        HStack {
            Slider(
                value: .constant(Double(days)),
                in: 1...30,
                step: 1,
                minimumValueLabel: Text("1"),
                maximumValueLabel: Text("30"),
                label: {
                    Text("Days")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .disabled(true)
            .tint(.green)
        }
    }
}

private struct WaterAmountSection: View {
    @Environment(SettingsModel.self) private var settings
    var waterAmountInML: Int
    private var waterAmountText: String {
        switch settings.measurementUnitSystem {
        case "Imperial":
            let amountInOunces = Double(waterAmountInML) * 0.033814
            return String(format: "%.1f oz", amountInOunces)
        default:
            return "\(waterAmountInML)ml"
        }
    }
    
    private var minLabel: String {
        settings.measurementUnitSystem == "Imperial" ? "1.7 oz" : "50 ml"
    }

    private var maxLabel: String {
        settings.measurementUnitSystem == "Imperial" ? "33.8 oz" : "1000 ml"
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Water amount:")
                Spacer()
                Text(waterAmountText)
            }
        }
        .frame(width: 0.9 * UIScreen.main.bounds.width)
        .padding(.top, 20)
        .font(.custom("Roboto", size: 20))
        .foregroundColor(.primaryText)

        HStack {
            Slider(
                value: .constant(Double(waterAmountInML)),
                in: 50...1000,
                step: 50,
                minimumValueLabel: Text(minLabel),
                maximumValueLabel: Text(maxLabel),
                label: {
                    Text("Water")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .disabled(true)
        }
    }
}

private struct SunExposureSection: View {
    var sunExposure: Int

    var body: some View {
        VStack {
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

        HStack {
            Slider(
                value: .constant(Double(sunExposure)),
                in: 0...12,
                step: 0.25,
                minimumValueLabel: Text("0 h"),
                maximumValueLabel: Text("12 h"),
                label: {
                    Text("Hours")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .disabled(true)
            .tint(.yellow)
        }
    }
}

private struct ConditioningSection: View {
    var date: Date
    var days: Int

    var body: some View {
        VStack {
            HStack {
                Text("Next conditioning:")
                DatePicker(
                    "",
                    selection: .constant(date),
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

        HStack {
            Slider(
                value: .constant(Double(days)),
                in: 1...90,
                step: 1,
                minimumValueLabel: Text("1"),
                maximumValueLabel: Text("90"),
                label: {
                    Text("Days")
                }
            )
            .frame(width: 0.9 * UIScreen.main.bounds.width)
            .disabled(true)
            .tint(.pink)
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
