//
//  WateringAdviceState.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModelsKit

enum WateringAdviceState: Equatable {
    case idle
    case loading
    case failed(Error)
    case modelUnavailable
    case loaded(WateringAdvice)
    
    static func == (lhs: WateringAdviceState, rhs: WateringAdviceState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.failed(_), .failed(_)): return true
        case (.modelUnavailable, .modelUnavailable): return true
        case (.loaded(_), .loaded(_)): return true
        default : return false
        }
    }
}
