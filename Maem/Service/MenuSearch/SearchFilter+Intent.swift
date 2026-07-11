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

    /// Converts the FilterSheet's manual selections into a SearchIntent, folding in
    /// `inferred` (tags the text parser implied — see SearchIntent.impliedTags(),
    /// read from ResultViewModel.lastTextIntent) so a manual "off" tap can produce
    /// an explicit `false` that overrides a text-inferred `true`. `.kidsPortion`
    /// uses the strict isKidFriendly definition (forKid), not a separate raw-portion
    /// concept — spec decision 10. Booleans resolve via `resolve(_:inferred:)`:
    /// excluded beats everything, then selected-or-inferred, else nil (no opinion).
    /// Safety fields (forKid, mustNotSpicy, requireHalal, avoidAllergens) can still
    /// resolve to explicit `false` here, same as any other field — but
    /// SearchIntent.merged(withManual:) OR-combines those specific fields and
    /// ignores manual `false`, so the override has no actual filtering effect for
    /// them. That's intentional (see design spec, "Safety-field lock").
    func toSearchIntent(inferred: Set<DisplayTag> = []) -> SearchIntent {

        var intent = SearchIntent()

        func resolve(_ tag: DisplayTag) -> Bool? {
            if excludedTags.contains(tag) { return false }
            if selectedTags.contains(tag) || inferred.contains(tag) { return true }
            return nil
        }

        intent.forKid = resolve(.kidsPortion)
        intent.requireSpicy = resolve(.spicy)
        intent.mustNotSpicy = resolve(.notSpicy)
        intent.requireInstant = resolve(.isInstant)
        intent.requireHalal = resolve(.halal)
        intent.preferHealthy = resolve(.healthy)

        switch cookMethod {
        case .unset:
            break // leave nil; merged(withManual:) will fall back to whatever text inferred
        case .cleared:
            intent.cookMethodPreference = nil
        case .value(let method):
            intent.cookMethodPreference = method
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
