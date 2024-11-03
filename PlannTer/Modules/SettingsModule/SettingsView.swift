import SwiftUI

struct SettingsView: View {
    @StateObject private var controller = SettingsController()
    @State private var userName: String = ""
    
    var body: some View {
         ZStack {
            Rectangle()
                .fill(Color.primaryBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScreenTitle(title: "Settings")
                    .padding(.top, 20)
                Spacer()
                VStack(spacing: 20) {
                    TextField("What should we call you?", text: $userName)
                    DropdownPicker(title: "NotificationsFrequency:", options: ["Insistent", "Moderate", "Sparing"])
                    DropdownPicker(title: "Measurements unit system:", options: ["Metric", "Imperial"])
                    DropdownPicker(title: "Temperature units:", options: ["Celsius", "Fahrenheit"])
                }
                Spacer()
                LargeButton(title: "SaveSettings", action: controller.saveSettings)
                Spacer()
            }
        }
    }
}

#Preview{
    SettingsView()
}
