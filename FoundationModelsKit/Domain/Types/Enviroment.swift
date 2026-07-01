//
//  Enviroment.swift
//
//  Created by Elaine Herrera on 18/12/25.
//

import FoundationModels

@Generable
public enum PlantLocation: Sendable {
    case indoor
    case outdoor
}

@Generable
public enum Temperature: Sendable {
    case cold
    case mild
    case warm
}

@Generable
public enum Humidity: Sendable {
    case dry
    case normal
    case humid
}
