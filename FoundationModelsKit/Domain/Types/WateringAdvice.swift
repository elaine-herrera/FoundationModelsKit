//
//  WateringAdvice.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

@Generable
public struct WateringAdvice: Equatable {
    public let wateringIntervalDays: Int

    public let reasoning: String

    public let tips: [String]?
}
