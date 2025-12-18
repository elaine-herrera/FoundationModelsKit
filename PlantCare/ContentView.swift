//
//  ContentView.swift
//  PlantCare
//
//  Created by Elaine Herrera on 18/12/25.
//

import SwiftUI
import FoundationModelsKit

struct ContentView: View {
    @State private var response: WateringAdviceState = .idle
    @State private var plant: PlantContextInfo = .init(name: "Cactus")

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Plant Care Advice Generator")
                .font(.title)
            
            HStack() {
                Text("Plant name:")
                TextField("Plant name", text: $plant.name)
                    .textFieldStyle(.roundedBorder)
            }
            
            Picker("Select Location:", selection: $plant.location) {
                ForEach(PlantLocationInfo.allCases) { value in
                    Text(value.title).tag(value)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Select Temperature:", selection: $plant.temperature) {
                ForEach(TemperatureInfo.allCases) { value in
                    Text(value.title).tag(value)
                }
            }
            
            Picker("Select Humidity:", selection: $plant.humidity) {
                ForEach(HumidityInfo.allCases) { value in
                    Text(value.title).tag(value)
                }
            }
            
            Button("Generate Watering Advice") {
                response = .loading
                Task {
                    response = await callFundationModel()
                }
            }
            
            Divider()
            
            content
        }
        .padding()
    }

    @ViewBuilder
    private var content: some View {
        switch response {
        case .idle:
            EmptyView()
            
        case .loading:
            ProgressView("Generating advice...")

        case .modelUnavailable:
            Text("FoundationModel is not available on this device.")
                .foregroundColor(.orange)

        case .failed(let error):
            VStack {
                Text("Failed to generate advice")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

        case .loaded(let advice):
            VStack(alignment: .leading, spacing: 8) {
                Text("Water every \(advice.wateringIntervalDays) days")
                    .font(.title)
                    .bold()

                Text(advice.reasoning)
                    .multilineTextAlignment(.leading)
                    .font(.body)

                if let tips = advice.tips, !tips.isEmpty {
                    Divider()
                    Text("Tips")
                        .font(.title2)

                    ForEach(tips, id: \.self) {
                        Text("• \($0)")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func callFundationModel() async -> WateringAdviceState {
        let model = DefaultPlantCareModel()
        
        let context = PlantCareContext(plantName: plant.name,
                                       location: plant.location.modelValue,
                                       temperature: plant.temperature.modelValue,
                                       humidity: plant.humidity.modelValue)

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

