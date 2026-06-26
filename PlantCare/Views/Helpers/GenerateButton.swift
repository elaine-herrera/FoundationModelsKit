//
//  GenerateButton.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct GenerateButton: View {

    let isDisabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                Text("Generate Care Plan")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
        .buttonStyle(.borderedProminent)
        .tint(.accentColor)
        .controlSize(.large)
        .disabled(isDisabled)
    }
}
