//
//  PlantAutocompleteViewModel.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 22/06/2026.
//
import Foundation
import FoundationModelsKit
import Combine

enum PlantAutocompleteState: Equatable {
    case idle
    case loading
    case error(errorMessage: String)
    case empty
    case loaded(suggestions: [GBIFSpecies])
}

@MainActor
final class PlantAutocompleteViewModel: ObservableObject {
    @Published private(set) var query: String = ""
    @Published private(set) var state: PlantAutocompleteState = .idle
    private static let minimumQueryLength = 3
    private let searchService: PlantSearchService
    private var searchTask: Task<Void, Never>?

    init(searchService: PlantSearchService) {
        self.searchService = searchService
    }

    /// Single entry point for user-driven text changes. SwiftUI's TextField can
    /// write the current text back through its binding when it resigns focus
    /// (e.g. right after a suggestion tap), even when the value hasn't changed.
    /// Guarding here keeps that from kicking off a redundant search.
    func updateQuery(_ newValue: String) {
        guard newValue != query else { return }
        query = newValue
        queryDidChange(newValue)
    }

    private func queryDidChange(_ newValue: String) {
        searchTask?.cancel()

        let trimmed = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty && trimmed.count >= Self.minimumQueryLength else {
            state = .idle
            return
        }

        searchTask = Task { [weak self] in
            guard let self else { return }

            // Debounce: wait, then bail out silently if a newer keystroke cancelled us.
            do {
                try await Task.sleep(for: .milliseconds(350))
            } catch {
                return
            }
            guard !Task.isCancelled else { return }

            await self.scheduleSearch(for: trimmed)
        }
    }

    private func scheduleSearch(for term: String) async {
        state = .loading

        do {
            let results = try await searchService.search(term)

            guard !Task.isCancelled else { return }

            if results.isEmpty {
                state = .empty
                return
            }
            state = .loaded(suggestions: results)

        } catch is CancellationError {
            // Ignore.
        } catch let error as PlantSearchServiceError {
            state = .error(
                errorMessage: error.localizedDescription
            )

        } catch let error as URLError {
            switch error.code {
            case .notConnectedToInternet:
                state = .error(errorMessage: "No internet connection.")

            case .timedOut:
                state = .error(errorMessage: "The request timed out.")

            default:
                state = .error(errorMessage: "Couldn't load suggestions.")
            }

        } catch {
            state = .error(errorMessage: "Couldn't load suggestions.")
        }
    }

    func select(_ species: GBIFSpecies) {
        searchTask?.cancel()
        searchTask = nil
        state = .idle
        query = species.displayName
    }

    func clear() {
        searchTask?.cancel()
        searchTask = nil
        state = .idle
        query = ""
    }
}
