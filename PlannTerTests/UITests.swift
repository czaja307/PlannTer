//
//  PlantModelTests.swift
//  PlannTer
//
//  Created by zawodev on 18/12/2024.
//

import XCTest
@testable import PlannTer

final class UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    //to be de-chatgpt-fied
    func testAddPlantAndCheckDetails() throws {
        // Załóżmy, że na głównym ekranie jest przycisk dodawania rośliny
        app.buttons["AddPlantButton"].tap()
        
        // Wypełniamy formularz
        let nameField = app.textFields["PlantNameTextField"]
        nameField.tap()
        nameField.typeText("Test Plant")
        
        app.buttons["SavePlantButton"].tap()
        
        // Sprawdzamy, czy roślina została dodana
        let plantCell = app.tables.cells.staticTexts["Test Plant"]
        XCTAssertTrue(plantCell.exists, "The plant should appear in the list")
        
        // Klikamy w szczegóły rośliny
        plantCell.tap()
        
        let detailsLabel = app.staticTexts["PlantDetailsLabel"]
        XCTAssertTrue(detailsLabel.exists, "Details screen should be visible")
    }
}
