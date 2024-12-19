//
//  PlantModelTests.swift
//  PlannTer
//
//  Created by zawodev on 18/12/2024.
//

import XCTest
@testable import PlannTer

final class PlantModelTests: XCTestCase {

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

        plant.waterThePlant()
        
        XCTAssertNotEqual(plant.prevWateringDate, oldPrevWateringDate, "Prev watering date should be updated")
        XCTAssertEqual(plant.prevPrevWateringDate, oldPrevWateringDate, "Prev prev watering date should be set correctly")
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
        plant.wateringFreq = 7

        XCTAssertEqual(plant.notificationsCount, 2, "Notifications count should indicate overdue watering")
    }

    // test dynamicznie obliczanej daty podlewania
    func testNextWateringDate() {
        let plant = PlantModel.examplePlant
        XCTAssertTrue(plant.nextWateringDate > Date(), "Next watering date should be in the future")
    }
    
    
    
    //testy manualne reczne
    func manualTests() {
        let plant = PlantModel.examplePlant

        print("Testing manual functionality for \(plant.name)")
        print("Next watering date: \(plant.nextWateringDate)")
        print("Next conditioning date: \(plant.nextConditioningDate)")
        print("Progress: \(plant.progress)")
        print("Is watered: \(plant.isWatered)")
        
        plant.waterThePlant()
        print("Watered the plant. Prev watering date: \(plant.prevWateringDate)")
    }

}
