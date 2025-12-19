//
//  FoundationModelEngine.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 19/12/25.
//
import FoundationModels

public final class FoundationModelEngine: ModelEngine {
    private let model: SystemLanguageModel
    
    public init(model: SystemLanguageModel = .default) {
        self.model = model
    }
    
    var isAvailable: Bool {
        model.isAvailable
    }
    
    var availability: SystemLanguageModel.Availability {
        model.availability
    }
    
    func generate<Response: Generable>(instructions: String, input: some Generable,
                                       responseType: Response.Type) async throws -> Response {
        let session = LanguageModelSession(model: model, instructions: instructions)
        let response = try await session.respond(to: .init(input), generating: responseType)
        return response.content
    }
}
