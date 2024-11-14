import SwiftUI

struct SettingsView: View {
    @StateObject private var controller = SettingsController()
    @State private var expandedDropdown: String?=nil
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    // Set expandedDropdown to nil to close any open dropdown
                    expandedDropdown = nil
                    isFocused = false
                }
            VStack {
                ScreenTitle(title: "Settings")
                    .padding(.top, 20)
                Spacer()
                VStack(spacing: 20) {
                    TextInput(title: "What should we call you?", prompt: "Enter your name", isActive:$isFocused
                    )
                    DropdownPicker(title: "NotificationsFrequency:", options: ["Insistent", "Moderate", "Sparing"], isExpanded: Binding(
                        get: { expandedDropdown == "NotificationsFrequency" },
                        set: { expandedDropdown = $0 ? "NotificationsFrequency" : nil }
                    ))
                    DropdownPicker(title: "Measurements unit system:", options: ["Metric", "Imperial"], isExpanded: Binding(
                        get: { expandedDropdown == "MeasurementsUnitSystem" },
                        set: { expandedDropdown = $0 ? "MeasurementsUnitSystem" : nil }
                    ))
                    DropdownPicker(title: "Temperature units:", options: ["Celsius", "Fahrenheit"], isExpanded: Binding(
                        get: { expandedDropdown == "TemperatureUnits" },
                        set: { expandedDropdown = $0 ? "TemperatureUnits" : nil }
                    ))
                }
                Spacer()
                LargeButton(title: "SaveSettings", action: controller.saveSettings)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onChange(of: expandedDropdown) { newValue in
            // Add animation to dropdown state change
            if newValue != nil {
                withAnimation {
                    isFocused = false  // Reset focus with animation
                }
            }
        }
        .onChange(of: isFocused) { newValue in
            // Add animation when focus changes
            if newValue {
                withAnimation {
                    expandedDropdown = nil  // Close dropdown when focused
                }
            }
        }
    }
}

#Preview{
    SettingsView()
}
