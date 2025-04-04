//
//  AddDepenseView.swift
//  Budget
//
//  Created by Rayane KHATIM on 03/04/2025.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddDepenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var budget: Budget

    @State private var nom: String = ""
    @State private var montant: String = ""
    @State private var categorie: String = "Autres"
    @State private var date = Date()
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil

    let categories = ["Alimentation", "Transports", "Loisirs", "Santé", "Factures", "Autres"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Détails de la dépense")) {
                    TextField("Nom", text: $nom)
                    TextField("Montant (€)", text: $montant)
                        .keyboardType(.decimalPad)
                    Picker("Catégorie", selection: $categorie) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat)
                        }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Section(header: Text("Ajouter une photo")) {
                    if let data = imageData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(12)
                    }

                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Label("Choisir dans la galerie", systemImage: "photo")
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                imageData = data
                            }
                        }
                    }
                }
            }
            .navigationTitle("Nouvelle dépense")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ajouter") {
                        if let montantDouble = Double(montant) {
                            let depense = Depense(nom: nom, montant: montantDouble, categorie: categorie, date: date)
                            budget.depenses.append(depense)
                            dismiss()
                        }
                    }
                    .disabled(nom.isEmpty || montant.isEmpty)
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

