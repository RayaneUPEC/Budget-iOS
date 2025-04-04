# 📱 Budget Familial iOS

> Application **iOS ** pour gérer les **budgets mensuels**, suivre les **dépenses quotidiennes** et activer un **mode économique intelligent**.  
> Développée avec ❤️ en SwiftUI + SwiftData.

---

![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Xcode](https://img.shields.io/badge/Xcode-15.3-blue)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Status](https://img.shields.io/badge/Projet-%20-green)

---

## ✨ Fonctionnalités principales

- 📆 **Création de budgets mensuels** avec montant total
- 📥 **Ajout de dépenses** : nom, montant, catégorie, date
- 🔒 **Mode économique personnalisé**
  - Plafond à ne pas dépasser (ex : 300 € sur 500 €)
  - Avertissements intelligents en fin de mois
- 📊 **Statistiques et graphiques**
  - Répartition des dépenses par **catégorie**
  - **Historique par jour** avec barres
  - Moyenne, jour le plus dépensier, total mensuel
- 👤 **Profil personnel**
  - Photo sélectionnable via PhotosPicker
  - Nom + Email modifiables
- 🌓 **Mode clair/sombre** via réglages
- ⚙️ Interface iOS 17 **moderne et fluide**

---

## 🖼️ Aperçu de l’app *(à personnaliser avec images)*

| Accueil 📋 | Détail 📈 | Statistiques 📊 |
|-----------|----------|----------------|
| ![Accueil](Assets/accueil.png) | ![Détail](Assets/detail.png) | ![Stats](Assets/stats.png) |

> Place tes captures dans un dossier `/Assets/` et adapte les noms si besoin.

---

## 🛠️ Stack technique

- 🧱 `SwiftUI` – UI moderne et déclarative
- 📦 `SwiftData` – Persistance locale native
- 📊 `Charts` – Graphiques avancés intégrés
- 💾 `@AppStorage` – Sauvegarde rapide
- 🖼️ `PhotosPicker` – Gestion de la photo de profil

---

## 🚀 Installation du projet

```bash
git clone https://github.com/RayaneUPEC/Budget-iOS.git
cd Budget-iOS
open Budget.xcodeproj
