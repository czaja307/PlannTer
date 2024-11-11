import Foundation

struct PlantModel: Identifiable, Codable {
    var id = UUID()
    var name: String

    // Funkcja obliczająca postęp (progress) jako proporcję waterLevel do waterMaxLevel
    var progress: Double {
        return 0.0 //to be implemented
    }

    // Funkcja zwracająca liczbę powiadomień (notificationCount)
    var notificationsCount: Int {
        return 1 //to be implemented
    }

    // Dodajemy właściwość `isWatered`
    var isWatered: Bool {
        return false //to be implemented
    }

    mutating func water() {
        //if waterLevel + waterPortionSize <= waterMaxLevel {
        //    waterLevel += waterPortionSize
        //}

        // --- zmiana stanu wody---
    }
}
