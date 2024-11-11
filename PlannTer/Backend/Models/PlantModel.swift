import Foundation

struct PlantModel: Codable, Identifiable {
    var id: UUID = UUID()  // Możesz również wygenerować ID na podstawie danych z API, jeśli API dostarcza unikalny identyfikator
    var name: String
    var imageUrl: String
    var waterRequirement: Int  // Wymagania dotyczące wody
    var waterPortionSize: Int  // Rozmiar porcji wody
    
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
