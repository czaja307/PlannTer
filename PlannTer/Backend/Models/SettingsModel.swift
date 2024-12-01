//
//  SettingsController.swift
//  PlannTer
//
//  Created by Jakub Czajkowski on 27/11/2024.
//
import Foundation
import SwiftData

@Model
class SettingsModel {
    var username: String
    var notificationFrequency: String
    var measurementUnitSystem: String
    var temperatureUnits: String
    
    init(username: String = "",
         notificationFrequency: String = "Moderate",
         measurementUnitSystem: String = "Metric",
         temperatureUnits: String = "Celsius") {
        self.username = username
        self.notificationFrequency = notificationFrequency
        self.measurementUnitSystem = measurementUnitSystem
        self.temperatureUnits = temperatureUnits
    }
}
