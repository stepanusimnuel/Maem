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
        isContainAlcohol: Bool? = nil
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
    }
}

extension MenuTags {

    var displayTags: [DisplayTag] {

        var tags: [DisplayTag] = []

        if portion == .kids {
            tags.append(.kidsPortion)
        }

        if animalProtein != nil || plantProtein != nil {
            tags.append(.protein)
        }

        if spicy == false {
            tags.append(.notSpicy)
        }

        if let allergens,
           !allergens.isEmpty {

            tags.append(.allergen)
        }

        if let veggies,
           !veggies.isEmpty {

            tags.append(.vegetable)
        }

        if let texture {

            if texture.contains(.soft) ||
                texture.contains(.soupy) {

                tags.append(.easyToChew)

            }

        }

        return tags

    }

}
