//
//  PlantModelTests.swift
//  PlannTer
//
//  Created by zawodev on 18/12/2024.
//

import XCTest
@testable import PlannTer

final class PerformanceTests: XCTestCase {
    
    func testLoadPlantListPerformance() {
        let expectation1 = expectation(description: "First load should complete within 10 seconds")
        let expectation2 = expectation(description: "Second load should complete within 5 seconds")
        
        let service = PlantService.shared
        
        // Measure the time for the first load
        let startTime1 = Date()
        service.loadPlantList { plants in
            let elapsedTime1 = Date().timeIntervalSince(startTime1)
            print("second test: \(elapsedTime1)")
            XCTAssert(elapsedTime1 <= 10, "First load took too long: \(elapsedTime1) seconds")
            expectation1.fulfill()
        }
        
        // Wait for the first call to finish
        wait(for: [expectation1], timeout: 10)
        
        // Measure the time for the second load
        let startTime2 = Date()
        service.loadPlantList { plants in
            let elapsedTime2 = Date().timeIntervalSince(startTime2)
            print("second test: \(elapsedTime2)")
            XCTAssert(elapsedTime2 <= 5, "Second load took too long: \(elapsedTime2) seconds")
            expectation2.fulfill()
        }
        
        // Wait for the second call to finish
        wait(for: [expectation2], timeout: 5)
    }

    
    func testLoadPlantDetailsPerformance() {
        let expectation = self.expectation(description: "Plant details loaded within acceptable time")
        let timeLimit: TimeInterval = 2.0 // maksymalny czas oczekiwania w sekundach
        let plantID = 425 // przykładowy ID rośliny do testu

        let startTime = CFAbsoluteTimeGetCurrent()
        PlantService.shared.getPlantDetails(for: plantID) { _ in
            let endTime = CFAbsoluteTimeGetCurrent()
            let executionTime = endTime - startTime

            print("time: \(executionTime)s")
            XCTAssertLessThanOrEqual(executionTime, timeLimit, "First plant details loading time \(executionTime)s exceeds limit \(timeLimit)s")
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeLimit + 1, handler: nil)
    }

    //performance test
    func testWateringCalculationPerformance() {
        let plant = PlantModel.examplePlant
        let timeLimit: TimeInterval = 0.1 // limit czasu w sekundach
        
        var executionTime: TimeInterval = 0
        
        // measure mierzy czas wykonania bloku kodu (kinda neat)
        measure {
            let start = CFAbsoluteTimeGetCurrent()
            plant.waterThePlant(settings: SettingsModel()) //jakas lepsza funkcja do performance mierzenia (bo obecna nie ma sensu mierzenia troche)
            _ = plant.nextWateringDate
            let end = CFAbsoluteTimeGetCurrent()
            executionTime = end - start
        }
        
        XCTAssertLessThanOrEqual(executionTime, timeLimit, "Execution time \(executionTime)s exceeds the limit of \(timeLimit)s")
    }

}
