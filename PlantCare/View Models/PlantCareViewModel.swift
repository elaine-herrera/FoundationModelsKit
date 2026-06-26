//
//  PlantCareViewModel.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI
import Combine
import FoundationModelsKit

@MainActor
final class PlantCareViewModel: ObservableObject {

    @Published var response: WateringAdviceState = .idle
    @Published var plant: PlantContextInfo = .init(name: "")

    var isDisabled: Bool {
        response == .loading || plant.name.isEmpty
    }

    func generate() async {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            response = .loading
        }

        let result = await getWateringAdvice()

        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            response = result
        }
    }

    private func getWateringAdvice() async -> WateringAdviceState {
        let model = DefaultPlantCareModel()

        let context = PlantCareContext(
            plantName: plant.name,
            location: plant.location.modelValue,
            temperature: plant.temperature.modelValue,
            humidity: plant.humidity.modelValue
        )

        do {
            let advice = try await model.generateWateringAdvice(for: context)
            return .loaded(advice)
        } catch {
            if let plantCareError = error as? ModelError {
                switch plantCareError {
                case .modelUnavailable:
                    return .modelUnavailable
                case .generationFailed(let underlying):
                    return .failed(underlying)
                @unknown default:
                    return .failed(error)
                }
            }
            return .failed(error)
        }
    }
}
