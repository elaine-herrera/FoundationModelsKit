//
//  WateringAdviceState.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModelsKit

enum WateringAdviceState {
    case idle
    case loading
    case failed(Error)
    case modelUnavailable
    case loaded(WateringAdvice)
}
