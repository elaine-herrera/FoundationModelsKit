//
//  SuggestionsList.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 22/06/2026.
//
import SwiftUI
import FoundationModelsKit

struct SuggestionsList: View {
    let suggestions: [GBIFSpecies]
    let onSelect: (GBIFSpecies) -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(suggestions) { species in
                    Button {
                        onSelect(species)
                    } label: {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(species.displayName)
                                .font(.body)
                                .italic()
                                .foregroundStyle(.primary)

                            if !species.subtitle.isEmpty {
                                Text(species.subtitle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                    }
                    .buttonStyle(.plain)

                    if species.id != suggestions.last?.id {
                        Divider()
                    }
                }
            }
        }
        .background(Color(.textBackgroundColor))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray), lineWidth: 0.5)
        )
    }
}
