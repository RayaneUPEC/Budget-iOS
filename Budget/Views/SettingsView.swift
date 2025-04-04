//
//  SettingsView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("appearanceMode") private var appearanceMode: String = "auto"

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $appearanceMode) {
                        Label("Automatique", systemImage: "circle.lefthalf.filled").tag("auto")
                        Label("Clair", systemImage: "sun.max.fill").tag("light")
                        Label("Sombre", systemImage: "moon.fill").tag("dark")
                    } label: {
                        Label("Thème de l'app", systemImage: "paintbrush")
                    }
                    .pickerStyle(.inline)
                } header: {
                    Text("Apparence")
                } footer: {
                    Text("Choisissez le mode d’affichage selon vos préférences ou l’heure de la journée.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Section {
                    Link(destination: URL(string: "https://support.apple.com/fr-fr/guide/iphone/iph3e2e2cdc/ios")!) {
                        Label("Support Apple", systemImage: "questionmark.circle")
                    }
                }
            }
            .navigationTitle("Réglages")
        }
        .preferredColorScheme(resolveColorScheme())
    }

    func resolveColorScheme() -> ColorScheme? {
        switch appearanceMode {
        case "light":
            return .light
        case "dark":
            return .dark
        default:
            return nil
        }
    }
}

