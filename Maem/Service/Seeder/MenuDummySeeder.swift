import Foundation
import SwiftData

enum MenuDummySeeder {

    static func seed(into fc: FoodCourt, context: ModelContext) {

        func tenant(_ name: String, _ halal: HalalStatus, _ gmap: String) -> Tenant {
            let t = Tenant(name: name, halalStatus: halal, googleMapsLink: gmap)
            t.foodCourt = fc
            context.insert(t)
            return t
        }

        func menu(
            _ t: Tenant, _ name: String, _ price: Int, _ carbs: [Carb], _ ph: [ProteinHewani], _ pn: [ProteinNabati],
            _ veg: [Veggie], _ top: [Topping], _ alg: [Allergen], _ pedas: Bool, _ tex: Texture, _ meal: MealCategory,
            _ cook: CookMethod, _ port: Portion, _ inst: Bool, _ pork: Bool, _ alc: Bool
        ) {
            let m = MenuItem(
                name: name, price: price, carbs: carbs, proteinHewani: ph, proteinNabati: pn, veggies: veg,
                toppings: top, allergens: alg, isPedas: pedas, texture: tex, mealCategory: meal,
                cookMethod: cook, portion: port, isInstant: inst, containsPork: pork, containsAlcohol: alc
            )
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
