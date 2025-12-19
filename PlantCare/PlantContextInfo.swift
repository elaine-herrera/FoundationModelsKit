//
//  PlantContextInfo.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 18/12/25.
//
import Foundation

struct PlantContextInfo {
    var name: String
    var location: PlantLocationInfo
    var temperature: TemperatureInfo
    var humidity: HumidityInfo
    
    init(name: String, location: PlantLocationInfo = .indoor, temperature: TemperatureInfo = .cold,
         humidity: HumidityInfo = .dry) {
        self.name = name
        self.location = location
        self.temperature = temperature
        self.humidity = humidity
    }
}
