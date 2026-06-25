//
//  PlantSearchService.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 22/06/2026.
//
import Foundation

public enum PlantSearchServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid search URL."

        case .invalidResponse:
            return "Invalid server response."

        case .serverError(let statusCode):
            return "Server error (\(statusCode))."
        }
    }
}

public protocol PlantSearchService {
    func search(_ term: String) async throws -> [GBIFSpecies]
}
