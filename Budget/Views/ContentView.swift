//
//  ContentView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var budgets: [Budget]

    @State private var showingAddBudget = false

    var body: some View {
        NavigationView {
            List {
                ForEach(budgets) { budget in
                    NavigationLink(destination: BudgetDetailView(budget: budget)) {
                        VStack(alignment: .leading) {
                            Text(budget.nomMois)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Total : \(budget.montantTotal, specifier: "%.2f") €")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .onDelete(perform: deleteBudgets)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Mes Budgets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingAddBudget = true }) {
                        Label("Ajouter", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBudget) {
                AddBudgetView()
            }
        }
    }

    private func deleteBudgets(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(budgets[index])
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Budget.self, inMemory: true)
}
