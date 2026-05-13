//
//  PlantCareResultView.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI
import FoundationModelsKit

struct PlantCareResultView: View {

    let response: WateringAdviceState

    var body: some View {
        switch response {
        case .idle:
            EmptyView()

        case .loading:
            LoadingCard(
                title: "Analyzing your plant...",
                subtitle: "Creating personalized care recommendations"
            )

        case .modelUnavailable:
            ErrorCard(
                icon: "exclamationmark.triangle.fill",
                title: "Model Unavailable",
                message: "FoundationModel is not available on this device.",
                color: .orange
            )

        case .failed(let error):
            ErrorCard(
                icon: "xmark.circle.fill",
                title: "Generation Failed",
                message: error.localizedDescription,
                color: .red
            )

        case .loaded(let advice):
            VStack(alignment: .leading, spacing: 20) {
                WateringAdviceCard(days: advice.wateringIntervalDays)
                ReasoningCard(text: advice.reasoning)

                if let tips = advice.tips, !tips.isEmpty {
                    TipsCard(tips: tips)
                }
            }
        }
    }
}
