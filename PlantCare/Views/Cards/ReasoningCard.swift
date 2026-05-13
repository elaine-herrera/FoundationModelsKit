//
//  ReasoningCard.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct ReasoningCard: View {

    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Reasoning", systemImage: "lightbulb.fill")
                .font(.headline)
                .foregroundColor(.secondary)

            Text(text)
                .font(.body)
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(nsColor: .textBackgroundColor))
        .cornerRadius(12)
    }
}
