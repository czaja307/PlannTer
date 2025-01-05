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

        // Output for manual inspection
        print("Testing manual functionality for \(plant.name)")
        print("Next watering date: \(plant.nextWateringDate)")
        print("Next conditioning date: \(plant.nextConditioningDate)")
        print("Progress: \(plant.progress)")
        print("Is watered: \(plant.isWatered)")

        // Expected behavior checks (assuming we have some knowledge of what these values should be)
        XCTAssertNotNil(plant.nextWateringDate, "Next watering date should not be nil")
        XCTAssertNotNil(plant.nextConditioningDate, "Next conditioning date should not be nil")
        XCTAssertNotNil(plant.progress, "Progress should not be nil")
        
        // Checking watering functionality
        let prevWateringDate = plant.prevWateringDate
        plant.waterThePlant(settings: SettingsModel())
        print("Watered the plant. Previous watering date: \(prevWateringDate)")
        
        // Assuming the `waterThePlant()` changes `prevWateringDate`, let's assert this change
        XCTAssertNotEqual(prevWateringDate, plant.prevWateringDate, "The previous watering date should be updated after watering")
        
        // Verify if the plant has been watered
        XCTAssertTrue(plant.isWatered, "Plant should be watered after the action")
    }

}
