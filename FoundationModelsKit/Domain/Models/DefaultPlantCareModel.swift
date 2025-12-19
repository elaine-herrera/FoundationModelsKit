//
//  DefaultPlantCareModel.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

public final class DefaultPlantCareModel: PlantCareModel {
    private let engine: ModelEngine
    
    let instructions = """
    Given the following plant care context, determine an appropriate watering schedule.
    Consider horticulture best practices.
    """
    
    init(engine: ModelEngine = FoundationModelEngine()) {
        self.engine = engine
    }
    
    public func generateWateringAdvice(for context: PlantCareContext) async throws -> WateringAdvice {
        guard engine.isAvailable else {
            debugPrint(engine.availability)
            throw ModelError.modelUnavailable
        }
        do {
            return try await engine.generate(instructions: instructions, input: context,
                                             responseType: WateringAdvice.self)
        } catch {
            throw ModelError.generationFailed(underlying: error)
        }
    }
}
