//
//  UnavailableEngine.swift
//
//  Created by Elaine Herrera on 19/12/25.
//
import FoundationModels
@testable import FoundationModelsKit

final class UnavailableEngine: ModelEngine {
    var isAvailable: Bool { false }
    
    var availability: SystemLanguageModel.Availability {
        .unavailable(.appleIntelligenceNotEnabled)
    }
    
    func generate<Response: Generable>(instructions: String, input: some Generable,
                                       responseType: Response.Type) async throws -> Response {
        fatalError("Should not be called")
    }
}
