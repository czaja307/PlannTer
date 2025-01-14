//
//  PlannTerUITests.swift
//  PlannTerUITests
//
//  Created by IOSLAB on 13/01/2025.
//

import XCTest

final class PlannTerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {

    }

    
    
    func testSettingsSaveName() {
        let app = XCUIApplication()
        app.launch()

        // znajdź przycisk ustawień i kliknij
        let settingsButton = app.buttons["settingsButton"] //to chyba ten przycisk lol
        XCTAssertTrue(settingsButton.exists, "Settings button does not exist")
        settingsButton.tap()

        // znajdź pierwsze pole tekstowe i wpisz imię
        let textField = app.textFields.element(boundBy: 0)  // zakładamy, że pierwszy text field od gory
        //let textField = app.textFields["roomNameField"]
        XCTAssertTrue(textField.exists, "Name text field does not exist")
        let testName = "Edyta"
        textField.tap()
        textField.typeText(testName)

        // znajdź przycisk save i kliknij
        let saveButton = app.buttons["chevron.left"]
        XCTAssertTrue(saveButton.exists, "Save button does not exist")
        saveButton.tap()

        // sprawdź, czy wracamy na główny ekran
        XCTAssertTrue(settingsButton.exists, "Did not return to the main screen")
    }
    
    func testCreateRoom() {
        let app = XCUIApplication()
        app.launch()

        // znajdź przycisk dodaj pokoj i go kliknij
        let addRoomButton = app.buttons["addRoomButton"]
        XCTAssertTrue(addRoomButton.exists, "Create Room button does not exist")
        addRoomButton.tap()

        // znajdź pole tekstowe do wpisania nazwy pokoju i wpisz nazwę pokoju
        let roomNameField = app.textFields["nameField"]
        XCTAssertTrue(roomNameField.exists, "Room name text field does not exist")
        let testRoomName = "Edyty Room"
        roomNameField.tap()
        roomNameField.typeText(testRoomName)

        // kliknij przycisk save
        let backButton = app.buttons["saveRoomButton"]
        XCTAssertTrue(backButton.exists, "Back button does not exist")
        backButton.tap()

        // sprawdź, czy pokój został dodany do listy
        let newRoom = app.staticTexts[testRoomName]
        XCTAssertTrue(newRoom.exists, "New room '\(testRoomName)' does not appear in the list")
    }
}
