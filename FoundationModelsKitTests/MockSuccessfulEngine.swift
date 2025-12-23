//
//  MockSuccessfulEngine.swift
//
//  Created by Elaine Herrera on 19/12/25.
//
import FoundationModels
@testable import FoundationModelsKit

final class MockSuccessfulEngine: ModelEngine {
    var isAvailable: Bool { true }
    
    private let expectedAdvice: WateringAdvice
    
    init (expectedAdvice: WateringAdvice) {
        self.expectedAdvice = expectedAdvice
    }
    
    var availability: SystemLanguageModel.Availability {
        .available
    }
    
    func generate<Response: Generable>(instructions: String, input: some Generable,
                                       responseType: Response.Type) async throws -> Response {
        expectedAdvice as! Response
    }
}

