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
    private let plantAutoCompleteViewModel = PlantAutocompleteViewModel(searchService: GBIFPlantSearchService())

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    PlantCareHeaderView()

                    SectionCard {
                        VStack(spacing: 36) {
                            SearchPlantView(viewModel: plantAutoCompleteViewModel) { species in
                                viewModel.plant.name = species.displayName
                                Task { await viewModel.generate() }
                            }

                            HStack {
                                SegmentedPickerField(
                                    title: "Temperature",
                                    systemImage: "thermometer",
                                    selection: $viewModel.plant.temperature,
                                    options: TemperatureInfo.allCases
                                ) { value in
                                    Text(value.title)
                                }.frame(maxWidth: .infinity)
                                SegmentedPickerField(
                                    title: "Location",
                                    systemImage: "house.fill",
                                    selection: $viewModel.plant.location,
                                    options: PlantLocationInfo.allCases
                                ) { value in
                                    Label(value.title, systemImage: value.icon)
                                }.frame(maxWidth: .infinity)
                                SegmentedPickerField(
                                    title: "Humidity",
                                    systemImage: "humidity.fill",
                                    selection: $viewModel.plant.humidity,
                                    options: HumidityInfo.allCases
                                ) { value in
                                    Text(value.title)
                                }.frame(maxWidth: .infinity)
                            }

                            GenerateButton(
                                isDisabled: plantAutoCompleteViewModel.query.isEmpty,
                                action: {
                                    viewModel.plant.name = plantAutoCompleteViewModel.query
                                    Task { await viewModel.generate() }
                                }
                            )
                        }
                    }

                    if viewModel.response != .idle {
                        unsafe resultsSection
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .opacity
                            ))
                    }
                }
            }
            .frame(minWidth: 500, minHeight: 600)
            .background(PlantCareBackground())
            .onChange(of: viewModel.response) { _, newValue in
                switch newValue {
                case .idle:
                    break
                default:
                    withAnimation {
                        proxy.scrollTo("resultsSection", anchor: .top)
                    }
                }
            }
        }
    }

    private var resultsSection: some View {
        SectionCard {
            PlantCareResultView(response: viewModel.response)
        }
        .padding(24)
        .id("resultsSection")
    }
}
