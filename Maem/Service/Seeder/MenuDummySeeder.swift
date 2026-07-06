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
        menu(t6, "Pudding Coklat", 10000, [], [], [], [], [], [.susu, .telur], false, .lembut, .dessert, .other, .porsiAnak, false, false, false)

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

        let t8 = tenant("Bakso Boedjangan", .bersertifikat, "https://maps.google.com/?q=bakso+boedjangan")
        menu(t8, "Bakso Urat", 18000, [], [.bakso], [], [.toge, .sawi], [.bawangGoreng], [.gluten], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t8, "Bakso Telur", 20000, [], [.bakso, .telur], [], [.toge], [.bawangGoreng], [.gluten, .telur], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t8, "Bakso Beranak (Sharing)", 45000, [.mie], [.bakso, .telur], [.tahu], [.toge, .sawi], [.bawangGoreng, .kerupuk], [.gluten, .telur, .kedelai], false, .berkuah, .makananBerat, .rebus, .sharing, false, false, false)
        menu(t8, "Mie Bakso", 20000, [.mie], [.bakso], [], [.sawi], [.bawangGoreng], [.gluten], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t8, "Bakso Goreng (Cemilan)", 12000, [], [.bakso], [], [], [.saus], [.gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t8, "Bakso Anak (Porsi Kecil, Tidak Pedas)", 15000, [], [.bakso], [], [], [], [.gluten], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t8, "Bakso Pedas Setan", 22000, [], [.bakso], [], [.toge], [.sambal], [.gluten], true, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)

        let t9 = tenant("Geprek & Penyet Corner", .belumSertifikasi, "https://maps.google.com/?q=geprek+penyet+corner")
        menu(t9, "Ayam Penyet + Nasi", 22000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Tahu Tempe Penyet", 14000, [.nasi], [], [.tahu, .tempe], [.lalapan], [.sambal], [.kedelai], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Lele Penyet + Nasi", 20000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Ayam Geprek Level 5", 24000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t9, "Ayam Geprek (Tidak Pedas, Anak)", 20000, [.nasi], [.ayam], [], [], [], [], false, .renyah, .makananBerat, .goreng, .porsiAnak, false, false, false)
        menu(t9, "Terong Penyet", 12000, [], [], [], [.terong, .lalapan], [.sambal], [], true, .lembut, .cemilan, .goreng, .reguler, false, false, false)
        menu(t9, "Bebek Geprek + Nasi", 28000, [.nasi], [.bebek], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)

        let t10 = tenant("Nasi Uduk Betawi Hj. Siti", .bersertifikat, "https://maps.google.com/?q=nasi+uduk+betawi+hj+siti")
        menu(t10, "Nasi Uduk Komplit", 24000, [.nasi], [.ayam, .telur], [.tempe], [], [.bawangGoreng, .sambal], [.telur, .kedelai], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t10, "Nasi Uduk Ayam Goreng", 22000, [.nasi], [.ayam], [], [], [.bawangGoreng], [], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t10, "Semur Telur + Nasi", 18000, [.nasi], [.telur], [], [], [.kecap], [.telur], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t10, "Tahu Goreng (Gorengan)", 8000, [], [], [.tahu], [], [], [.kedelai], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t10, "Bakwan Sayur (Gorengan)", 7000, [], [], [], [.wortel, .toge], [], [.gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t10, "Sambal Goreng Kentang", 15000, [.kentang], [], [], [], [.sambal], [], true, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t10, "Nasi Uduk Ikan Asin", 20000, [.nasi], [.ikan], [], [], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)

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

        let t12 = tenant("Chinese Food Koh Aseng", .nonHalal, "https://maps.google.com/?q=chinese+food+koh+aseng")
        menu(t12, "Nasi Campur Babi Panggang", 30000, [.nasi], [], [], [], [.kecap], [], false, .kering, .makananBerat, .panggang, .reguler, false, true, false)
        menu(t12, "Kwetiau Siram Seafood", 28000, [.kwetiau], [.udang, .cumi], [], [.capcay], [], [.udangKerang], false, .berkuah, .makananBerat, .tumis, .reguler, false, false, false)
        menu(t12, "Fuyunghai + Nasi", 22000, [.nasi], [.telur], [], [.wortel], [.saus], [.telur], false, .lembut, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t12, "Cap Cai Babi", 25000, [], [], [], [.capcay, .wortel, .brokoli], [], [], false, .berkuah, .makananBerat, .tumis, .reguler, false, true, false)
        menu(t12, "Bebek Panggang + Nasi", 32000, [.nasi], [.bebek], [], [], [], [], false, .kering, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t12, "Ayam Saus Mentega", 24000, [.nasi], [.ayam], [], [], [.saus], [.susu, .telur], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t12, "Kwetiau Goreng Babi", 26000, [.kwetiau], [], [], [.toge], [], [.telur], false, .kering, .makananBerat, .goreng, .reguler, false, true, false)

        let t13 = tenant("Pecel Lele Mantap", .bersertifikat, "https://maps.google.com/?q=pecel+lele+mantap")
        menu(t13, "Pecel Lele + Nasi", 20000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t13, "Pecel Ayam + Nasi", 22000, [.nasi], [.ayam], [], [.lalapan], [.sambal], [], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t13, "Ikan Nila Goreng + Nasi", 25000, [.nasi], [.ikan], [], [.lalapan], [.sambal], [.ikan], true, .renyah, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t13, "Lele Goreng (Anak, Tidak Pedas)", 18000, [.nasi], [.ikan], [], [], [], [.ikan], false, .renyah, .makananBerat, .goreng, .porsiAnak, false, false, false)
        menu(t13, "Tempe Tahu Goreng (Pelengkap)", 8000, [], [], [.tahu, .tempe], [], [], [.kedelai], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t13, "Sayur Asem", 12000, [], [], [], [.buncis], [], [], false, .berkuah, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t13, "Lalapan Komplit + Sambal", 10000, [], [], [], [.lalapan], [.sambal], [], true, .lembut, .cemilan, .mentahSalad, .reguler, false, false, false)

        let t14 = tenant("Healthy Corner", .bersertifikat, "https://maps.google.com/?q=healthy+corner")
        menu(t14, "Salad Ayam Panggang", 28000, [], [.ayam], [], [.bayam, .wortel], [], [], false, .lembut, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t14, "Salad Buah & Sayur", 18000, [], [], [], [.bayam, .wortel, .brokoli], [], [], false, .lembut, .cemilan, .mentahSalad, .reguler, false, false, false)
        menu(t14, "Sup Krim Jagung", 16000, [.jagung], [], [], [], [], [.susu], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)
        menu(t14, "Dada Ayam Panggang + Sayur Kukus", 30000, [], [.ayam], [], [.brokoli, .wortel], [], [], false, .kering, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t14, "Oatmeal Sayur & Telur", 20000, [], [.telur], [], [.bayam], [], [.telur, .gluten], false, .lembut, .makananBerat, .rebus, .reguler, false, false, false)
        menu(t14, "Tahu Panggang Saus Wijen", 20000, [], [], [.tahu], [.brokoli], [.saus], [.kedelai, .wijen], false, .kering, .makananBerat, .panggang, .reguler, false, false, false)
        menu(t14, "Sup Sayur Bening (Anak)", 12000, [], [], [], [.bayam, .wortel], [], [], false, .berkuah, .makananBerat, .rebus, .porsiAnak, false, false, false)

        let t15 = tenant("Nasi Campur Bali & Kuning", .bersertifikat, "https://maps.google.com/?q=nasi+campur+bali+kuning")
        menu(t15, "Nasi Kuning Komplit", 22000, [.nasi], [.ayam, .telur], [.tempe], [], [.bawangGoreng], [.telur, .kedelai], false, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t15, "Nasi Kuning Anak (Tanpa Pedas)", 18000, [.nasi], [.ayam], [], [], [], [], false, .kering, .makananBerat, .goreng, .porsiAnak, false, false, false)
        menu(t15, "Ayam Betutu + Nasi", 30000, [.nasi], [.ayam], [], [], [.sambal], [], true, .lembut, .makananBerat, .kukus, .reguler, false, false, false)
        menu(t15, "Sate Lilit Ayam", 24000, [], [.ayam], [], [], [], [], false, .kering, .makananBerat, .bakar, .reguler, false, false, false)
        menu(t15, "Nasi Campur Bali (Ayam)", 27000, [.nasi], [.ayam], [], [.toge], [.sambal], [], true, .kering, .makananBerat, .goreng, .reguler, false, false, false)
        menu(t15, "Jukut Urab (Sayur Bali)", 12000, [], [], [.kacang], [.kangkung, .toge], [], [.kacang], true, .lembut, .cemilan, .rebus, .reguler, false, false, false)
        menu(t15, "Ayam Sisit (Suwir Pedas) + Nasi", 25000, [.nasi], [.ayam], [], [], [.sambal], [], true, .kering, .makananBerat, .tumis, .reguler, false, false, false)

        let t16 = tenant("Jajanan Pasar Mbah Wongso", .bersertifikat, "https://maps.google.com/?q=jajanan+pasar+mbah+wongso")
        menu(t16, "Risoles Mayo", 6000, [.roti], [.telur], [], [.wortel], [], [.telur, .gluten, .susu], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Pastel Sayur", 5000, [.roti], [], [], [.wortel], [], [.gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Lumpia Semarang", 8000, [], [.udang], [], [.toge], [], [.udangKerang, .gluten], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Martabak Telur Mini", 15000, [], [.telur], [], [], [], [.telur, .gluten], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t16, "Klepon", 6000, [], [], [], [], [], [], false, .lembut, .cemilan, .rebus, .porsiAnak, false, false, false)
        menu(t16, "Kroket Kentang", 7000, [.kentang], [], [], [.wortel], [], [.telur, .gluten, .susu], false, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Combro", 5000, [.singkong], [], [], [], [.sambal], [], true, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)
        menu(t16, "Cireng Bumbu Rujak", 6000, [.singkong], [], [], [], [.sambal], [], true, .renyah, .cemilan, .goreng, .porsiAnak, false, false, false)

        let t17 = tenant("Roti Bakar & Snack Corner", .belumSertifikasi, "https://maps.google.com/?q=roti+bakar+snack+corner")
        menu(t17, "Roti Bakar Coklat Keju", 15000, [.roti], [], [], [], [.keju], [.susu, .gluten], false, .renyah, .cemilan, .panggang, .reguler, false, false, false)
        menu(t17, "Roti Bakar Kacang", 13000, [.roti], [], [.kacang], [], [], [.kacang, .gluten], false, .renyah, .cemilan, .panggang, .reguler, false, false, false)
        menu(t17, "Kentang Goreng", 12000, [.kentang], [], [], [], [.saus], [], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t17, "Pisang Goreng Keju", 12000, [], [], [], [], [.keju], [.susu, .gluten], false, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t17, "Roti Bakar Anak (Coklat, Tanpa Kacang)", 12000, [.roti], [], [], [], [], [.gluten, .susu], false, .renyah, .cemilan, .panggang, .porsiAnak, false, false, false)
        menu(t17, "Kentang Mustofa (Kentang Kering Pedas)", 14000, [.kentang], [], [.kacang], [], [.sambal], [.kacang], true, .renyah, .cemilan, .goreng, .reguler, false, false, false)
        menu(t17, "Mie Instan Goreng Telur (Snack)", 13000, [.mie], [.telur], [], [], [], [.gluten, .telur], false, .kering, .cemilan, .goreng, .reguler, true, false, false)

        try? context.save()
    }
}
