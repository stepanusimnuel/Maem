import Foundation
import SwiftData

@Model
final class MenuItem {

    var name: String
    var price: Int
    var carbs: [Carb]
    var proteinHewani: [ProteinHewani]
    var proteinNabati: [ProteinNabati]
    var veggies: [Veggie]
    var toppings: [Topping]
    var allergens: [Allergen]
    var isPedas: Bool
    var texture: Texture
    var mealCategory: MealCategory
    var cookMethod: CookMethod
    var portion: Portion
    var isInstant: Bool
    var containsPork: Bool
    var containsAlcohol: Bool
    var tenant: Tenant?

    var isVegetarian: Bool { proteinHewani.isEmpty }
    var isKidFriendly: Bool { !isPedas && (texture == .lembut || texture == .berkuah) }

    init(
        name: String,
        price: Int,
        carbs: [Carb],
        proteinHewani: [ProteinHewani],
        proteinNabati: [ProteinNabati],
        veggies: [Veggie],
        toppings: [Topping],
        allergens: [Allergen],
        isPedas: Bool,
        texture: Texture,
        mealCategory: MealCategory,
        cookMethod: CookMethod,
        portion: Portion,
        isInstant: Bool,
        containsPork: Bool,
        containsAlcohol: Bool
    ) {
        self.name = name
        self.price = price
        self.carbs = carbs
        self.proteinHewani = proteinHewani
        self.proteinNabati = proteinNabati
        self.veggies = veggies
        self.toppings = toppings
        self.allergens = allergens
        self.isPedas = isPedas
        self.texture = texture
        self.mealCategory = mealCategory
        self.cookMethod = cookMethod
        self.portion = portion
        self.isInstant = isInstant
        self.containsPork = containsPork
        self.containsAlcohol = containsAlcohol
    }
}
