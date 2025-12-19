//
//  FoundationModelEngine.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 19/12/25.
//
import FoundationModels

public final class FoundationModelEngine: ModelEngine {
    public let model: SystemLanguageModel
    
    public init(model: SystemLanguageModel = .default) {
        self.model = model
    }
    
    public var isAvailable: Bool {
        model.isAvailable
    }
    
    public var availability: SystemLanguageModel.Availability {
        model.availability
    }
    
    public func generate<Response: Generable>(instructions: String, input: some Generable,
                                       responseType: Response.Type) async throws -> Response {
        let session = LanguageModelSession(model: model, instructions: instructions)
        let response = try await session.respond(to: .init(input), generating: responseType)
        return response.content
    }
}
