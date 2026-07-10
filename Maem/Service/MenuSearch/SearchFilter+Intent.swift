import Foundation

extension FoodCategory {

    /// Maps a single selected category onto the existing/extended SearchIntent
    /// composition and style fields — FoodCategory has no field of its own.
    /// See spec "Manual Filter → SearchIntent Mapping".
    func apply(to intent: inout SearchIntent) {
        switch self {
        case .rice:
            intent.wantCarbs = [.rice]
        case .noodle:
            intent.wantCarbs = [.noodle]
        case .porridge:
            intent.wantCarbs = [.porridge]
        case .chicken:
            intent.wantProteinHewani = [.chicken]
        case .fish:
            intent.wantProteinHewani = [.fish, .shrimp]
        case .soupy:
            intent.texturePreference = .soupy
        case .snack:
            intent.mealCategory = .snack
        case .drink:
            intent.mealCategory = .drink
        case .dessert:
            intent.mealCategory = .dessert
        }
    }

}

extension SearchFilter {

    /// Converts the FilterSheet's manual selections into a SearchIntent. `.kidsPortion`
    /// uses the strict isKidFriendly definition (forKid), not a separate raw-portion
    /// concept — spec decision 10. Only 4 of DisplayTag's 9 cases are wired here because
    /// FilterSheet's tagSection only ever offers [.isInstant, .spicy, .kidsPortion, .halal]
    /// (confirmed in FilterSheet.swift) — the rest of DisplayTag has no UI control yet.
    func toSearchIntent() -> SearchIntent {

        var intent = SearchIntent()

        if tags.contains(.kidsPortion) {
            intent.forKid = true
        }
        if tags.contains(.spicy) {
            intent.requireSpicy = true
        }
        if tags.contains(.isInstant) {
            intent.requireInstant = true
        }
        if tags.contains(.halal) {
            intent.requireHalal = true
        }

        if !allergens.isEmpty {
            intent.avoidAllergens = Array(allergens)
        }

        if let category {
            category.apply(to: &intent)
        }

        switch priceFilter {
        case .below50:
            intent.maxBudget = 50_000
        case .between50And100:
            intent.minBudget = 50_000
            intent.maxBudget = 100_000
        case .above100:
            intent.minBudget = 100_000
        case nil:
            break
        }

        if let manualMin = Int(minimumPrice) {
            intent.minBudget = max(intent.minBudget ?? 0, manualMin)
        }
        if let manualMax = Int(maximumPrice) {
            intent.maxBudget = intent.maxBudget.map { Swift.min($0, manualMax) } ?? manualMax
        }

        return intent
    }

}
