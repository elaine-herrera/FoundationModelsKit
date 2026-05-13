//
//  TipsCard.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct TipsCard: View {

    let tips: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Care Tips", systemImage: "star.fill")
                .font(.headline)
                .foregroundColor(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "\(index + 1).circle.fill")
                            .foregroundColor(.green)
                            .font(.title3)

                        Text(tip)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.green.opacity(0.08))
        .cornerRadius(12)
    }
}
