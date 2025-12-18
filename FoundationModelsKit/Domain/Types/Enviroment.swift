//
//  Enviroment.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//

import FoundationModels

@Generable
public enum PlantLocation {
    case indoor
    case outdoor
}

@Generable
public enum Temperature {
    case cold
    case mild
    case warm
}

@Generable
public enum Humidity {
    case dry
    case normal
    case humid
}
