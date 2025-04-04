//
//  BudgetCardView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI

struct BudgetCardView: View {
    let budget: Budget

    var totalDepenses: Double {
        budget.depenses.reduce(0) { $0 + $1.montant }
    }

    var percentUsed: Double {
        budget.montantTotal == 0 ? 0 : totalDepenses / budget.montantTotal
    }

    var progressColor: Color {
        if percentUsed >= 1.0 {
            return .red
        } else if percentUsed >= 0.9 {
            return .orange
        } else {
            return .green
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(budget.nomMois)
                    .font(.headline)
                Spacer()
                Text("\(totalDepenses, specifier: "%.2f") / \(budget.montantTotal, specifier: "%.2f") €")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            ProgressView(value: percentUsed)
                .tint(progressColor)

            if percentUsed >= 1.0 {
                Text("Dépassement de budget")
                    .font(.caption)
                    .foregroundColor(.red)
            } else if percentUsed >= 0.9 {
                Text("Attention, presque atteint")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
}
