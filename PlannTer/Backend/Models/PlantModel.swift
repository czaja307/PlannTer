import Foundation

// enum do kategorii roślin
enum PlantCategory: String, Codable {
    case rose = "Rose"
    case tulip = "Tulip"
    case cactus = "Cactus"
    case fern = "Fern"
    case succulent = "Succulent"
    case orchid = "Orchid"
    // inne prawdopodobnie z api albo na biezaco albo cos
}

// enum do gatunków roślin
enum PlantSpecies: String, Codable {
    case climbing = "Climbing"
    case red = "Red"
    case green = "Green"
    case dwarf = "Dwarf"
    case flowering = "Flowering"
    // inne z api
}

// model rośliny
struct PlantModel: Codable, Identifiable {
    //nextWateringDate: Date().addingTimeInterval(86400),  // Następne podlewanie za 24 godziny
    //    room: livingRoom,
    //category: .cactus,
    //species: .green
    
    // ------------ BASE VALUES -----------------
    var id: UUID = UUID() // id moze byc brany z api? albo nie nwm
    var name: String // nazwakwiata
    var imageUrl: String  // URL zdjęcia rośliny
    // ------------ BASE VALUES -----------------
    
    
    // ------------ USER VALUES -----------------
    var temp_is_watered: Bool = false
    
    var nextWateringDate: Date  // data następnego podlewania
    var waterAmountInML: Int  // ilość wody w ml, do nastepnego podlewania
    var dailySunExposure: Int  // wymagane dzienne nasłonecznienie podane w godzinach od 0 do 24h
    var nextConditioningDate: Date  // data następnego kondycjonowania
    // ------------ USER VALUES -----------------
    
    
    // ------------ MAX USER VALUES -----------------
    var maxWateringDays: Int = 90 //days
    var maxWaterAmountInML: Int = 1000 //ml
    var maxDailySunExposure: Int = 24 //hours
    var maxConditioningDays: Int = 90 //days
    //var maxConditioningDate: Date //should have some default value = today + 90 days
    // ------------ MAX USER VALUES -----------------
    
    // pokoj, do którego należy roślina
    //var room: RoomModel  // zakladamy ze room model zostal wczesniej zdefiniowny (pytanie czy room zawiera kwiata czy kwiat rooma???)
    
    // kategoria rośliny
    var category: PlantCategory
    
    // gatunek rośliny
    var species: PlantSpecies
    
    // funkcja obliczająca postęp podlewania (proporcję wodowania do wymaganego poziomu)
    var progress: Double {
        // przykładowa implementacja: można obliczyć postęp na podstawie poziomu wody, ale w tej chwili nie mamy pełnej logiki
        return 0.4
    }

    // funkcja zwracająca liczbę powiadomień o konieczności podlewania
    var notificationsCount: Int {
        // możesz zwrócić 1, jeśli roślina wymaga podlewania, lub 0, jeśli nie
        return 13
    }

    // dodajemy właściwość `isWatered`, aby sprawdzić, czy roślina została podlana
    var isWatered: Bool {
        // możesz dostosować logikę do swoich potrzeb (np. zależność od daty)
        // return Calendar.current.isDateInToday(nextWateringDate)
        return temp_is_watered
    }

    // funkcja, która probouje podlewac roślinę i aktualizuje datę podlewania
    mutating func tryToWater() {
        // logika podlewania (np. zaktualizowanie daty następnego podlewania, zmniejszenie zapasu wody)
        nextWateringDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        
        if !temp_is_watered {
            temp_is_watered = true
            // dodatkowa logika do zarządzania postępem, ilością wody itd.
        }
    }

    // funkcja do zmiany pokoju, w którym znajduje się roślina
    mutating func changeRoom(to newRoom: RoomModel) {
        //room = newRoom
    }

    // funkcja do zmiany daty następnego kondycjonowania
    mutating func updateNextConditioningDate(to newDate: Date) {
        nextConditioningDate = newDate
    }
    
    static var examplePlant: PlantModel {
        return PlantModel(
            name: "Edyta",
            imageUrl: "ExamplePlant",
            nextWateringDate: Date().addingTimeInterval(86400),  // Następne podlewanie za 24 godziny
            waterAmountInML: 50,
            dailySunExposure: 8,
            nextConditioningDate: Date().addingTimeInterval(604800),  // Następne kondycjonowanie za tydzień
            //room: exampleRoom,
            category: .cactus,
            species: .green
        )
    }
}
