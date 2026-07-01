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
    let extractService: any PlantExtractService

    @Generable
    struct Arguments {
        @Guide(description: "The plant name to get")
        let plantName: String
    }

    @Generable
    struct Output: Codable {
        @Guide(description: "The Wikipedia extracts containing information about the plant")
        let extracts: [String]
    }

    @MainActor
    init(extractService: PlantExtractService = WikipediaPlantExtractService()) {
        self.extractService = extractService
    }

    func call(arguments: Arguments) async throws -> Output {
        let response = try await extractService.search(arguments.plantName)
        return Output(extracts: response)
    }
}
