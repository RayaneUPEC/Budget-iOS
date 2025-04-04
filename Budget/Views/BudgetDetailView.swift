//
//  BudgetDetailView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI
import Charts

struct BudgetDetailView: View {
    @State var budget: Budget

    var totalDepenses: Double {
        budget.depenses.reduce(0) { $0 + $1.montant }
    }

    var depensesParCategorie: [String: Double] {
        Dictionary(grouping: budget.depenses, by: { $0.categorie })
            .mapValues { $0.reduce(0) { $0 + $1.montant } }
    }

    var depassement: Bool {
        totalDepenses >= budget.montantTotal
    }

    var presqueDepasse: Bool {
        totalDepenses >= 0.9 * budget.montantTotal
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Résumé
                VStack(alignment: .leading, spacing: 10) {
                    Text("Dépensé : \(totalDepenses, specifier: "%.2f") €")
                        .font(.title2)
                    Text("Budget : \(budget.montantTotal, specifier: "%.2f") €")
                        .foregroundColor(.secondary)

                    ProgressView(value: totalDepenses, total: budget.montantTotal)
                        .tint(depassement ? .red : presqueDepasse ? .orange : .green)
                    
                    if depassement {
                        Text("Vous avez dépassé votre budget !")
                            .foregroundColor(.red)
                            .bold()
                    } else if presqueDepasse {
                        Text("Attention, vous approchez de la limite.")
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)

                // Graphique par catégorie
                if !budget.depenses.isEmpty {
                    Chart {
                        ForEach(depensesParCategorie.sorted(by: { $0.key < $1.key }), id: \.key) { categorie, montant in
                            SectorMark(
                                angle: .value("Montant", montant),
                                innerRadius: .ratio(0.6),
                                angularInset: 2
                            )
                            .foregroundStyle(by: .value("Catégorie", categorie))
                        }
                    }
                    .chartLegend(.visible)
                    .frame(height: 200)
                    .padding(.horizontal)
                }

                // Liste des dépenses
                VStack(alignment: .leading, spacing: 10) {
                    Text("Dépenses")
                        .font(.headline)
                        .padding(.bottom, 5)

                    ForEach(budget.depenses) { depense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(depense.nom)
                                    .fontWeight(.medium)
                                Text(depense.categorie)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("\(depense.montant, specifier: "%.2f") €")
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle(budget.nomMois)
        .toolbar {
            NavigationLink(destination: AddDepenseView(budget: $budget)) {
                Label("Ajouter", systemImage: "plus.circle.fill")
            }
        }
    }
}
