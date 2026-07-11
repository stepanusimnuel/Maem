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
    /// Seeds 18 tenants + 100 menus into `foodCourt`. Food-only for now — no `.minuman` category items.
    /// Call once, guarded on empty.
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

        // MARK: Ayam Bu Tini (bersertifikat)
        let t0 = tenant("Ayam Bu Tini", .bersertifikat, "https://maps.google.com/?q=ayam+bu+tini")
        menu(t0, "Ayam Geprek + Nasi", 22000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t0, "Nasi Ayam Kecap (Porsi Anak)", 18000, [.nasi], [.ayam], [], [], [.kecap], [], false, .lembut, .makananBerat, .tumis, .porsiAnak, false, false, false)
        menu(t0, "Ayam Kremes + Nasi", 25000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], false, .renyah, .makananBerat, .goreng, .reguler, false, false, false)

        // MARK: Bubur & Soto Nusantara (belumSertifikasi)
        menu(t0, "Ayam Suwir Kecap (Porsi Anak)", 17000, [.nasi], [.ayam], [], [], [.kecap], [], false, .lembut, .makananBerat, .tumis, .porsiAnak, false, false, false)
        menu(t0, "Sup Ayam Wortel (Anak)", 16000, [.nasi], [.ayam], [], [.wortel], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t0, "Ayam Bakar Madu + Nasi", 24000, [.nasi], [.ayam], [], [], [], [], false, .kering, .makananBerat, .bakar, .reguler, false, false, false)
        let t1 = tenant("Bubur & Soto Nusantara", .belumSertifikasi, "https://maps.google.com/?q=soto+nusantara")
        menu(t1, "Bubur Ayam Polos", 15000, [.bubur], [.ayam], [], [], [.bawangGoreng, .kerupuk], [], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t1, "Soto Ayam", 20000, [.nasi], [.ayam], [], [.toge], [.bawangGoreng], [], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t1, "Soto Daging Sapi", 24000, [.nasi], [.sapi], [], [.toge], [], [], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)

        // MARK: Seafood Mantap (bersertifikat)
        menu(t1, "Sate Usus Ayam", 15000, [], [.ayam], [], [], [.kecap], [], false, .kering, .cemilan, .bakar, .reguler, false, false, false)
        menu(t1, "Nasi Goreng Kampung", 18000, [.nasiGoreng], [.ayam], [], [], [.telurCeplok], [.telur], true, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t1, "Kerupuk & Sambal Bawang", 8000, [], [], [], [], [.sambal], [], true, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        let t2 = tenant("Seafood Mantap", .bersertifikat, "https://maps.google.com/?q=seafood+mantap")
        menu(t2, "Nasi Udang Saus Padang", 35000, [.nasi], [.udang], [], [], [.sambal], [.udangKerang], true, .berkuah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t2, "Cumi Goreng Tepung + Nasi", 32000, [.nasi], [.cumi], [], [], [], [.udangKerang, .gluten], false, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t2, "Ikan Bakar + Nasi", 30000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], false, .kering, .makananBerat, .bakar, .reguler, false, false, false)

        // MARK: Mie & Dimsum Corner (belumSertifikasi)
        menu(t2, "Sup Ikan Tenggiri (Anak)", 20000, [.nasi], [.ikan], [], [], [], [.ikan], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t2, "Udang Kukus Saus Mentega (Anak)", 22000, [.nasi], [.udang], [], [], [.saus], [.udangKerang, .susu], false, .lembut, .makananBerat, .kukus, .porsiAnak, false, false, false)
        menu(t2, "Bubur Ikan (Anak)", 17000, [.bubur], [.ikan], [], [], [], [.ikan], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, false, false)
        let t3 = tenant("Mie & Dimsum Corner", .belumSertifikasi, "https://maps.google.com/?q=mie+dimsum")
        menu(t3, "Mie Ayam Bakso", 18000, [.mie], [.ayam, .bakso], [], [.sawi], [], [.gluten], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t3, "Dimsum Ayam Kukus", 20000, [], [.ayam], [], [], [.saus], [.gluten, .udangKerang], false, .lembut, .cemilan, .kukus, .porsiAnak, false, false, false)
        menu(t3, "Mie Instan Telur", 12000, [.mie], [.telur], [], [], [], [.gluten, .telur], false, .berkuah, .makananBerat, .rebus, .reguler, true, false, false)

        // MARK: Pojok Vegetarian (bersertifikat)
        menu(t3, "Mie Goreng Ayam", 19000, [.mie], [.ayam], [], [.sawi], [], [.gluten], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t3, "Dimsum Goreng Renyah", 21000, [], [.ayam], [], [], [.saus], [.gluten, .telur], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t3, "Mie Pedas Setan", 20000, [.mie], [.ayam], [], [], [.sambal], [.gluten], true, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        let t4 = tenant("Pojok Vegetarian", .bersertifikat, "https://maps.google.com/?q=pojok+vegetarian")
        menu(t4, "Nasi Tahu Tempe Goreng", 15000, [.nasi], [], [.tahu, .tempe], [], [.sambal], [.kedelai], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t4, "Gado-Gado", 17000, [.lontongKetupat], [], [.tahu, .tempe], [.bayam, .toge, .kangkung], [.kerupuk], [.kacang, .kedelai], false, .lembut, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t4, "Capcay Kuah", 17000, [], [], [.jamur, .tahu], [.capcay, .wortel, .brokoli], [], [], false, .berkuah, .makananBerat, .tumis, .reguler, false, false, false)

        // MARK: Pork Corner (nonHalal)
        menu(t4, "Sup Tahu Sayur (Anak)", 14000, [], [], [.tahu], [.wortel, .bayam], [], [.kedelai], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t4, "Tempe Orek Pedas", 13000, [], [], [.tempe], [], [.sambal], [.kedelai], true, .kering, .cemilan, .tumis, .reguler, false, false, false)
        menu(t4, "Keripik Tempe", 9000, [], [], [.tempe], [], [], [.kedelai], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        let t5 = tenant("Pork Corner", .nonHalal, "https://maps.google.com/?q=pork+corner")
        menu(t5, "Nasi Babi Kecap", 28000, [.nasi], [], [], [], [.kecap], [], false, .lembut, .makananBerat, .tumis, .reguler, false, true, false)
        menu(t5, "Nasi Goreng B2", 26000, [.nasiGoreng], [], [], [], [.telurCeplok], [], false, .kering, .makananBerat, .goreng, .reguler, false, true, false)

        // MARK: Es & Manis (bersertifikat) — minuman items removed per product decision; dessert kept
        menu(t5, "Bubur Babi Cincang (Anak)", 18000, [.bubur], [], [], [], [.bawangGoreng], [], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, true, false)
        menu(t5, "Sup Sayur Babi (Anak)", 20000, [], [], [], [.wortel, .capcay], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, true, false)
        menu(t5, "Babi Panggang Madu + Nasi", 30000, [.nasi], [], [], [], [], [], false, .kering, .makananBerat, .panggang, .reguler, false, true, false)
        menu(t5, "Sate Babi Pedas", 27000, [], [], [], [], [.sambal], [], true, .kering, .cemilan, .bakar, .reguler, false, true, false)
        let t6 = tenant("Es & Manis", .bersertifikat, "https://maps.google.com/?q=es+manis")
        menu(t6, "Pudding Coklat", 10000, [], [], [], [], [], [.susu, .telur], false, .lembut, .dessert, .other, .porsiAnak, false, false, false)

        // MARK: Nasi Padang Sederhana (bersertifikat)
        menu(t6, "Es Krim Vanilla Cup (Anak)", 12000, [], [], [], [], [], [.susu], false, .lembut, .dessert, .other, .porsiAnak, false, false, false)
        menu(t6, "Puding Karamel (Anak)", 11000, [], [], [], [], [], [.susu, .telur], false, .lembut, .dessert, .other, .porsiAnak, false, false, false)
        menu(t6, "Pisang Goreng Crispy", 9000, [], [], [], [], [], [.gluten], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t6, "Kue Cubit Gosong (Karamel)", 8000, [], [], [], [], [], [.susu, .telur, .gluten], false, .lengket, .cemilan, .panggang, .reguler, false, false, false)
        menu(t6, "Keripik Pisang Manis", 8000, [], [], [], [], [], [], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        let t7 = tenant("Nasi Padang Sederhana", .bersertifikat, "https://maps.google.com/?q=nasi+padang+sederhana")
        menu(t7, "Rendang Sapi + Nasi", 32000, [.nasi], [.sapi], [], [], [], [], true, .kering, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t7, "Gulai Ayam + Nasi", 27000, [.nasi], [.ayam], [], [], [], [], true, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t7, "Ayam Pop + Nasi", 25000, [.nasi], [.ayam], [], [], [.sambal], [], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t7, "Dendeng Balado + Nasi", 30000, [.nasi], [.sapi], [], [], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t7, "Telur Balado + Nasi", 18000, [.nasi], [.telur], [], [], [.sambal], [.telur], true, .lembut, .makananBerat, .goreng, .porsiAnak, false, false, false)
        menu(t7, "Sayur Nangka Lodeh", 15000, [], [], [], [.other], [], [], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t7, "Ayam Bakar Padang + Nasi", 26000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .kering, .makananBerat, .bakar, .reguler, false, false, false)
        menu(t7, "Perkedel Kentang", 8000, [.kentang], [], [], [], [], [.telur], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t7, "Nasi Campur Padang (Rendang + Sayur + Telur)", 35000, [.nasi], [.sapi, .telur], [], [.buncis], [.sambal], [.telur], true, .kering, .makananBerat, .rebus, .sharing, false, false, false)

        // MARK: Bakso Boedjangan (bersertifikat)
        menu(t7, "Nasi Rendang Anak (Tidak Pedas)", 20000, [.nasi], [.sapi], [], [], [], [], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t7, "Sup Ayam Padang (Anak, Tidak Pedas)", 18000, [.nasi], [.ayam], [], [.wortel], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        let t8 = tenant("Bakso Boedjangan", .bersertifikat, "https://maps.google.com/?q=bakso+boedjangan")
        menu(t8, "Bakso Urat", 18000, [], [.bakso], [], [.toge, .sawi], [.bawangGoreng], [.gluten], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t8, "Bakso Telur", 20000, [], [.bakso, .telur], [], [.toge], [.bawangGoreng], [.gluten, .telur], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t8, "Bakso Beranak (Sharing)", 45000, [.mie], [.bakso, .telur], [.tahu], [.toge, .sawi], [.bawangGoreng, .kerupuk], [.gluten, .telur, .kedelai], false, .berkuah, .makananBerat, .rebus, .sharing, false, false, false)
        menu(t8, "Mie Bakso", 20000, [.mie], [.bakso], [], [.sawi], [.bawangGoreng], [.gluten], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t8, "Bakso Goreng (Cemilan)", 12000, [], [.bakso], [], [], [.saus], [.gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t8, "Bakso Anak (Porsi Kecil, Tidak Pedas)", 15000, [], [.bakso], [], [], [], [.gluten], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t8, "Bakso Pedas Setan", 22000, [], [.bakso], [], [.toge], [.sambal], [.gluten], true, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)

        // MARK: Geprek & Penyet Corner (belumSertifikasi)
        menu(t8, "Bakso Bakar Pedas", 16000, [], [.bakso], [], [], [.sambal], [.gluten], true, .renyah, .cemilan, .bakar, .reguler, false, false, false)
        let t9 = tenant("Geprek & Penyet Corner", .belumSertifikasi, "https://maps.google.com/?q=geprek+penyet+corner")
        menu(t9, "Ayam Penyet + Nasi", 22000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Tahu Tempe Penyet", 14000, [.nasi], [], [.tahu, .tempe], [.lalapan], [.sambal], [.kedelai], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Lele Penyet + Nasi", 20000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Ayam Geprek Level 5", 24000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Ayam Geprek (Tidak Pedas, Anak)", 20000, [.nasi], [.ayam], [], [], [], [], false, .renyah, .makananBerat, .goreng, .porsiAnak, false, false, false)
        menu(t9, "Terong Penyet", 12000, [], [], [], [.terong, .lalapan], [.sambal], [], true, .lembut, .cemilan, .goreng, .reguler, false, false, false)
        menu(t9, "Bebek Geprek + Nasi", 28000, [.nasi], [.bebek], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)

        // MARK: Nasi Uduk Betawi Hj. Siti (bersertifikat)
        menu(t9, "Sup Tahu Ayam (Anak, Tidak Pedas)", 16000, [.nasi], [.ayam], [.tahu], [], [], [.kedelai], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t9, "Lele Kukus Saus (Anak, Tidak Pedas)", 19000, [.nasi], [.ikan], [], [], [.saus], [.ikan], false, .lembut, .makananBerat, .kukus, .porsiAnak, false, false, false)
        menu(t9, "Bebek Suwir Kecap (Anak, Tidak Pedas)", 22000, [.nasi], [.bebek], [], [], [.kecap], [], false, .lembut, .makananBerat, .tumis, .porsiAnak, false, false, false)
        let t10 = tenant("Nasi Uduk Betawi Hj. Siti", .bersertifikat, "https://maps.google.com/?q=nasi+uduk+betawi+hj+siti")
        menu(t10, "Nasi Uduk Komplit", 24000, [.nasi], [.ayam, .telur], [.tempe], [], [.bawangGoreng, .sambal], [.telur, .kedelai], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t10, "Nasi Uduk Ayam Goreng", 22000, [.nasi], [.ayam], [], [], [.bawangGoreng], [], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t10, "Semur Telur + Nasi", 18000, [.nasi], [.telur], [], [], [.kecap], [.telur], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t10, "Tahu Goreng (Gorengan)", 8000, [], [], [.tahu], [], [], [.kedelai], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t10, "Bakwan Sayur (Gorengan)", 7000, [], [], [], [.wortel, .toge], [], [.gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t10, "Sambal Goreng Kentang", 15000, [.kentang], [], [], [], [.sambal], [], true, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t10, "Nasi Uduk Ikan Asin", 20000, [.nasi], [.ikan], [], [], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)

        // MARK: Sate Nusantara (bersertifikat)
        menu(t10, "Bubur Ayam Betawi (Anak)", 17000, [.bubur], [.ayam], [], [], [.bawangGoreng], [], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t10, "Sup Ayam Uduk (Anak)", 18000, [.nasi], [.ayam], [], [.wortel], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        let t11 = tenant("Sate Nusantara", .bersertifikat, "https://maps.google.com/?q=sate+nusantara")
        menu(t11, "Sate Ayam Bumbu Kacang", 25000, [.lontongKetupat], [.ayam], [.kacang], [], [.kecap], [.kacang], false, .kering, .makananBerat, .bakar, .reguler, false, false, false)
        menu(t11, "Sate Kambing", 32000, [], [.kambing], [], [], [.kecap], [], false, .kering, .makananBerat, .bakar, .reguler, false, false, false)
        menu(t11, "Sate Padang", 28000, [.lontongKetupat], [.sapi], [], [], [], [], true, .berkuah, .makananBerat, .bakar, .reguler, false, false, false)
        menu(t11, "Sop Buntut", 40000, [], [.sapi], [], [.wortel], [.bawangGoreng], [], false, .berkuah, .makananBerat, .rebus, .sharing, false, false, false)
        menu(t11, "Sate Ayam (Porsi Anak, Tanpa Kacang)", 18000, [], [.ayam], [], [], [.kecap], [], false, .kering, .makananBerat, .bakar, .porsiAnak, false, false, false)
        menu(t11, "Sate Usus", 15000, [], [.ayam], [], [], [.sambal], [], true, .kering, .cemilan, .bakar, .reguler, false, false, false)
        menu(t11, "Sate Telur Puyuh", 12000, [], [.telur], [], [], [.kecap], [.telur], false, .kering, .cemilan, .bakar, .porsiAnak, false, false, false)
        menu(t11, "Gulai Kambing + Nasi", 35000, [.nasi], [.kambing], [], [], [], [], true, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t11, "Sate Campur (Ayam + Kambing + Sapi)", 38000, [.lontongKetupat], [.ayam, .kambing, .sapi], [.kacang], [], [.kecap], [.kacang], false, .kering, .makananBerat, .bakar, .sharing, false, false, false)

        // MARK: Chinese Food Koh Aseng (nonHalal — tenant-level, not every dish contains pork)
        menu(t11, "Sup Sate Ayam (Anak, Kuah Kaldu)", 20000, [.nasi], [.ayam], [], [], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t11, "Semur Daging Sapi (Anak, Tidak Pedas)", 22000, [.nasi], [.sapi], [], [], [.kecap], [], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, false, false)
        let t12 = tenant("Chinese Food Koh Aseng", .nonHalal, "https://maps.google.com/?q=chinese+food+koh+aseng")
        menu(t12, "Nasi Campur Babi Panggang", 30000, [.nasi], [], [], [], [.kecap], [], false, .kering, .makananBerat, .panggang, .reguler, false, true, false)
        menu(t12, "Kwetiau Siram Seafood", 28000, [.kwetiau], [.udang, .cumi], [], [.capcay], [], [.udangKerang], false, .berkuah, .makananBerat, .tumis, .reguler, false, false, false)
        menu(t12, "Fuyunghai + Nasi", 22000, [.nasi], [.telur], [], [.wortel], [.saus], [.telur], false, .lembut, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t12, "Cap Cai Babi", 25000, [], [], [], [.capcay, .wortel, .brokoli], [], [], false, .berkuah, .makananBerat, .tumis, .reguler, false, true, false)
        menu(t12, "Bebek Panggang + Nasi", 32000, [.nasi], [.bebek], [], [], [], [], false, .kering, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t12, "Ayam Saus Mentega", 24000, [.nasi], [.ayam], [], [], [.saus], [.susu, .telur], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t12, "Kwetiau Goreng Babi", 26000, [.kwetiau], [], [], [.toge], [], [.telur], false, .kering, .makananBerat, .goreng, .reguler, false, true, false)

        // MARK: Pecel Lele Mantap (bersertifikat)
        let t13 = tenant("Pecel Lele Mantap", .bersertifikat, "https://maps.google.com/?q=pecel+lele+mantap")
        menu(t13, "Pecel Lele + Nasi", 20000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t13, "Pecel Ayam + Nasi", 22000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t13, "Ikan Nila Goreng + Nasi", 25000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t13, "Lele Goreng (Anak, Tidak Pedas)", 18000, [.nasi], [.ikan], [], [], [], [.ikan], false, .renyah, .makananBerat, .goreng, .porsiAnak, false, false, false)
        menu(t13, "Tempe Tahu Goreng (Pelengkap)", 8000, [], [], [.tahu, .tempe], [], [], [.kedelai], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t13, "Sayur Asem", 12000, [], [], [], [.buncis], [], [], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t13, "Lalapan Komplit + Sambal", 10000, [], [], [], [.lalapan], [.sambal], [], true, .lembut, .cemilan, .mentahSalad, .reguler, false, false, false)

        // MARK: Healthy Corner (bersertifikat)
        menu(t13, "Sup Ikan Lele (Anak, Tidak Pedas)", 19000, [.nasi], [.ikan], [], [], [], [.ikan], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t13, "Tumis Bayam (Anak)", 10000, [], [], [], [.bayam], [], [], false, .lembut, .cemilan, .tumis, .porsiAnak, false, false, false)
        let t14 = tenant("Healthy Corner", .bersertifikat, "https://maps.google.com/?q=healthy+corner")
        menu(t14, "Salad Ayam Panggang", 28000, [], [.ayam], [], [.bayam, .wortel], [], [], false, .lembut, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t14, "Salad Buah & Sayur", 18000, [], [], [], [.bayam, .wortel, .brokoli], [], [], false, .lembut, .cemilan, .mentahSalad, .reguler, false, false, false)
        menu(t14, "Sup Krim Jagung", 16000, [.jagung], [], [], [], [], [.susu], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t14, "Dada Ayam Panggang + Sayur Kukus", 30000, [], [.ayam], [], [.brokoli, .wortel], [], [], false, .kering, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t14, "Oatmeal Sayur & Telur", 20000, [], [.telur], [], [.bayam], [], [.telur, .gluten], false, .lembut, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t14, "Tahu Panggang Saus Wijen", 20000, [], [], [.tahu], [.brokoli], [.saus], [.kedelai, .wijen], false, .kering, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t14, "Sup Sayur Bening (Anak)", 12000, [], [], [], [.bayam, .wortel], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)

        // MARK: Nasi Campur Bali & Kuning (bersertifikat)
        menu(t14, "Keripik Kale Panggang", 15000, [], [], [], [.brokoli], [], [], false, .renyah, .cemilan, .panggang, .reguler, false, false, false)
        let t15 = tenant("Nasi Campur Bali & Kuning", .bersertifikat, "https://maps.google.com/?q=nasi+campur+bali+kuning")
        menu(t15, "Nasi Kuning Komplit", 22000, [.nasi], [.ayam, .telur], [.tempe], [], [.bawangGoreng], [.telur, .kedelai], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t15, "Nasi Kuning Anak (Tanpa Pedas)", 18000, [.nasi], [.ayam], [], [], [], [], false, .kering, .makananBerat, .goreng, .porsiAnak, false, false, false)
        menu(t15, "Ayam Betutu + Nasi", 30000, [.nasi], [.ayam], [], [], [.sambal], [], true, .lembut, .makananBerat, .kukus, .reguler, false, false, false)
        menu(t15, "Sate Lilit Ayam", 24000, [], [.ayam], [], [], [], [], false, .kering, .makananBerat, .bakar, .reguler, false, false, false)
        menu(t15, "Nasi Campur Bali (Ayam)", 27000, [.nasi], [.ayam], [], [.toge], [.sambal], [], true, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t15, "Jukut Urab (Sayur Bali)", 12000, [], [], [.kacang], [.kangkung, .toge], [], [.kacang], true, .lembut, .cemilan, .rebus, .reguler, false, false, false)
        menu(t15, "Ayam Sisit (Suwir Pedas) + Nasi", 25000, [.nasi], [.ayam], [], [], [.sambal], [], true, .kering, .makananBerat, .tumis, .reguler, false, false, false)

        // MARK: Jajanan Pasar Mbah Wongso (bersertifikat)
        menu(t15, "Sup Ayam Bali (Anak, Tidak Pedas)", 19000, [.nasi], [.ayam], [], [], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t15, "Ayam Suwir Kuning (Anak, Tidak Pedas)", 18000, [.nasi], [.ayam], [], [], [], [], false, .lembut, .makananBerat, .tumis, .porsiAnak, false, false, false)
        menu(t15, "Bubur Kuning Ayam (Anak)", 16000, [.bubur], [.ayam], [], [], [.bawangGoreng], [], false, .lembut, .makananBerat, .rebus, .porsiAnak, false, false, false)
        let t16 = tenant("Jajanan Pasar Mbah Wongso", .bersertifikat, "https://maps.google.com/?q=jajanan+pasar+mbah+wongso")
        menu(t16, "Risoles Mayo", 6000, [.roti], [.telur], [], [.wortel], [], [.telur, .gluten, .susu], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Pastel Sayur", 5000, [.roti], [], [], [.wortel], [], [.gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Lumpia Semarang", 8000, [], [.udang], [], [.toge], [], [.udangKerang, .gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Martabak Telur Mini", 15000, [], [.telur], [], [], [], [.telur, .gluten], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t16, "Klepon", 6000, [], [], [], [], [], [], false, .lembut, .cemilan, .rebus, .porsiAnak, false, false, false)
        menu(t16, "Kroket Kentang", 7000, [.kentang], [], [], [.wortel], [], [.telur, .gluten, .susu], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Combro", 5000, [.singkong], [], [], [], [.sambal], [], true, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Cireng Bumbu Rujak", 6000, [.singkong], [], [], [], [.sambal], [], true, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)

        // MARK: Roti Bakar & Snack Corner (belumSertifikasi)
        menu(t16, "Getuk Lindri (Anak)", 5000, [.singkong], [], [], [], [], [], false, .lembut, .cemilan, .rebus, .porsiAnak, false, false, false)
        menu(t16, "Bubur Sumsum (Anak)", 7000, [], [], [], [], [], [], false, .lembut, .dessert, .rebus, .porsiAnak, false, false, false)
        let t17 = tenant("Roti Bakar & Snack Corner", .belumSertifikasi, "https://maps.google.com/?q=roti+bakar+snack+corner")
        menu(t17, "Roti Bakar Coklat Keju", 15000, [.roti], [], [], [], [.keju], [.susu, .gluten], false, .renyah, .cemilan, .bakar, .reguler, false, false, false)
        menu(t17, "Roti Bakar Kacang", 13000, [.roti], [], [.kacang], [], [], [.kacang, .gluten], false, .renyah, .cemilan, .bakar, .reguler, false, false, false)
        menu(t17, "Kentang Goreng", 12000, [.kentang], [], [], [], [.saus], [], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t17, "Pisang Goreng Keju", 12000, [], [], [], [], [.keju], [.susu, .gluten], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t17, "Roti Bakar Anak (Coklat, Tanpa Kacang)", 12000, [.roti], [], [], [], [], [.gluten, .susu], false, .renyah, .cemilan, .bakar, .porsiAnak, false, false, false)
        menu(t17, "Kentang Mustofa (Kentang Kering Pedas)", 14000, [.kentang], [], [.kacang], [], [.sambal], [.kacang], true, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t17, "Mie Instan Goreng Telur (Snack)", 13000, [.mie], [.telur], [], [], [], [.gluten, .telur], false, .kering, .cemilan, .goreng, .reguler, true, false, false)

        menu(t17, "Roti Bakar Keju Susu (Anak, Tanpa Coklat)", 13000, [.roti], [], [], [], [.keju], [.susu, .gluten], false, .lembut, .cemilan, .bakar, .porsiAnak, false, false, false)
        menu(t17, "Pisang Goreng Madu (Anak, Tidak Pedas)", 11000, [], [], [], [], [], [], false, .lembut, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t17, "Bubur Kacang Hijau (Anak)", 9000, [], [], [.kacang], [], [], [.kacang], false, .lembut, .dessert, .rebus, .porsiAnak, false, false, false)
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
