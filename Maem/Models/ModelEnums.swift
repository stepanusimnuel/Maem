//
//  ModelEnums.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation
import FoundationModels

enum HalalStatus: String, CaseIterable, Codable {
    case bersertifikat = "Bersertifikat"
    case belumSertifikasi = "Belum Tersertifikasi"
    case nonHalal = "Non-Halal"
}

@Generable
enum Allergen: String, CaseIterable, Codable {
    case peanut = "Kacang"
    case milk = "Susu"
    case shrimp = "Udang"
    case shellfish = "Kerang"
    case fish = "Ikan"
    case egg = "Telur"
    case gluten = "Gluten"
    case sesame = "Wijen"
    case soy = "Kedelai"
}

@Generable
enum Carb: String, CaseIterable, Codable {
    case rice = "Nasi"
    case noodle = "Mie"
    case bread = "Roti"
    case potato = "Kentang"
    case friedRice = "Nasi Goreng"
    case vermicelli = "Bihun"
    case flatNoodle = "Kwetiau"
    case glutinousRiceCake = "Lontong Ketupat"
    case porridge = "Bubur"
    case pasta = "Pasta"
    case corn = "Jagung"
    case cassava = "Singkong"
    case none = "Tidak Ada"
}

@Generable
enum AnimalProtein: String, CaseIterable, Codable {
    case chicken = "Ayam"
    case beef = "Sapi"
    case fish = "Ikan"
    case shrimp = "Udang"
    case egg = "Telur"
    case goat = "Kambing"
    case duck = "Bebek"
    case meatball = "Bakso"
    case sausage = "Sosis"
}

@Generable
enum PlantProtein: String, CaseIterable, Codable {
    case tofu = "Tahu"
    case tempeh = "Tempe"
    case mushroom = "Jamur"
    case bean = "Kacang"
    case edamame = "Edamame"
}

enum Portion: String, CaseIterable, Codable {
    case kids = "Anak"
    case reguler = "Reguler"
    case sharing = "Sharing"
}

@Generable
enum Texture: String, CaseIterable, Codable {
    case soupy = "Berkuah"
    case soft = "Lembut"
    case crispy = "Renyah"
    case dry = "Kering"
    case sticky = "Lengket"
}

@Generable
enum Veggie: String, CaseIterable, Codable {
    case soup = "Sop"
    case spinach = "Bayam"
    case tomato = "Tomat"
    case carrot = "Wortel"
    case waterSpinach = "Kangkung"
    case greenBeans = "Buncis"
    case beanSprout = "Toge"
    case broccoli = "Brokoli"
    case eggplant = "Terong"
    case mustardGreens = "Sawi"
    case rawVeggiePlate = "Lalapan"
    case mushroom = "Jamur"
}

enum Topping: String, CaseIterable, Codable {
    case tomato_sauce = "Saus Tomat"
    case chili_sauce = "Sambal"
    case crackers = "Kerupuk"
    case soy_sauce = "Kecap"
    case chili_oil = "Minyak Cabai"
    case pickle = "Acar"
    case friedEgg = "Telur Ceplok"
    case cheese = "Keju"
    case friedShallot = "Bawang Goreng"
}

@Generable
enum CookMethod: String, CaseIterable, Codable {
    case fried = "Goreng"
    case grilled = "Bakar"
    case roasted = "Panggang"
    case steamed = "Kukus"
    case boiled = "Rebus"
    case stirFried = "Tumis"
    case rawSalad = "Mentah Salad"
    case other = "Lainnya"
}

@Generable
enum MealCategory: String, CaseIterable, Codable {
    case heavyMeal = "Makanan Berat"
    case snack = "Cemilan"
    case drink = "Minuman"
    case dessert = "Dessert"
}
