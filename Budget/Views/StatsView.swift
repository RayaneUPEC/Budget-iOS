//
//  StatsView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI
import Charts
import SwiftData

struct StatsView: View {
    @Query private var budgets: [Budget]

    @State private var selectedYear = Calendar.current.component(.year, from: Date())

    var budgetsDeLAnnee: [Budget] {
        budgets.filter {
            Calendar.current.component(.year, from: $0.date) == selectedYear
        }
    }

    var totalDepensesAnnuelles: Double {
        budgetsDeLAnnee.flatMap { $0.depenses }.reduce(0) { $0 + $1.montant }
    }

    var depensesParMois: [(String, Double)] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "MMMM"

        var result: [String: Double] = [:]

        for budget in budgetsDeLAnnee {
            let mois = budget.nomMois
            let total = budget.depenses.reduce(0) { $0 + $1.montant }
            result[mois, default: 0] += total
        }

        return result.sorted { $0.key < $1.key }
    }

    var depensesParCategorie: [String: Double] {
        let toutes = budgetsDeLAnnee.flatMap { $0.depenses }
        return Dictionary(grouping: toutes, by: { $0.categorie })
            .mapValues { $0.reduce(0) { $0 + $1.montant } }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Picker("Année", selection: $selectedYear) {
                        ForEach(anneesDisponibles(), id: \.self) { year in
                            Text("\(year)").tag(year)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)

                    GroupBox(label: Text("Dépenses globales")) {
                        VStack(alignment: .leading) {
                            Text("Total : \(totalDepensesAnnuelles, specifier: "%.2f") €")
                            Text("Moyenne mensuelle : \((totalDepensesAnnuelles / Double(budgetsDeLAnnee.count)), specifier: "%.2f") €")
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .padding(.horizontal)

                    if !depensesParMois.isEmpty {
                        GroupBox(label: Text("Par mois")) {
                            Chart {
                                ForEach(depensesParMois, id: \.0) { mois, montant in
                                    BarMark(
                                        x: .value("Mois", mois),
                                        y: .value("Montant", montant)
                                    )
                                }
                            }
                            .frame(height: 200)
                        }
                        .padding(.horizontal)
                    }

                    if !depensesParCategorie.isEmpty {
                        GroupBox(label: Text("Par catégorie")) {
                            Chart {
                                ForEach(depensesParCategorie.sorted(by: { $0.value > $1.value }), id: \.key) { categorie, montant in
                                    SectorMark(
                                        angle: .value("Montant", montant),
                                        innerRadius: .ratio(0.6),
                                        angularInset: 2
                                    )
                                    .foregroundStyle(by: .value("Catégorie", categorie))
                                }
                            }
                            .frame(height: 200)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Statistiques")
        }
    }

    func anneesDisponibles() -> [Int] {
        let annees = budgets.map { Calendar.current.component(.year, from: $0.date) }
        return Array(Set(annees)).sorted()
    }
}
