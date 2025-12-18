//
//  PlantCareContext.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

@Generable
struct PlantCareContext {
    let plantName: String

    let location: PlantLocation

    let temperature: Temperature

    let humidity: Humidity
}
