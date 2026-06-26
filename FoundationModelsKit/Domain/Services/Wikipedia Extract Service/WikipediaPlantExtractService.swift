//
//  WikipediaPlantExtractService.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 26/06/2026.
//
import Foundation

public final class WikipediaPlantExtractService: PlantExtractService {

    public init() {}

    public func search(_ term: String) async throws -> [String] {
        var components = URLComponents(string: "https://en.wikipedia.org/w/api.php?")

        components?.queryItems = [
            URLQueryItem(
                name: "titles",
                value: "\(term)"
            ),
            URLQueryItem(
                name: "format",
                value: "json"
            ),
            URLQueryItem(
                name: "action",
                value: "query"
            ),
            URLQueryItem(
                name: "prop",
                value: "extracts"
            ),
            URLQueryItem(
                name: "explaintext",
                value: "true"
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
            WikipediaExtract.self,
            from: data
        )

        return decoded.extracts
    }
    }
