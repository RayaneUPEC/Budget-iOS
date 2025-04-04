//
//  AddBudgetView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI

struct AddBudgetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var nomMois: String = ""
    @State private var montant: String = ""
    @State private var date = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations du budget")) {
                    TextField("Nom du mois", text: $nomMois)
                    TextField("Montant total (€)", text: $montant)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Nouveau Budget")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ajouter") {
                        if let montantDouble = Double(montant) {
                            let newBudget = Budget(nomMois: nomMois, montantTotal: montantDouble)
                            modelContext.insert(newBudget)
                            dismiss()
                        }
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
            }
        }
    }
}
