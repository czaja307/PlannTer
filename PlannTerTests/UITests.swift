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
    
    func testSettingsViewInteractions() {
        let app = XCUIApplication()
        app.launch()

        // przejście do ekranu ustawień
        app.buttons["SettingsButton"].tap() // załóżmy, że przycisk ma taki identyfikator

        // test zmiany nazwy użytkownika
        let nameField = app.textFields["NameTextField"] // identyfikator pola tekstowego
        nameField.tap()
        nameField.typeText("New Username")

        // test zmiany częstotliwości powiadomień
        let notificationPicker = app.buttons["NotificationFrequencyPicker"]
        notificationPicker.tap()
        app.buttons["Moderate"].tap() // wybór opcji "Moderate"

        // weryfikacja
        XCTAssertEqual(nameField.value as? String, "New Username", "Username should be updated")
        XCTAssertTrue(notificationPicker.label.contains("Moderate"), "Notification frequency should be updated")
    }

    
    func testLoadPlantListPerformance() {
        let expectation = self.expectation(description: "Plant list loads within acceptable time")
        let timeLimit: TimeInterval = 3.0 // maksymalny czas oczekiwania w sekundach

        let startTime = CFAbsoluteTimeGetCurrent()
        PlantService.shared.loadPlantList { _ in
            let endTime = CFAbsoluteTimeGetCurrent()
            let executionTime = endTime - startTime

            XCTAssertLessThanOrEqual(executionTime, timeLimit, "Plant list loading time \(executionTime)s exceeds limit \(timeLimit)s")
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeLimit + 1, handler: nil)
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
