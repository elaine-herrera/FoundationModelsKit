//
//  PlantCareModel.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//

protocol PlantCareModel {
    func generateWateringAdvice(for context: PlantCareContext) async throws -> WateringAdvice
}
