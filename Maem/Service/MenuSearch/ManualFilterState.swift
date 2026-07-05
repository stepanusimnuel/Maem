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

    mutating func overwrite(with intent: SearchIntent) {
        if let avoid = intent.avoidAllergens, !avoid.isEmpty {
            avoidAllergens = Set(avoid)
        }
        if let budget = intent.maxBudget {
            maxBudget = budget
        }
        if let spicy = intent.mustNotSpicy {
            mustNotSpicy = spicy
        }
        if let halal = intent.requireHalal {
            requireHalal = halal
        }
        if let kid = intent.forKid {
            forKid = kid
        }
        if let category = intent.mealCategory {
            mealCategory = category
        }
    }
}
