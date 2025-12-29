# FoundationModelsKit

[![CI](https://github.com/elaine-herrera/FoundationModelsKit/actions/workflows/CI.yml/badge.svg)](https://github.com/elaine-herrera/FoundationModelsKit/actions/workflows/CI.yml)

A macOS framework for generating plant care guidance (watering frequency, reasoning, and tips) using a FoundationModels.

## Overview

Given a plant name and basic environmental conditions (location, temperature, and humidity), ``FoundationModelsKit`` produces a structured ``WateringAdvice`` result. The framework separates the concerns of:

- describing the plant and its environment (``PlantCareContext``),
- invoking a foundation model (``FoundationModelEngine``), and
- exposing a simple, high-level API (``DefaultPlantCareModel``).

## Quick start

```swift
let context = PlantCareContext(
    plantName: "Orchid",
    location: .indoor,
    temperature: .warm,
    humidity: .humid
)

let model = DefaultPlantCareModel()
let advice = try? await model.generateWateringAdvice(for: context)

print(advice?.wateringIntervalDays) // e.g. 14
print(advice?.reasoning)            // short explanation
print(advice?.tips ?? [])           // optional tips
```
