//
//  PlannTerApp.swift
//  PlannTer
//
//  Created by Jakub Czajkowski on 24/10/2024.
//
import SwiftUI
import SwiftData

@main
struct PlannTerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [SettingsModel.self, RoomModel.self, PlantModel.self])
    }
}

struct RootView: View {
    @Environment(\.modelContext) private var context
    @Query private var settings: [SettingsModel]
    
    var body: some View {
        MainScreenView()
            .onAppear(perform: {
                if settings.isEmpty {
                    context.insert(SettingsModel())
                }
            }).environment(settings.first)
    }
}

#Preview {
    MainScreenView()
}
