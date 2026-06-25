//
//  GBIFPlantSearchService.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 22/06/2026.
//
import Foundation

public final class GBIFPlantSearchService: PlantSearchService {

    public init() {}

    private static let higherTaxonKey = 6
    private static let limit = 10

    public func search(_ term: String) async throws -> [GBIFSpecies] {

        var components = URLComponents(string: "https://api.gbif.org/v1/species/search")

        components?.queryItems = [
            URLQueryItem(
                name: "highertaxon_key",
                value: "\(Self.higherTaxonKey)"
            ),
            URLQueryItem(
                name: "limit",
                value: "\(Self.limit)"
            ),
            URLQueryItem(
                name: "q",
                value: term
            )
        ]

        guard let url = components?.url else {
            throw PlantSearchServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw PlantSearchServiceError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw PlantSearchServiceError.serverError(httpResponse.statusCode)
        }

        let decoded = try JSONDecoder().decode(
            GBIFSpeciesSearchResponse.self,
            from: data
        )

        return decoded.results
    }
}
