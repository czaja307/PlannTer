import SwiftUI

struct SettingsView: View {
    @StateObject private var controller = SettingsController()
    @State private var expandedDropdown: String?=nil
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) var presentationMode
    
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
                Spacer()
                VStack(spacing: 20) {
                    // Text Input for Name
                    TextInput(
                        title: "What should we call you?",
                        prompt: "Enter your name",
                        inputText: $controller.name,
                        isActive: $isFocused
                    )
                    
                    // Dropdown for Notifications Frequency
                    DropdownPicker(
                        title: "Notifications Frequency:",
                        options: ["Insistent", "Moderate", "Sparing"],
                        selectedOption: $controller.notificationsFrequency,
                        isExpanded: Binding(
                            get: { expandedDropdown == "NotificationsFrequency" },
                            set: { expandedDropdown = $0 ? "NotificationsFrequency" : nil }
                        )
                    )
                    
                    // Dropdown for Measurements Unit System
                    DropdownPicker(
                        title: "Measurements Unit System:",
                        options: ["Metric", "Imperial"],
                        selectedOption: $controller.measurementsUnitSystem,
                        isExpanded: Binding(
                            get: { expandedDropdown == "MeasurementsUnitSystem" },
                            set: { expandedDropdown = $0 ? "MeasurementsUnitSystem" : nil }
                        )
                    )
                    
                    // Dropdown for Temperature Units
                    DropdownPicker(
                        title: "Temperature Units:",
                        options: ["Celsius", "Fahrenheit"],
                        selectedOption: $controller.temperatureUnits,
                        isExpanded: Binding(
                            get: { expandedDropdown == "TemperatureUnits" },
                            set: { expandedDropdown = $0 ? "TemperatureUnits" : nil }
                        )
                    )
                }
                Spacer()
                LargeButton(title: "Save Settings", action: controller.saveSettings)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        .customToolbar(title: "Settings", presentationMode: presentationMode)
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
