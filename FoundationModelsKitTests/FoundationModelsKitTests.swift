//
//  FoundationModelsKitTests.swift
//  FoundationModelsKitTests
//
//  Created by Elaine Herrera on 18/12/25.
//

import Testing
@testable import FoundationModelsKit

struct FoundationModelsKitTests {

    // This test verifies domain rules.
    // 1- wateringIntervalDays should always be between 0-90
    // 2- reasoning is not empty
    @Test func testWateringAdviceSatisfiesDomainRules() {
        let advice = WateringAdvice(
            wateringIntervalDays: 14,
            reasoning: "Some explanation",
            tips: nil
        )

        #expect(advice.wateringIntervalDays > 0)
        #expect(advice.wateringIntervalDays <= 90)
        #expect(!advice.reasoning.isEmpty)
    }


    // This test verifies that the PlantCareModel consumer
    // correctly receives structured advice from a mocked model.
    @Test func testReturnsStubbedWateringAdviceForIndoorOrchid() async throws {
        let mockModel = MockPlantCareModel()
        mockModel.stubbedAdvice = WateringAdvice(
            wateringIntervalDays: 14,
            reasoning: "Orchids require moderate watering indoors.",
            tips: ["Ensure proper drainage"]
        )

        let context = PlantCareContext(
            plantName: "Orchid",
            location: .indoor,
            temperature: .warm,
            humidity: .humid
        )

        let advice = try await mockModel.generateWateringAdvice(for: context)
        
        #expect(advice.wateringIntervalDays == 14)
        #expect(!advice.reasoning.isEmpty)
        #expect(advice.tips == ["Ensure proper drainage"])
    }

}
