//
//  GBIFSpeciesSearchResponse.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 22/06/2026.
//
import Foundation

public struct GBIFSpeciesSearchResponse: Codable {
    public let results: [GBIFSpecies]
}

public struct GBIFSpecies: Codable, Identifiable, Hashable {
    public let key: Int
    public let scientificName: String?
    public let canonicalName: String?
    public let authorship: String?
    public let rank: String?
    public let status: String?
    public let family: String?
    public let genus: String?

    public var id: Int { key }

    /// Prefer the canonical (name without authorship) form for display.
    public var displayName: String {
        canonicalName ?? scientificName ?? "Unknown"
    }

    public var subtitle: String {
        var parts: [String] = []
        if let rank = rank { parts.append(rank.capitalized) }
        if let family = family { parts.append(family) }
        return parts.joined(separator: " · ")
    }
}
