//
//  WikipediaTool.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 26/06/2026.
//

import FoundationModels
import Foundation

struct WikipediaTool: Tool {
    let name = "findWikipediaExtract"
    let description = "Finds a wikipedia extract for a plant"

    @Generable
    struct Arguments {
        @Guide(description: "The plant name to get")
        let plantName: String
    }

    @Generable
    struct Output: Codable {
        @Guide(description: "The wikipedia extracts with plant information")
        let extracts: [String]
    }

    func call(arguments: Arguments) async throws -> Output {
        let response = try await WikipediaPlantExtractService().search(arguments.plantName)
        return Output(extracts: response)
    }
}
