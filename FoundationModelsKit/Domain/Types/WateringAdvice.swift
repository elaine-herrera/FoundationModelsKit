//
//  WateringAdvice.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

@Generable
struct WateringAdvice {
    let wateringIntervalDays: Int

    let reasoning: String

    let tips: [String]?
}
