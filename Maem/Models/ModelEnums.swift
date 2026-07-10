//
//  ModelEnums.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//


import Foundation

enum Allergen: String, CaseIterable, Codable {

    case peanut = "Kacang"

    case milk = "Susu"

    case shrimp = "Udang"
    
    case shellfish = "Kerang"
    
    case fish = "Ikan"

    case egg = "Telur"

    case gluten = "Gluten"
    
    case sesame = "Wijen"

}

enum Carb: String, Codable {

    case rice
    case noodle
    case bread
    case potato
    case porridge
    case none

}

enum AnimalProtein: String, Codable {

    case chicken

    case beef

    case fish

    case shrimp

    case egg

}

enum PlantProtein: String, Codable {

    case tofu

    case tempeh

    case mushroom

    case bean

}

enum Portion: String, Codable {
    case kids
    
    case reguler
    
    case sharing
}

enum Texture: String, Codable {
    case soupy
    
    case soft
    
    case crispy
    
    case dry
}

enum Veggie: String, Codable {
    case soup
    
    case spinach
    
    case tomato
    
    case carrot
}

enum Topping: String, Codable {
    case tomato_sauce
    
    case chili_sauce
    
    case crackers
    
    case soy_sauce
    
    case chili_oil
}
