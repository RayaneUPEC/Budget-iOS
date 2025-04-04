//
//  MainTabView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Budgets", systemImage: "list.bullet.rectangle")
                }

            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.pie.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Réglages", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: Budget.self, inMemory: true)
}
