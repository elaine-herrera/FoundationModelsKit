//
//  WateringAdviceCard.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct WateringAdviceCard: View {

    let days: Int

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "drop.fill")
                .font(.system(size: 48))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, Color.blue.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 4) {
                Text("Water every")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(days)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))

                    Text("days")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.blue.opacity(0.08))
        .cornerRadius(12)
    }
}
