//
//  TitleProvider.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//

protocol TitleProvider {
    var title: String { get }
}

extension PlantLocationInfo {
    var icon: String {
        switch self {
        case .indoor: return "house.fill"
        case .outdoor: return "sun.max.fill"
        }
    }
}

extension PlantLocationInfo: TitleProvider {}
extension TemperatureInfo: TitleProvider {}
extension HumidityInfo: TitleProvider {}
