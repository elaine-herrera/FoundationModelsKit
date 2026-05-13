//
//  LoadingCard.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct LoadingCard: View {

    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            ProgressView()
                .scaleEffect(0.8)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 32)
    }
}
