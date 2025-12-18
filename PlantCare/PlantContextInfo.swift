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
    
    init(name: String, location: PlantLocationInfo, temperature: TemperatureInfo, humidity: HumidityInfo) {
        self.name = name
        self.location = location
        self.temperature = temperature
        self.humidity = humidity
    }
    
    init(name: String) {
        self.name = name
        self.location = .indoor
        self.temperature = .cold
        self.humidity = .dry
    }
}
