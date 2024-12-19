//
//  PlantModelTests.swift
//  PlannTer
//
//  Created by zawodev on 19/12/2024.
//

import XCTest
@testable import PlannTer

final class HandyTests: XCTestCase {
    
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
