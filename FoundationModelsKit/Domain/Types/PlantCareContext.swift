//
//  PlantCareContext.swift
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

@Generable
public struct PlantCareContext: Sendable {
    @Guide(description: "Name of the plant")
    public let plantName: String

    @Guide(description: "Location of the plant. Can be indoor (e.g living room) or outdoor (e.g balcony)")
    public let location: PlantLocation

    @Guide(description: "Temperature in the location")
    public let temperature: Temperature

    @Guide(description: "Humidity in the location")
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

extension PlantCareContext {
    static let examplePhalaenopsis = PlantCareContext(
        plantName: "Phalaenopsis",
        location: .indoor,
        temperature: .mild,
        humidity: .dry
    )
}
