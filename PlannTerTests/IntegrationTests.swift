//
//  IntegrationTests.swift
//  PlannTer
//
//  Created by zawodev on 05/01/2025.
//

import XCTest
@testable import PlannTer

final class IntegrationTests: XCTestCase {
    
    func testBasicPlantModelIntegration() {
        let expectation = self.expectation(description: "PlantModel fetched and validated successfully")
        let testPlantID = 425 // używamy przykładowego ID

        PlantModel.createFromApi(plantId: testPlantID) { plant in
            XCTAssertNotNil(plant, "Plant object should not be nil")
            print(plant?.name)
            
            // weryfikacja podstawowych danych
            XCTAssertEqual(plant?.plantId, testPlantID, "Fetched plant ID should match the requested ID")
            XCTAssertNotNil(plant?.name, "Plant name should not be nil")
            XCTAssertGreaterThan(plant?.name.count ?? 0, 0, "Plant name should not be empty")
            
            // weryfikacja częstotliwości podlewania
            if let wateringFreq = plant?.wateringFreq {
                XCTAssertGreaterThan(wateringFreq, 0, "Watering frequency should be greater than zero")
            } else {
                XCTFail("Watering frequency should not be nil")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDetailedPlantModelIntegration() {
        let expectation = self.expectation(description: "PlantModel fetched and validated successfully")
        let testPlantID = 425 // używamy przykładowego ID

        PlantModel.createFromApi(plantId: testPlantID) { plant in
            XCTAssertNotNil(plant, "Plant object should not be nil")
            guard let plant = plant else {
                XCTFail("Failed to fetch plant details")
                expectation.fulfill()
                return
            }
            
            XCTAssertEqual(plant.plantId, testPlantID, "Fetched plant ID should match the requested ID")
            
            XCTAssertFalse(plant.name.isEmpty, "Plant name should not be empty")
            
            XCTAssertGreaterThan(plant.wateringFreq ?? 0, 0, "Watering frequency should be greater than zero")
            
            if let sunlight = plant.dailySunExposure {
                XCTAssertGreaterThan(sunlight ?? 0, 0, "Sunlight hours should be greater than zero")
            } else {
                XCTFail("Sunlight data should not be nil")
            }
            
            XCTAssertFalse(plant.imageUrl?.isEmpty ?? true, "Image URL should not be empty")
            XCTAssertNotEqual(plant.imageUrl, "ExamplePlant", "Image URL should not use fallback value")

            if let description = plant.descriptionText {
                XCTAssertGreaterThan(description.count, 10, "Description should have meaningful content")
            } else {
                XCTFail("Description should not be nil")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)
    }


}
