//
//  PlantExtractService.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 26/06/2026.
//

public protocol PlantExtractService: Sendable {
    func search(_ term: String) async throws -> [String]
}
