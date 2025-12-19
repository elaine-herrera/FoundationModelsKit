//
//  FailingEngine.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 19/12/25.
//
import FoundationModels
@testable import FoundationModelsKit

enum FailingEngineError: Error {
    case modelNotReady
}

final class FailingEngine: ModelEngine {
    var isAvailable: Bool { true }
    
    private let expectedError: FailingEngineError
    
    init (expectedError: FailingEngineError) {
        self.expectedError = expectedError
    }
    
    var availability: SystemLanguageModel.Availability {
        .unavailable(.modelNotReady)
    }
    
    func generate<Response: Generable>(instructions: String, input: some Generable,
                                       responseType: Response.Type) async throws -> Response {
        throw expectedError
    }
}
