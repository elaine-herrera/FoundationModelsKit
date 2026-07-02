//
//  WateringAdvice.swift
//
//  Created by Elaine Herrera on 18/12/25.
//
import FoundationModels

@Generable
public struct WateringAdvice: Equatable, Sendable {
    @Guide(description: "Days between thorough waterings", .range(1...90))
    public let wateringIntervalDays: Int

    @Guide(description: "2–4 sentences explaining the interval using concrete factors")
    public let reasoning: String

    @Guide(description: "Actionable tips", .maximumCount(5))
    public let tips: [String]?

    public init(wateringIntervalDays: Int, reasoning: String, tips: [String]? = nil) throws {
        guard (1...90).contains(wateringIntervalDays) else {
            throw ValidationError.invalidWateringInterval(wateringIntervalDays)
        }

        self.wateringIntervalDays = wateringIntervalDays
        self.reasoning = reasoning
        self.tips = tips
    }

    private init(uncheckedWateringIntervalDays: Int, reasoning: String, tips: [String]?) {
        self.wateringIntervalDays = uncheckedWateringIntervalDays
        self.reasoning = reasoning
        self.tips = tips
    }
}

enum ValidationError: Error {
    case invalidWateringInterval(Int)
}

extension WateringAdvice {
    static let examplePhalaenopsis = WateringAdvice(
        uncheckedWateringIntervalDays: 14,
        reasoning: """
            Water Phalaenopsis orchids based on the wet-dry cycle: when the roots turn silvery-white and the potting
            medium is nearly dry. Green roots mean they are hydrated, while silvery-gray roots indicate thirst.
            Allow all excess water to completely drain out through the bottom.
            """,
        tips: [
            "Pick up the pot; a dry pot feels noticeably lighter than a fully saturated one.",
            "Ensure no water stays trapped in the center crown or between the top leaves.",
            "In the winter you may need to water less frequently as the plant’s growth slows down.",
            "Place your orchid in a bright spot with indirect sunlight, such as an east or west-facing window",
            """
            In dry indoor climates fill a shallow tray with pebbles and a little water. Place the orchid pot on top
            and never let the bottom sit directly in the standing water, which can cause root rot.
            """
        ]
    )
}
