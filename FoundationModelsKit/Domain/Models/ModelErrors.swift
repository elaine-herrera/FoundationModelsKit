//
//  ModelErrors.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//
import Foundation

enum ModelError: Error, Equatable {
    case modelUnavailable
    case generationFailed(underlying: Error)
    
    static func == (lhs: ModelError, rhs: ModelError) -> Bool {
        switch (lhs, rhs) {
            case (.modelUnavailable, .modelUnavailable): return true
            case (.generationFailed(let lhs), .generationFailed(let rhs)): return lhs as NSError == rhs as NSError
            default: return false
        }
    }
}
