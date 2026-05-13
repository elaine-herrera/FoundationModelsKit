//
//  PlantCareHeaderView.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct PlantCareHeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 48))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.green, Color.green.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.green.opacity(0.3), radius: 8, x: 0, y: 4)

            Text("Plant Care Advisor")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)

            Text("Get personalized watering recommendations")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 32)
        .padding(.bottom, 24)
    }
}
