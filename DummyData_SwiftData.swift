// DummyData_SwiftData.swift
// SwiftData version — drop into the Maem repo (needs the existing `FoodCourt` @Model in scope).
//
// SETUP (2 steps):
//   1. Register the new models in MaemApp's modelContainer:
//        .modelContainer(for: [FoodCourt.self, Tenant.self, MenuItem.self])
//   2. (Recommended) add the inverse relationship to your FoodCourt @Model:
//        @Relationship(deleteRule: .cascade, inverse: \Tenant.foodCourt)
//        var tenants: [Tenant] = []
//      If you skip step 2, the link still works one-way (Tenant.foodCourt); query tenants via a fetch predicate.
//
// NOTE on enums: stored directly as Codable. If SwiftData ever errors on an enum-ARRAY property,
// switch that property to store [String] raw values with a computed accessor (see commented pattern at bottom).

import Foundation
import SwiftData

// MARK: - Enums (spec final)
enum Carb: String, Codable, CaseIterable { case nasi, nasiGoreng, mie, bihun, kwetiau, kentang, roti, lontongKetupat, bubur, pasta, jagung, singkong, other }
enum ProteinHewani: String, Codable, CaseIterable { case ayam, sapi, kambing, ikan, udang, cumi, telur, bebek, bakso, sosis, other }
enum ProteinNabati: String, Codable, CaseIterable { case tahu, tempe, jamur, edamame, kacang, other }
enum Veggie: String, Codable, CaseIterable { case sop, capcay, bayam, kangkung, wortel, buncis, toge, brokoli, terong, sawi, lalapan, jamur, other }
enum Topping: String, Codable, CaseIterable { case kerupuk, sambal, kecap, acar, telurCeplok, keju, saus, bawangGoreng, other }
enum Allergen: String, Codable, CaseIterable { case kacang, udangKerang, ikan, telur, susu, gluten, kedelai, wijen }   // CLOSED — no .other (safety)
enum CookMethod: String, Codable, CaseIterable { case goreng, bakar, panggang, kukus, rebus, tumis, mentahSalad, other }
enum Texture: String, Codable, CaseIterable { case berkuah, lembut, kering, renyah, lengket, other }
enum MealCategory: String, Codable, CaseIterable { case makananBerat, cemilan, minuman, dessert, other }
enum HalalStatus: String, Codable, CaseIterable { case bersertifikat, belumSertifikasi, nonHalal }
enum Portion: Int, Codable, CaseIterable, Comparable {
    case porsiAnak = 0, reguler = 1, sharing = 2
    static func < (l: Portion, r: Portion) -> Bool { l.rawValue < r.rawValue }
}

// MARK: - @Model: Tenant
@Model
final class Tenant {
    var name: String
    var halalStatus: HalalStatus
    var googleMapsLink: String
    var foodCourt: FoodCourt?                 // link to the EXISTING FoodCourt @Model (do not redefine it)
    @Relationship(deleteRule: .cascade, inverse: \MenuItem.tenant)
    var menus: [MenuItem] = []

    init(name: String, halalStatus: HalalStatus, googleMapsLink: String) {
        self.name = name
        self.halalStatus = halalStatus
        self.googleMapsLink = googleMapsLink
    }
}

// MARK: - @Model: MenuItem
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

    // Computed (not stored) — no tenant context needed
    var isVegetarian: Bool { proteinHewani.isEmpty }
    var isKidFriendly: Bool { !isPedas && (texture == .lembut || texture == .berkuah) }
    // isHalal needs Tenant.halalStatus + user intent -> compute in RecommendationEngine.

    init(name: String, price: Int, carbs: [Carb], proteinHewani: [ProteinHewani], proteinNabati: [ProteinNabati],
         veggies: [Veggie], toppings: [Topping], allergens: [Allergen], isPedas: Bool, texture: Texture,
         mealCategory: MealCategory, cookMethod: CookMethod, portion: Portion, isInstant: Bool,
         containsPork: Bool, containsAlcohol: Bool) {
        self.name = name; self.price = price; self.carbs = carbs; self.proteinHewani = proteinHewani
        self.proteinNabati = proteinNabati; self.veggies = veggies; self.toppings = toppings; self.allergens = allergens
        self.isPedas = isPedas; self.texture = texture; self.mealCategory = mealCategory; self.cookMethod = cookMethod
        self.portion = portion; self.isInstant = isInstant; self.containsPork = containsPork; self.containsAlcohol = containsAlcohol
    }
}

// MARK: - Seeder
enum MenuDummySeeder {
    /// Seeds 7 tenants + 20 menus into `foodCourt`. Call once, guarded on empty.
    /// Wire into your DummySeeder AFTER food courts exist, e.g. for the food court you want fully populated:
    ///   if targetFoodCourt.tenants.isEmpty { MenuDummySeeder.seed(into: targetFoodCourt, context: context) }
    static func seed(into fc: FoodCourt, context: ModelContext) {
        func tenant(_ name: String, _ halal: HalalStatus, _ gmap: String) -> Tenant {
            let t = Tenant(name: name, halalStatus: halal, googleMapsLink: gmap)
            t.foodCourt = fc
            context.insert(t)
            return t
        }
        func menu(_ t: Tenant, _ name: String, _ price: Int, _ carbs: [Carb], _ ph: [ProteinHewani], _ pn: [ProteinNabati],
                  _ veg: [Veggie], _ top: [Topping], _ alg: [Allergen], _ pedas: Bool, _ tex: Texture, _ meal: MealCategory,
                  _ cook: CookMethod, _ port: Portion, _ inst: Bool, _ pork: Bool, _ alc: Bool) {
            let m = MenuItem(name: name, price: price, carbs: carbs, proteinHewani: ph, proteinNabati: pn, veggies: veg,
                             toppings: top, allergens: alg, isPedas: pedas, texture: tex, mealCategory: meal,
                             cookMethod: cook, portion: port, isInstant: inst, containsPork: pork, containsAlcohol: alc)
            m.tenant = t
            context.insert(m)
        }

        let t0 = tenant("Ayam Bu Tini", .bersertifikat, "https://maps.google.com/?q=ayam+bu+tini")
        menu(t0, "Ayam Geprek + Nasi", 22000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t0, "Nasi Ayam Kecap (Porsi Anak)", 18000, [.nasi], [.ayam], [], [], [.kecap], [], false, .lembut, .makananBerat, .tumis, .porsiAnak, false, false, false)
        menu(t0, "Ayam Kremes + Nasi", 25000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], false, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        let t1 = tenant("Bubur & Soto Nusantara", .belumSertifikasi, "https://maps.google.com/?q=soto+nusantara")
        menu(t1, "Bubur Ayam Polos", 15000, [.bubur], [.ayam], [], [], [.bawangGoreng, .kerupuk], [], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t1, "Soto Ayam", 20000, [.nasi], [.ayam], [], [.toge], [.bawangGoreng], [], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t1, "Soto Daging Sapi", 24000, [.nasi], [.sapi], [], [.toge], [], [], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        let t2 = tenant("Seafood Mantap", .bersertifikat, "https://maps.google.com/?q=seafood+mantap")
        menu(t2, "Nasi Udang Saus Padang", 35000, [.nasi], [.udang], [], [], [.sambal], [.udangKerang], true, .berkuah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t2, "Cumi Goreng Tepung + Nasi", 32000, [.nasi], [.cumi], [], [], [], [.udangKerang, .gluten], false, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t2, "Ikan Bakar + Nasi", 30000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], false, .kering, .makananBerat, .bakar, .reguler, false, false, false)
        let t3 = tenant("Mie & Dimsum Corner", .belumSertifikasi, "https://maps.google.com/?q=mie+dimsum")
        menu(t3, "Mie Ayam Bakso", 18000, [.mie], [.ayam, .bakso], [], [.sawi], [], [.gluten], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t3, "Dimsum Ayam Kukus", 20000, [], [.ayam], [], [], [.saus], [.gluten, .udangKerang], false, .lembut, .cemilan, .kukus, .porsiAnak, false, false, false)
        menu(t3, "Mie Instan Telur", 12000, [.mie], [.telur], [], [], [], [.gluten, .telur], false, .berkuah, .makananBerat, .rebus, .reguler, true, false, false)
        let t4 = tenant("Pojok Vegetarian", .bersertifikat, "https://maps.google.com/?q=pojok+vegetarian")
        menu(t4, "Nasi Tahu Tempe Goreng", 15000, [.nasi], [], [.tahu, .tempe], [], [.sambal], [.kedelai], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t4, "Gado-Gado", 17000, [.lontongKetupat], [], [.tahu, .tempe], [.bayam, .toge, .kangkung], [.kerupuk], [.kacang, .kedelai], false, .lembut, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t4, "Capcay Kuah", 17000, [], [], [.jamur, .tahu], [.capcay, .wortel, .brokoli], [], [], false, .berkuah, .makananBerat, .tumis, .reguler, false, false, false)
        let t5 = tenant("Pork Corner", .nonHalal, "https://maps.google.com/?q=pork+corner")
        menu(t5, "Nasi Babi Kecap", 28000, [.nasi], [], [], [], [.kecap], [], false, .lembut, .makananBerat, .tumis, .reguler, false, true, false)
        menu(t5, "Nasi Goreng B2", 26000, [.nasiGoreng], [], [], [], [.telurCeplok], [], false, .kering, .makananBerat, .goreng, .reguler, false, true, false)
        let t6 = tenant("Es & Manis", .bersertifikat, "https://maps.google.com/?q=es+manis")
        menu(t6, "Es Teh Manis", 5000, [], [], [], [], [], [], false, .berkuah, .minuman, .other, .reguler, false, false, false)
        menu(t6, "Es Campur", 12000, [], [], [], [], [], [.susu], false, .berkuah, .minuman, .other, .reguler, false, false, false)
        menu(t6, "Pudding Coklat", 10000, [], [], [], [], [], [.susu, .telur], false, .lembut, .dessert, .other, .porsiAnak, false, false, false)

        try? context.save()
    }
}

/* ------------------------------------------------------------------
 FALLBACK pattern if SwiftData rejects an enum-array property:
 store raw [String] and expose a computed [Carb].

   private var carbsRaw: [String] = []
   var carbs: [Carb] {
       get { carbsRaw.compactMap(Carb.init(rawValue:)) }
       set { carbsRaw = newValue.map(\.rawValue) }
   }
 ------------------------------------------------------------------ */
