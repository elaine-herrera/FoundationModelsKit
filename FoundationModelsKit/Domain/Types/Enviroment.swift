//
//  Enviroment.swift
//  FoundationModelsTest
//
//  Created by Elaine Herrera on 18/12/25.
//

import FoundationModels

@Generable
enum PlantLocation {
    case indoor
    case outdoor
}

@Generable
enum Temperature {
    case cold
    case mild
    case warm
}

@Generable
enum Humidity {
    case dry
    case normal
    case humid
}
