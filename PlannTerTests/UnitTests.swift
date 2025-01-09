//
//  PlantModelTests.swift
//  PlannTer
//
//  Created by zawodev on 18/12/2024.
//

import XCTest
@testable import PlannTer

final class UnitTests: XCTestCase { //testy jednostkowe

    // test inicjalizacji modelu
    func testInitialization() {
        let room = RoomModel.exampleRoom
        let plant = PlantModel(
            id: UUID(),
            room: room,
            name: "Test Plant",
            prevWateringDate: Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            wateringFreq: 3
        )
        
        XCTAssertEqual(plant.name, "Test Plant", "Plant name should be 'Test Plant'")
        XCTAssertEqual(plant.wateringFreq, 3, "Watering frequency should be 3 days")
    }

    // test funkcji waterThePlant
    func testWaterThePlant() {
        var plant = PlantModel.examplePlant
        let oldPrevWateringDate = plant.prevWateringDate

        plant.waterThePlant(settings: SettingsModel())
        
        XCTAssertNotEqual(plant.prevWateringDate, oldPrevWateringDate, "Prev watering date should be updated")
    }

    // test funkcji progress
    func testProgressCalculation() {
        var plant = PlantModel.examplePlant
        plant.prevWateringDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        plant.wateringFreq = 7
        
        let progress = plant.progress
        XCTAssertTrue(progress > 0.0 && progress <= 1.0, "Progress should be between 0 and 1")
    }

    // test funkcji notificationsCount
    func testNotificationsCount() {
        var plant = PlantModel.examplePlant
        plant.prevWateringDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())
        plant.wateringFreq = 7
        plant.prevConditioningDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())
        plant.conditioningFreq = 7

        XCTAssertEqual(plant.notificationsCount, 2, "Notifications count should indicate overdue watering")
    }

    // test dynamicznie obliczanej daty podlewania
    func testNextWateringDate() {
        let plant = PlantModel.examplePlant
        
        plant.prevWateringDate = Calendar.current.date(byAdding: .minute, value: -10, to: Date())
        plant.wateringFreq = 2
        
        XCTAssertTrue(plant.nextWateringDate > Date(), "Next watering date should be in the future")
    }
    
    // test parsowania danych z api
    func testPlantParsing() {
        let json = """
        {
            "id" : 2137,
            "common_name" : "pretty green cactus",
            "family" : "cactusus pospolitus",
            "watering" : "frequent"
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            let plant = try decoder.decode(PlantDetails.self, from: json)
            print(plant)
            print()
            
            XCTAssertEqual(plant.id, 2137)
            XCTAssertEqual(plant.name, "pretty green cactus")
            XCTAssertEqual(plant.family, "cactusus pospolitus")
            XCTAssertEqual(plant.watering, "frequent")
            XCTAssertEqual(plant.category, "cactus")
            XCTAssertEqual(plant.species, "pretty green")
            XCTAssertEqual(plant.wateringAmount, 900)
        } catch {
            print("Error decoding plant: \(error)")
            XCTFail("Failed to decode plant")
        }
    }

    
}
