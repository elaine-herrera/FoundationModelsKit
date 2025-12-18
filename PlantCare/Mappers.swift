//
//  Mappers.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 18/12/25.
//
import Foundation
import FoundationModelsKit

enum PlantLocationInfo: CaseIterable, Identifiable {
    case indoor
    case outdoor
    
    public var id: Self { self }
    
    public var title: String { "\(self)".capitalized }
    
    // Map to the framework enum
    public var modelValue: PlantLocation {
        switch self {
        case .indoor: return .indoor
        case .outdoor: return .outdoor
        }
    }
}

enum TemperatureInfo: CaseIterable, Identifiable {
    case cold
    case mild
    case warm
    
    public var id: Self { self }
    
    public var title: String { "\(self)".capitalized }
    
    // Map to the framework enum
    public var modelValue: Temperature {
        switch self {
        case .cold: return .cold
        case .mild: return .mild
        case .warm: return .warm
        }
    }
}

enum HumidityInfo: CaseIterable, Identifiable {
    case dry
    case normal
    case humid
    
    public var id: Self { self }
    
    public var title: String { "\(self)".capitalized }
    
    // Map to the framework enum
    public var modelValue: Humidity {
        switch self {
        case .dry: return .dry
        case .normal: return .normal
        case .humid: return .humid
        }
    }
}
