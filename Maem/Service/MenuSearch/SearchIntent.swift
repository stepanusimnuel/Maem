import Foundation
import FoundationModels

@Generable
struct SearchIntent {
    var wantCarbs: [Carb]? = nil
    var wantProteinHewani: [AnimalProtein]? = nil
    var wantProteinNabati: [PlantProtein]? = nil
    var wantVeggies: [Veggie]? = nil
    var avoidAllergens: [Allergen]? = nil
    var maxBudget: Int? = nil
    var minBudget: Int? = nil
    var mustNotSpicy: Bool? = nil
    var requireSpicy: Bool? = nil
    var requireInstant: Bool? = nil
    var requireHalal: Bool? = nil
    var forKid: Bool? = nil
    var mealCategory: MealCategory? = nil
    var cookMethodPreference: CookMethod? = nil
    var texturePreference: Texture? = nil
    var preferHealthy: Bool? = nil
    var nameHints: [String]? = nil
    var nameRelevanceWords: [String]? = nil
}

extension SearchIntent {

    /// Merges `self` (typically the free-text-parsed intent) with `manual`
    /// (typically the FilterSheet-derived intent from `SearchFilter.toSearchIntent()`).
    /// Safety fields are OR-combined (never dropped by either side); all other
    /// fields let `manual` win when both are set, since a manual UI selection
    /// is a deliberate, explicit action — more authoritative than a heuristic
    /// text parse. See spec "Manual Filter → SearchIntent Mapping".
    func merged(withManual manual: SearchIntent) -> SearchIntent {
        var result = self

        result.wantCarbs = manual.wantCarbs ?? result.wantCarbs
        result.wantProteinHewani = manual.wantProteinHewani ?? result.wantProteinHewani
        result.wantProteinNabati = manual.wantProteinNabati ?? result.wantProteinNabati
        result.wantVeggies = manual.wantVeggies ?? result.wantVeggies
        result.maxBudget = manual.maxBudget ?? result.maxBudget
        result.minBudget = manual.minBudget ?? result.minBudget
        result.mealCategory = manual.mealCategory ?? result.mealCategory
        result.texturePreference = manual.texturePreference ?? result.texturePreference
        result.cookMethodPreference = manual.cookMethodPreference ?? result.cookMethodPreference
        result.requireInstant = manual.requireInstant ?? result.requireInstant
        result.requireSpicy = manual.requireSpicy ?? result.requireSpicy
        result.nameHints = result.nameHints ?? manual.nameHints
        result.nameRelevanceWords = result.nameRelevanceWords ?? manual.nameRelevanceWords
        result.preferHealthy = manual.preferHealthy ?? result.preferHealthy

        let combinedAllergens = Set(result.avoidAllergens ?? []).union(manual.avoidAllergens ?? [])
        result.avoidAllergens = combinedAllergens.isEmpty ? nil : Array(combinedAllergens)
        result.requireHalal = (result.requireHalal == true || manual.requireHalal == true) ? true : nil
        result.forKid = (result.forKid == true || manual.forKid == true) ? true : nil
        result.mustNotSpicy = (result.mustNotSpicy == true || manual.mustNotSpicy == true) ? true : nil

        return result
    }

}

extension SearchIntent {

    /// Maps the fields FilterSheet has a chip for onto the tags that chip
    /// should show as "implied by text" — read by FilterSheet (via
    /// ResultViewModel.lastTextIntent) to light up chips the parser inferred,
    /// without requiring the user to have tapped them manually.
    func impliedTags() -> Set<DisplayTag> {
        var tags: Set<DisplayTag> = []
        if forKid == true { tags.insert(.kidsPortion) }
        if requireSpicy == true { tags.insert(.spicy) }
        if mustNotSpicy == true { tags.insert(.notSpicy) }
        if requireInstant == true { tags.insert(.isInstant) }
        if requireHalal == true { tags.insert(.halal) }
        if preferHealthy == true { tags.insert(.healthy) }
        return tags
    }

}
