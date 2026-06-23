//
//  SegmentedPickerField.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct SegmentedPickerField<T: Hashable & Identifiable, RowContent: View>: View {

    let title: String
    let systemImage: String

    @Binding var selection: T
    let options: [T]
    let row: (T) -> RowContent

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Label(title, systemImage: systemImage)
                .font(.headline)
                .foregroundColor(.secondary)

            Picker("", selection: $selection) {
                ForEach(options) { value in
                    row(value).tag(value)
                }
            }
            .pickerStyle(.segmented)
            .tint(.accentColor)
        }
    }
}
