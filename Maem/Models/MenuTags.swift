//
//  MenuTag.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation

struct MenuTags: Codable {

    var carbs: [Carb]?
    var veggies: [Veggie]?
    var animalProtein: [AnimalProtein]?
    var plantProtein: [PlantProtein]?
    var toppings: [Topping]?
    var spicy: Bool?
    var texture: [Texture]?
    var allergens: [Allergen]?
    var portion: Portion?
    var isInstant: Bool?
    var isContainPork: Bool?
    var isContainAlcohol: Bool?
    var isDrink: Bool?
    var isDessert: Bool?
    var isSnack: Bool?
    var cookMethod: CookMethod?
    var mealCategory: MealCategory?

    var isKidFriendly: Bool { portion == .kids && spicy == false }

    init(
        carbs: [Carb]? = nil,
        veggies: [Veggie]? = nil,
        animalProtein: [AnimalProtein]? = nil,
        plantProtein: [PlantProtein]? = nil,
        toppings: [Topping]? = nil,
        spicy: Bool? = nil,
        texture: [Texture]? = nil,
        allergens: [Allergen]? = nil,
        portion: Portion? = nil,
        isInstant: Bool? = nil,
        isContainPork: Bool? = nil,
        isContainAlcohol: Bool? = nil,
        isDrink: Bool? = nil,
        isDessert: Bool? = nil,
        isSnack: Bool? = nil,
        cookMethod: CookMethod? = nil,
        mealCategory: MealCategory? = nil
    ) {
        self.carbs = carbs
        self.veggies = veggies
        self.animalProtein = animalProtein
        self.plantProtein = plantProtein
        self.toppings = toppings
        self.spicy = spicy
        self.texture = texture
        self.allergens = allergens
        self.portion = portion
        self.isInstant = isInstant
        self.isContainPork = isContainPork
        self.isContainAlcohol = isContainAlcohol
        self.isDrink = isDrink
        self.isDessert = isDessert
        self.isSnack = isSnack
        self.cookMethod = cookMethod
        self.mealCategory = mealCategory
    }
}

extension MenuTags {

    var displayTags: [DisplayTag] {

        var tags: [DisplayTag] = []
        
        if let allergens, !allergens.isEmpty {
            tags.append(.allergen)
        }

        if spicy == false {
            tags.append(.notSpicy)
        } else if spicy == true {
            tags.append(.spicy)
        }
        
        if portion == .kids {
            tags.append(.kidsPortion)
        }
        
        if let texture {

            if texture.contains(.soupy) {

                tags.append(.soupy)

            }

        }

        if animalProtein != nil || plantProtein != nil {
            tags.append(.protein)
        }

        if let veggies,
           !veggies.isEmpty {

            tags.append(.vegetable)
        }


        return tags

    }

}

extension MenuTags {

    func contains(_ tag: DisplayTag) -> Bool {

        switch tag {

        case .kidsPortion:

            return portion == .kids

        case .protein:

            return !(animalProtein?.isEmpty ?? true)
            || !(plantProtein?.isEmpty ?? true)

        case .notSpicy:

            return spicy == false

        case .spicy:

            return spicy == true

        case .allergen:

            return !(allergens?.isEmpty ?? true)

        case .vegetable:

            return !(veggies?.isEmpty ?? true)

        case .isInstant:

            return isInstant == true

        case .soupy:

            return texture?.contains(.soupy) == true

        case .halal:

            return false

        }

    }

}

extension MenuTags {

    var foodCategories: [FoodCategory] {

        var categories: [FoodCategory] = []

        // Bubur
        if carbs?.contains(.porridge) == true {
            categories.append(.porridge)
        }

        // Berkuah
        if texture?.contains(.soupy) == true {
            categories.append(.soupy)
        }

        // Mie
        if carbs?.contains(.noodle) == true {
            categories.append(.noodle)
        }

        // Nasi
        if carbs?.contains(.rice) == true {
            categories.append(.rice)
        }

        // Ayam / Bebek
        if animalProtein?.contains(.chicken) == true {
            categories.append(.chicken)
        }

        // Ikan / Seafood
        if let proteins = animalProtein,
           proteins.contains(.fish) || proteins.contains(.shrimp) {
            categories.append(.fish)
        }

        // Minuman
        if isDrink == true {
            categories.append(.drink)
        }

        // Snack
        if isSnack == true {
            categories.append(.snack)
        }

        // Dessert
        if isDessert == true {
            categories.append(.dessert)
        }

        // Default
        if categories.isEmpty {
            categories.append(.rice)
        }

        return categories
    }

}
