//
//  PlantModelTests.swift
//  PlannTer
//
//  Created by zawodev on 19/12/2024.
//

import XCTest
@testable import PlannTer

final class ManualTests: XCTestCase {
    
    //testy manualne reczne
    func testManualPlantWatering() {
        let plant = PlantModel.examplePlant

        print("Testing manual functionality for \(plant.name)")
        print("Next watering date: \(plant.nextWateringDate)")
        print("Next conditioning date: \(plant.nextConditioningDate)")
        print("Progress: \(plant.progress)")
        print("Is watered: \(plant.isWatered)")

        XCTAssertNotNil(plant.nextWateringDate, "Next watering date should not be nil")
        XCTAssertNotNil(plant.nextConditioningDate, "Next conditioning date should not be nil")
        XCTAssertNotNil(plant.progress, "Progress should not be nil")
        
        let prevWateringDate = plant.prevWateringDate
        plant.waterThePlant(settings: SettingsModel())
        print("Watered the plant. Previous watering date: \(prevWateringDate)")
        
        XCTAssertNotEqual(prevWateringDate, plant.prevWateringDate, "The previous watering date should be updated after watering")
        XCTAssertTrue(plant.isWatered, "Plant should be watered after the action")
    }

}
