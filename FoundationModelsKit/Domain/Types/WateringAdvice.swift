//
//  WateringAdvice.swift
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

@Generable
public struct WateringAdvice: Equatable {
    public let wateringIntervalDays: Int
    
    public let reasoning: String
    
    public let tips: [String]?
    
    public init(wateringIntervalDays: Int, reasoning: String, tips: [String]? = nil) throws
    {
        guard (1...90).contains(wateringIntervalDays) else {
            throw ValidationError.invalidWateringInterval(wateringIntervalDays)
        }
        
        self.wateringIntervalDays = wateringIntervalDays
        self.reasoning = reasoning
        self.tips = tips
    }
}

enum ValidationError: Error {
    case invalidWateringInterval(Int)
}
