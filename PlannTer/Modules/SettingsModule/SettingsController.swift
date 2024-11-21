import Foundation

class SettingsController: ObservableObject {
    @Published var name: String = ""
    @Published var notificationsFrequency: String = "Moderate"
    @Published var measurementsUnitSystem: String = "Metric"
    @Published var temperatureUnits: String = "Celsius"

    private let settingsFileName = "settings.json"
    
    init() {
        loadSettings()
    }

    // Save settings to a JSON file
    func saveSettings() {
        let settings = SettingsData(
            name: name,
            notificationsFrequency: notificationsFrequency,
            measurementsUnitSystem: measurementsUnitSystem,
            temperatureUnits: temperatureUnits
        )
        
        do {
            let data = try JSONEncoder().encode(settings)
            if let fileURL = getSettingsFileURL() {
                try createFileIfNeeded(at: fileURL)
                try data.write(to: fileURL)
                print("Settings saved to \(fileURL)")
            }
        } catch {
            print("Failed to save settings: \(error)")
        }
    }

    // Load settings from a JSON file
    func loadSettings() {
        guard let fileURL = getSettingsFileURL() else { return }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let settings = try JSONDecoder().decode(SettingsData.self, from: data)
            self.name = settings.name
            self.notificationsFrequency = settings.notificationsFrequency
            self.measurementsUnitSystem = settings.measurementsUnitSystem
            self.temperatureUnits = settings.temperatureUnits
            print("Settings loaded from \(fileURL)")
        } catch {
            print("Failed to load settings: \(error)")
        }
    }

    // Helper to get the file URL for settings
    private func getSettingsFileURL() -> URL? {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
            return directory.appendingPathComponent(settingsFileName)
        }
        return nil
    }

    // Helper function to create the file if it doesn't exist
    private func createFileIfNeeded(at fileURL: URL) throws {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: fileURL.path) {
            // If the file doesn't exist, create an empty one
            fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            print("Created empty settings file at \(fileURL.path)")
        }
    }
}

// Data model for saving and loading settings
struct SettingsData: Codable {
    let name: String
    let notificationsFrequency: String
    let measurementsUnitSystem: String
    let temperatureUnits: String
}
