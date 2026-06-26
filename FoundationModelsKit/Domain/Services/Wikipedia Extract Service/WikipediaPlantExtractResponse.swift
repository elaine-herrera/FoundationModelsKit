//
//  WikipediaPlantExtractResponse.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 26/06/2026.
//

struct WikipediaExtract: Codable {
    let query: WikipediaQuery

    var extracts: [String] {
        query.pages.values.compactMap { $0.extract }
    }
}

struct WikipediaQuery: Codable {
    let pages: [String: WikipediaPage]
}

struct WikipediaPage: Codable {
    let pageid: Int?
    let ns: Int
    let title: String
    let extract: String?
}
