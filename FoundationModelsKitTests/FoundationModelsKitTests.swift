//
//  FoundationModelsKitTests.swift
//
//  Created by Elaine Herrera on 18/12/25.
//

import Testing
import Foundation
@testable import FoundationModelsKit

struct FoundationModelsKitTests {

    // This test verifies domain rules.
    // 1- wateringIntervalDays should always be between 0-90
    // 2- reasoning is not empty
    @Test func testWateringAdviceSatisfiesDomainRules() throws {
        let advice = try WateringAdvice(
            wateringIntervalDays: 14,
            reasoning: "Some explanation",
            tips: nil
        )

        #expect(advice.wateringIntervalDays > 0)
        #expect(advice.wateringIntervalDays <= 90)
        #expect(!advice.reasoning.isEmpty)
    }
    
    @Test func testWateringAdviceRejectsZeroDays() {
        #expect(throws: ValidationError.self) {
            try WateringAdvice(wateringIntervalDays: 0, reasoning: "Invalid interval", tips: nil)
        }
    }

    @Test func testWateringAdviceRejectsMoreThanNinetyDays() {
        #expect(throws: ValidationError.self) {
            try WateringAdvice(wateringIntervalDays: 91, reasoning: "Invalid interval", tips: nil)
        }
    }


    // This test verifies that the PlantCareModel consumer
    // correctly receives structured advice from a mocked model.
    @Test func testReturnsStubbedWateringAdviceForIndoorOrchid() async throws {
        let mockModel = MockPlantCareModel()
        mockModel.stubbedAdvice = try WateringAdvice(
            wateringIntervalDays: 14,
            reasoning: "Orchids require moderate watering indoors.",
            tips: ["Ensure proper drainage"]
        )

        let context = makePlantCareContext()

        let advice = try await mockModel.generateWateringAdvice(for: context)
        
        #expect(advice.wateringIntervalDays == 14)
        #expect(!advice.reasoning.isEmpty)
        #expect(advice.tips == ["Ensure proper drainage"])
    }
    
    @Test func testThrowsWhenModelUnavailable() async {
        let model = DefaultPlantCareModel(
            engine: UnavailableEngine()
        )

        let context = makePlantCareContext()

        await #expect(throws: ModelError.modelUnavailable) {
            try await model.generateWateringAdvice(for: context)
        }
    }

    @Test func testThrowsWhenFailingEngine() async {
        let expectedError = FailingEngineError.modelNotReady
        
        let model = DefaultPlantCareModel(
            engine: FailingEngine(expectedError: expectedError)
        )

        let context = makePlantCareContext()

        await #expect(throws: ModelError.generationFailed(underlying: expectedError)) {
            try await model.generateWateringAdvice(for: context)
        }
    }
    
    @Test func testCorrectWateringAdviceWhenSuccessfulEngine() async throws {
        let expectedWateringAdvice = try WateringAdvice(
            wateringIntervalDays: 14,
            reasoning: "Orchids require moderate watering indoors.",
            tips: ["Ensure proper drainage"]
        )
        
        let model = DefaultPlantCareModel(
            engine: MockSuccessfulEngine(expectedAdvice: expectedWateringAdvice)
        )

        let advice = try? await model.generateWateringAdvice(for: makePlantCareContext())

        #expect(advice != nil)
        #expect(advice!.wateringIntervalDays == 14)
        #expect(advice!.reasoning == expectedWateringAdvice.reasoning)
        #expect(advice!.tips == expectedWateringAdvice.tips)
    }
}

extension FoundationModelsKitTests {
    
    func makePlantCareContext() -> PlantCareContext {
        PlantCareContext(
            plantName: "Orchid",
            location: .indoor,
            temperature: .warm,
            humidity: .humid
        )
    }
}
