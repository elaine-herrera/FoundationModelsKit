//
//  DefaultPlantCareModel.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

public final class DefaultPlantCareModel: PlantCareModel {
    let model: SystemLanguageModel
    
    let instructions = """
    Given the following plant care context, determine an appropriate watering schedule.
    Consider horticulture best practices.
    """
    
    public init(model: SystemLanguageModel = .default) {
        self.model = model
    }
    
    public func generateWateringAdvice(for context: PlantCareContext) async throws -> WateringAdvice {
        guard model.isAvailable else {
            debugPrint(model.availability)
            throw ModelError.modelUnavailable
        }
        do {
            let session = LanguageModelSession(model: model, instructions: instructions)
            let response = try await session.respond(to: .init(context), generating: WateringAdvice.self)
            return response.content
        } catch {
            throw ModelError.generationFailed(underlying: error)
        }
    }
}
