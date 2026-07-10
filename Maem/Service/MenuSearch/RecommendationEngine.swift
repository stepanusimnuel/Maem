import Foundation
import SwiftData

struct ScoredMenuItem: Identifiable, Hashable {
    var id: PersistentIdentifier { menuItem.persistentModelID }
    let menuItem: Menu
    let tenant: Tenant
    let score: Int
    let halalWarning: String?
    let spicyWarning: String?
    let isKidFriendlyMatch: Bool
}

struct RecommendationResult {
    let items: [ScoredMenuItem]
    let relaxationNotes: [String]
    let bindingConstraint: String?
}

struct RecommendationEngine {

    private struct Relaxation {
        var composition = false
        var budgetMultiplier: Double = 1.0
        var style = false
        var forKid = false
    }

    private struct Rung {
        let relaxation: Relaxation
        let note: String
    }

    private struct Candidate {
        let menuItem: Menu
        let tenant: Tenant
    }

    func recommend(menus: [Menu], intent: SearchIntent) -> RecommendationResult {

        let rungs: [Rung] = [
            Rung(
                relaxation: Relaxation(composition: false, budgetMultiplier: 1.0, style: false, forKid: false),
                note: ""
            ),
            Rung(
                relaxation: Relaxation(composition: true, budgetMultiplier: 1.0, style: false, forKid: false),
                note: ""
            ),
            Rung(
                relaxation: Relaxation(composition: true, budgetMultiplier: 1.2, style: false, forKid: false),
                note: "Harga sedikit di atas budget yang diminta."
            ),
            Rung(
                relaxation: Relaxation(composition: true, budgetMultiplier: 1.2, style: true, forKid: false),
                note: "Preferensi kategori/tekstur/cara masak dilonggarkan."
            ),
            Rung(
                relaxation: Relaxation(composition: true, budgetMultiplier: 1.2, style: true, forKid: true),
                note: "Beberapa menu di bawah belum tentu ramah anak."
            )
        ]

        var appliedRelaxation = rungs[0].relaxation
        var notes: [String] = []
        var matched: [Candidate] = []

        for (index, rung) in rungs.enumerated() {
            let found = candidates(from: menus, intent: intent, relaxation: rung.relaxation)
            if !found.isEmpty {
                matched = found
                appliedRelaxation = rung.relaxation
                if index > 0 {
                    notes = (1...index).compactMap { i -> String? in
                        let note = (i == 1) ? compositionRelaxationNote(for: intent) : rungs[i].note
                        return note.isEmpty ? nil : note
                    }
                }
                break
            }
        }

        guard !matched.isEmpty else {
            return RecommendationResult(
                items: [],
                relaxationNotes: [],
                bindingConstraint: bindingConstraint(for: intent)
            )
        }

        let scored = matched
            .map { score(for: $0, intent: intent, relaxation: appliedRelaxation) }
            .sorted { lhs, rhs in
                if lhs.score != rhs.score { return lhs.score > rhs.score }
                return lhs.menuItem.price < rhs.menuItem.price
            }

        return RecommendationResult(items: scored, relaxationNotes: notes, bindingConstraint: nil)
    }

    private func candidates(from menus: [Menu], intent: SearchIntent, relaxation: Relaxation) -> [Candidate] {

        menus.compactMap { menu -> Candidate? in

            guard let tenant = menu.tenant else { return nil }

            let allergens = menu.tags.allergens ?? []
            if let avoid = intent.avoidAllergens, !avoid.isEmpty,
               !Set(allergens).isDisjoint(with: avoid) {
                return nil
            }

            if intent.requireHalal == true {
                switch tenant.halalStatus {
                case .bersertifikat:
                    break
                case .belumSertifikasi:
                    if (menu.tags.isContainPork ?? false) || (menu.tags.isContainAlcohol ?? false) { return nil }
                case .nonHalal:
                    return nil
                }
            }

            if let maxBudget = intent.maxBudget {
                let budgetLimit = Double(maxBudget) * relaxation.budgetMultiplier
                if Double(menu.price) > budgetLimit { return nil }
            }

            if let minBudget = intent.minBudget, menu.price < minBudget {
                return nil
            }

            let nameHintMatchedThisItem = intent.nameHints?.contains {
                menu.name.localizedCaseInsensitiveContains($0)
            } ?? false

            let isPedas = menu.tags.spicy ?? false
            if intent.mustNotSpicy == true, isPedas {
                if intent.forKid == true || !nameHintMatchedThisItem {
                    return nil
                }
            }

            if intent.requireSpicy == true, !isPedas {
                return nil
            }

            if intent.requireInstant == true, !(menu.tags.isInstant ?? false) {
                return nil
            }

            if intent.forKid == true, !relaxation.forKid, !menu.tags.isKidFriendly {
                return nil
            }

            if !relaxation.composition {
                if let wantCarbs = intent.wantCarbs, !wantCarbs.isEmpty,
                   Set(menu.tags.carbs ?? []).isDisjoint(with: wantCarbs) {
                    return nil
                }
                if let wantProteinHewani = intent.wantProteinHewani, !wantProteinHewani.isEmpty,
                   Set(menu.tags.animalProtein ?? []).isDisjoint(with: wantProteinHewani) {
                    return nil
                }
                if let wantProteinNabati = intent.wantProteinNabati, !wantProteinNabati.isEmpty,
                   Set(menu.tags.plantProtein ?? []).isDisjoint(with: wantProteinNabati) {
                    return nil
                }
                if let wantVeggies = intent.wantVeggies, !wantVeggies.isEmpty,
                   Set(menu.tags.veggies ?? []).isDisjoint(with: wantVeggies) {
                    return nil
                }
                if let hints = intent.nameHints, !hints.isEmpty, !nameHintMatchedThisItem {
                    return nil
                }
            }

            if !relaxation.style {
                if let mealCategory = intent.mealCategory, menu.tags.mealCategory != mealCategory {
                    return nil
                }
                if let texturePreference = intent.texturePreference,
                   !(menu.tags.texture ?? []).contains(texturePreference) {
                    return nil
                }
            }

            return Candidate(menuItem: menu, tenant: tenant)
        }
    }

    private func score(for candidate: Candidate, intent: SearchIntent, relaxation: Relaxation) -> ScoredMenuItem {

        let menu = candidate.menuItem
        var points = 0

        if let wantCarbs = intent.wantCarbs, !Set(menu.tags.carbs ?? []).isDisjoint(with: wantCarbs) {
            points += 3
        }
        if let wantProteinHewani = intent.wantProteinHewani,
           !Set(menu.tags.animalProtein ?? []).isDisjoint(with: wantProteinHewani) {
            points += 3
        }
        if let wantProteinNabati = intent.wantProteinNabati,
           !Set(menu.tags.plantProtein ?? []).isDisjoint(with: wantProteinNabati) {
            points += 3
        }

        let nameHintMatchedThisItem = intent.nameHints?.contains {
            menu.name.localizedCaseInsensitiveContains($0)
        } ?? false
        if nameHintMatchedThisItem {
            points += 3
        }

        if intent.forKid == true, menu.tags.isKidFriendly {
            points += 2
        }

        if let wantVeggies = intent.wantVeggies {
            points += Set(menu.tags.veggies ?? []).intersection(wantVeggies).count
        }

        if !relaxation.style, let cookMethodPreference = intent.cookMethodPreference,
           menu.tags.cookMethod == cookMethodPreference {
            points += 1
        }

        if intent.preferHealthy == true {
            if !(menu.tags.isInstant ?? false) {
                points += 1
            }
            if let cookMethod = menu.tags.cookMethod,
               [.steamed, .boiled, .roasted, .rawSalad].contains(cookMethod) {
                points += 1
            }
        }

        let halalWarning: String? =
            (intent.requireHalal == true && candidate.tenant.halalStatus == .belumSertifikasi)
            ? "Belum tersertifikasi halal, cek mandiri."
            : nil

        let isPedas = menu.tags.spicy ?? false
        let spicyWarning: String? =
            (intent.mustNotSpicy == true && isPedas && nameHintMatchedThisItem && intent.forKid != true)
            ? "Menu ini pedas."
            : nil

        return ScoredMenuItem(
            menuItem: menu,
            tenant: candidate.tenant,
            score: points,
            halalWarning: halalWarning,
            spicyWarning: spicyWarning,
            isKidFriendlyMatch: menu.tags.isKidFriendly
        )
    }

    private func compositionRelaxationNote(for intent: SearchIntent) -> String {

        var missing: [String] = []
        if let hints = intent.nameHints { missing += hints }
        if let carbs = intent.wantCarbs { missing += carbs.map(\.rawValue) }
        if let ph = intent.wantProteinHewani { missing += ph.map(\.rawValue) }
        if let pn = intent.wantProteinNabati { missing += pn.map(\.rawValue) }

        guard !missing.isEmpty else {
            return "Kriteria bahan dilonggarkan jadi nilai tambah, bukan syarat wajib."
        }

        return "Tidak ada menu \"\(missing.joined(separator: ", "))\" yang cocok dengan kriteria lain (alergen/halal/dll) — berikut menu lain yang tetap memenuhi kriteria tersebut."
    }

    private func bindingConstraint(for intent: SearchIntent) -> String {

        var reasons: [String] = []

        if let avoid = intent.avoidAllergens, !avoid.isEmpty {
            reasons.append("menghindari alergen \(avoid.map(\.rawValue).joined(separator: ", "))")
        }
        if intent.requireHalal == true {
            reasons.append("harus halal")
        }
        if intent.forKid == true, intent.mustNotSpicy == true {
            reasons.append("tidak boleh pedas untuk anak")
        }

        guard !reasons.isEmpty else {
            return "Tidak ada menu yang cocok dengan kombinasi kriteria ini."
        }

        return "Tidak ada menu yang cocok karena tetap harus " + reasons.joined(separator: " dan ") + "."
    }
}
