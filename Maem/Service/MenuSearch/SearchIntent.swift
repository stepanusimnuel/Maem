import Foundation
import FoundationModels

@Generable
struct SearchIntent {
    var wantCarbs: [Carb]? = nil
    var wantProteinHewani: [ProteinHewani]? = nil
    var wantProteinNabati: [ProteinNabati]? = nil
    var wantVeggies: [Veggie]? = nil
    var avoidAllergens: [Allergen]? = nil
    var maxBudget: Int? = nil
    var mustNotSpicy: Bool? = nil
    var requireHalal: Bool? = nil
    var forKid: Bool? = nil
    var mealCategory: MealCategory? = nil
    var cookMethodPreference: CookMethod? = nil
    var texturePreference: Texture? = nil
    var preferHealthy: Bool? = nil
}

extension SearchIntent {

    func addingCompositionAndStyle(from other: SearchIntent) -> SearchIntent {
        var copy = self
        copy.wantCarbs = other.wantCarbs
        copy.wantProteinHewani = other.wantProteinHewani
        copy.wantProteinNabati = other.wantProteinNabati
        copy.wantVeggies = other.wantVeggies
        copy.cookMethodPreference = other.cookMethodPreference
        copy.texturePreference = other.texturePreference
        copy.preferHealthy = other.preferHealthy
        return copy
    }

}
