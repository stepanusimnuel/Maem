import Foundation

struct ManualFilterState {
    var maxBudget: Int? = nil
    var forKid = false
    var mustNotSpicy = false
    var requireHalal = false
    var avoidAllergens: Set<Allergen> = []
    var mealCategory: MealCategory? = nil

    func toSearchIntent() -> SearchIntent {
        SearchIntent(
            avoidAllergens: avoidAllergens.isEmpty ? nil : Array(avoidAllergens),
            maxBudget: maxBudget,
            mustNotSpicy: mustNotSpicy ? true : nil,
            requireHalal: requireHalal ? true : nil,
            forKid: forKid ? true : nil,
            mealCategory: mealCategory
        )
    }
}

struct ManualIntentParser: IntentParser {

    let filters: ManualFilterState

    func parse(_ text: String) async throws -> SearchIntent {
        filters.toSearchIntent()
    }
}
