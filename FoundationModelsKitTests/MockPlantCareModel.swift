//
//  MockPlantCareModel.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 18/12/25.
//
@testable import FoundationModelsKit

final class MockPlantCareModel: PlantCareModel {
    var stubbedAdvice: WateringAdvice!

    func generateWateringAdvice(for context: PlantCareContext) async throws -> WateringAdvice {
        stubbedAdvice
    }
}
