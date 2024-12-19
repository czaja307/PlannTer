//
//  PlantModelTests.swift
//  PlannTer
//
//  Created by zawodev on 18/12/2024.
//

import XCTest
@testable import PlannTer

final class PerformanceTests: XCTestCase {
    
    //performance test
    func testWateringCalculationPerformance() {
        let plant = PlantModel.examplePlant
        let timeLimit: TimeInterval = 0.1 // limit czasu w sekundach
        
        var executionTime: TimeInterval = 0
        
        // measure zmierzy czas wykonania bloku kodu
        measure {
            let start = CFAbsoluteTimeGetCurrent()
            _ = plant.nextWateringDate //jakas lepsza funkcja do performance mierzenia
            let end = CFAbsoluteTimeGetCurrent()
            executionTime = end - start
        }
        
        XCTAssertLessThanOrEqual(executionTime, timeLimit, "Execution time \(executionTime)s exceeds the limit of \(timeLimit)s")
    }

}
