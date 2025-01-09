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

    func testChangeUserNameInSettings() throws {
        // przejście do ekranu ustawień
        let settingsButton = app.buttons["gear"] //to chyba ten przycisk lol
        XCTAssertTrue(settingsButton.exists, "Settings button should exist")
        settingsButton.tap()

        let textField = app.textFields.element(boundBy: 0) // zakładamy, że pierwszy text field od gory to jest
        XCTAssertTrue(textField.exists, "Text field for username should exist")
        textField.tap()

        textField.typeText("New Name")

        // zapisz zmiany
        app.buttons["Save"].tap()

        // weryfikacja - sprawdź czy imię się zmieniło
        let userName = app.staticTexts["UserName"]
        XCTAssertTrue(userName.exists, "User name label should exist")
        XCTAssertEqual(userName.label, "New Name", "User name should be updated")
    }

}
