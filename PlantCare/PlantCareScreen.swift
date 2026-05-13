//
//  PlantCareScreen.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 19/12/25.
//
import SwiftUI
import FoundationModelsKit

struct PlantCareScreen: View {
    @StateObject private var viewModel = PlantCareViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                PlantCareHeaderView()

                SectionCard {
                    VStack(spacing: 20) {
                        LabeledTextField(
                            title: "Plant Name",
                            systemImage: "textformat",
                            placeholder: "e.g., Monstera, Cactus, Peace Lily",
                            text: $viewModel.plant.name
                        )

                        SegmentedPickerField(
                            title: "Location",
                            systemImage: "location.fill",
                            selection: $viewModel.plant.location,
                            options: PlantLocationInfo.allCases
                        ) { value in
                            Label(value.title, systemImage: value.icon)
                        }

                        SegmentedPickerField(
                            title: "Temperature",
                            systemImage: "thermometer",
                            selection: $viewModel.plant.temperature,
                            options: TemperatureInfo.allCases
                        ) { value in
                            Text(value.title)
                        }

                        SegmentedPickerField(
                            title: "Humidity",
                            systemImage: "humidity.fill",
                            selection: $viewModel.plant.humidity,
                            options: HumidityInfo.allCases
                        ) { value in
                            Text(value.title)
                        }

                        GenerateButton(
                            isDisabled: viewModel.plant.name.isEmpty,
                            action: {
                                Task { await viewModel.generate() }
                            }
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)

                if viewModel.response != .idle {
                    resultsSection
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .opacity
                        ))
                }
            }
        }
        .frame(minWidth: 500, minHeight: 600)
        .background(PlantCareBackground())
    }

    private var resultsSection: some View {
        SectionCard {
            PlantCareResultView(response: viewModel.response)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }
}
