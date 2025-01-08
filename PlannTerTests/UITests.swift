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

    func testChangeUserNameInSettings() throws {
        // tu trzeba jakoś wybrać settings przycisk (nie wiem jak)
        app.buttons["SettingsButton"].tap()
        
        // wypełniamy nasze imie (lub inne opcje też)
        let nameField = app.textFields["NameTextField"]
        nameField.tap()
        nameField.typeText("Test Name")
        
	// zapisz ustawienia aplikacji
        app.buttons["Save"].tap()
        
        // sprawdzamy czy nazwa sie zmieniła (przez dostęp do zmiennej jakiejś)
        let userName = app.tables.cells.staticTexts["UserName"]
        XCTAssertTrue(userName.exists, "The username should exist")
	XCTAssertEqual(userName, "Test Name", "username not changed")
    }
}
