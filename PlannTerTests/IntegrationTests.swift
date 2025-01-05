//
//  IntegrationTests.swift
//  PlannTer
//
//  Created by zawodev on 05/01/2025.
//

import XCTest
@testable import PlannTer

final class IntegrationTests: XCTestCase {
    
    func testPlantDetailsFetchingIntegration() {
        let expectation = self.expectation(description: "Plant details are fetched correctly")
        let testPlantID = 425 // z prawdziwego api prawdziwe id (jakby sie nie wiem zmienilo api to podmienic bo powinno zbierac dane z api i tyle a nie jakies konkretne
        
        PlantService.shared.getPlantDetails(for: testPlantID) { details in
            XCTAssertNotNil(details, "plant details should not be nil")
            XCTAssertEqual(details?.id, testPlantID, "fetched plant ID should match the requested ID")
            XCTAssertEqual(details?.name, "flowering-maple", "name does not match flowering maple")
            XCTAssertEqual(details?.watering, "Frequent", "watering is not Frequent")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
