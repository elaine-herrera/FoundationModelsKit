//
//  ModelEngine.swift
//
//  Created by Elaine Herrera on 19/12/25.
//
import FoundationModels

public protocol ModelEngine {
    var isAvailable: Bool { get }
    
    var availability: SystemLanguageModel.Availability { get }
    
    func generate<Response: Generable>(instructions: String, input: some Generable,
                                       responseType: Response.Type) async throws -> Response
}

