//
//  PlantCareContext.swift
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

@Generable
public struct PlantCareContext {
    public let plantName: String

    public let location: PlantLocation

    public let temperature: Temperature

    public let humidity: Humidity
    
    public init(
        plantName: String,
        location: PlantLocation,
        temperature: Temperature,
        humidity: Humidity
    ) {
        self.plantName = plantName
        self.location = location
        self.temperature = temperature
        self.humidity = humidity
    }
}
