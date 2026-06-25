//
//  SearchPlantView.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 22/06/2026.
//
import SwiftUI
import FoundationModelsKit

public struct SearchPlantView: View {
    @StateObject var viewModel: PlantAutocompleteViewModel
    public var onSelect: ((String) -> Void)?

    init(viewModel: PlantAutocompleteViewModel, onSelect: ((String) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelect = onSelect
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField(
                    "Search botanical name (e.g. Quercus alba)",
                    text: Binding(
                        get: { viewModel.query },
                        set: { viewModel.updateQuery($0) }
                    )
                )
                .autocorrectionDisabled()
                .accessibilityLabel("Search botanical name")
                .accessibilityHint("Quercus alba")
                .textFieldStyle(.plain)

                if !viewModel.query.isEmpty {
                    Button(action: viewModel.clear) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(12)
            .background(Color(nsColor: .textBackgroundColor))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.accentColor.opacity(0.3), lineWidth: 1)
            ).onSubmit {
                viewModel.cancel()
                onSelect?(viewModel.query)
            }

            switch viewModel.state {
            case .idle:
                EmptyView()
            case .loading:
                HStack(spacing: 6) {
                    ProgressView()
                    Text("Searching…")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 4)
            case .error(let errorMessage):
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
            case .loaded(let suggestions):
                SuggestionsList(suggestions: suggestions) { species in
                    debugPrint(species)
                    viewModel.select(species)
                    onSelect?(species.displayName)
                }.frame(maxHeight: 250)
            case .empty:
                EmptyView()
            }
        }
    }
}
