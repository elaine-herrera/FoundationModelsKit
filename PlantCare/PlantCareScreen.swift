//
//  PlantCareScreen.swift
//  FoundationModelsKit
//
//  Created by Elaine Herrera on 19/12/25.
//
import SwiftUI
import FoundationModelsKit

struct PlantCareScreen: View {
    @State private var response: WateringAdviceState = .idle
    @State private var plant: PlantContextInfo = .init(name: "Cactus")

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header Section
                headerSection
                
                // Input Form Section
                VStack(spacing: 20) {
                    plantNameField
                    locationPicker
                    environmentSection
                    generateButton
                }
                .padding(24)
                .background(Color(nsColor: .controlBackgroundColor))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                
                // Results Section
                if response != .idle {
                    resultsSection
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .opacity
                        ))
                }
            }
        }
        .frame(minWidth: 500, minHeight: 600)
        .background(
            LinearGradient(
                colors: [
                    Color(nsColor: .windowBackgroundColor),
                    Color.green.opacity(0.03)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
    
    // MARK: - Header Section
    
    private var headerSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 48))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.green, Color.green.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color.green.opacity(0.3), radius: 8, x: 0, y: 4)
            
            Text("Plant Care Advisor")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
            
            Text("Get personalized watering recommendations")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 32)
        .padding(.bottom, 24)
    }
    
    // MARK: - Input Fields
    
    private var plantNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Plant Name", systemImage: "textformat")
                .font(.headline)
                .foregroundColor(.secondary)
            
            TextField("e.g., Monstera, Cactus, Peace Lily", text: $plant.name)
                .textFieldStyle(.plain)
                .padding(12)
                .background(Color(nsColor: .textBackgroundColor))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.green.opacity(0.3), lineWidth: 1)
                )
        }
    }
    
    private var locationPicker: some View {
        VStack(alignment: .center, spacing: 8) {
            Label("Location", systemImage: "location.fill")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Picker("", selection: $plant.location) {
                ForEach(PlantLocationInfo.allCases) { value in
                    Label(value.title, systemImage: value.icon)
                        .tag(value)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private var environmentSection: some View {
        VStack(alignment: .center, spacing: 16) {
            customPicker(
                title: "Temperature",
                icon: "thermometer",
                selection: $plant.temperature,
                options: TemperatureInfo.allCases
            )
            
            customPicker(
                title: "Humidity",
                icon: "humidity.fill",
                selection: $plant.humidity,
                options: HumidityInfo.allCases
            )
        }
    }
    
    private func customPicker<T: Hashable & CaseIterable & Identifiable>(
        title: String,
        icon: String,
        selection: Binding<T>,
        options: [T]
    ) -> some View where T: TitleProvider {
        VStack(alignment: .center, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.headline)
                .foregroundColor(.secondary)
            
            Picker("", selection: selection) {
                ForEach(options) { value in
                    Text(value.title).tag(value)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private var generateButton: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                response = .loading
            }
            Task {
                let result = await getWateringAdvice()
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    response = result
                }
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                Text("Generate Care Plan")
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
        .controlSize(.large)
        .disabled(plant.name.isEmpty)
    }
    
    // MARK: - Results Section
    
    private var resultsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }

    @ViewBuilder
    private var content: some View {
        switch response {
        case .idle:
            EmptyView()
            
        case .loading:
            HStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(0.8)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Analyzing your plant...")
                        .font(.headline)
                    Text("Creating personalized care recommendations")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical, 32)

        case .modelUnavailable:
            errorCard(
                icon: "exclamationmark.triangle.fill",
                title: "Model Unavailable",
                message: "FoundationModel is not available on this device.",
                color: .orange
            )

        case .failed(let error):
            errorCard(
                icon: "xmark.circle.fill",
                title: "Generation Failed",
                message: error.localizedDescription,
                color: .red
            )

        case .loaded(let advice):
            VStack(alignment: .leading, spacing: 20) {
                // Main advice card
                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 48))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, Color.blue.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Water every")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("\(advice.wateringIntervalDays)")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                            Text("days")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.blue.opacity(0.08))
                .cornerRadius(12)
                
                // Reasoning
                VStack(alignment: .leading, spacing: 8) {
                    Label("Reasoning", systemImage: "lightbulb.fill")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(advice.reasoning)
                        .font(.body)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(nsColor: .textBackgroundColor))
                .cornerRadius(12)

                // Tips
                if let tips = advice.tips, !tips.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Care Tips", systemImage: "star.fill")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(Array(tips.enumerated()), id: \.offset) { index, tip in
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "\(index + 1).circle.fill")
                                        .foregroundColor(.green)
                                        .font(.title3)
                                    Text(tip)
                                        .font(.body)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green.opacity(0.08))
                    .cornerRadius(12)
                }
            }
        }
    }
    
    private func errorCard(icon: String, title: String, message: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }

    private func getWateringAdvice() async -> WateringAdviceState {
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

// MARK: - Protocol Extensions

protocol TitleProvider {
    var title: String { get }
}

extension PlantLocationInfo {
    var icon: String {
        switch self {
        case .indoor: return "house.fill"
        case .outdoor: return "sun.max.fill"
        }
    }
}

extension PlantLocationInfo: TitleProvider {}
extension TemperatureInfo: TitleProvider {}
extension HumidityInfo: TitleProvider {}
