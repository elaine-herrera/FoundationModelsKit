//
//  PlantCareBackground.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 13/5/26.
//
import SwiftUI

struct PlantCareBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(nsColor: .windowBackgroundColor),
                Color.accentColor.opacity(0.03)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
