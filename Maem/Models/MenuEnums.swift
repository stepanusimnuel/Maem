import Foundation
import FoundationModels

@Generable
enum Carb: String, Codable, CaseIterable {
    case nasi, nasiGoreng, mie, bihun, kwetiau, kentang, roti, lontongKetupat, bubur, pasta, jagung, singkong, other
}

@Generable
enum ProteinHewani: String, Codable, CaseIterable {
    case ayam, sapi, kambing, ikan, udang, cumi, telur, bebek, bakso, sosis, other
}

@Generable
enum ProteinNabati: String, Codable, CaseIterable {
    case tahu, tempe, jamur, edamame, kacang, other
}

@Generable
enum Veggie: String, Codable, CaseIterable {
    case sop, capcay, bayam, kangkung, wortel, buncis, toge, brokoli, terong, sawi, lalapan, jamur, other
}

enum Topping: String, Codable, CaseIterable {
    case kerupuk, sambal, kecap, acar, telurCeplok, keju, saus, bawangGoreng, other
}

@Generable
enum Allergen: String, Codable, CaseIterable {
    case kacang, udangKerang, ikan, telur, susu, gluten, kedelai, wijen
}

@Generable
enum CookMethod: String, Codable, CaseIterable {
    case goreng, bakar, panggang, kukus, rebus, tumis, mentahSalad, other
}

@Generable
enum Texture: String, Codable, CaseIterable {
    case berkuah, lembut, kering, renyah, lengket, other
}

@Generable
enum MealCategory: String, Codable, CaseIterable {
    case makananBerat, cemilan, minuman, dessert, other
}

enum HalalStatus: String, Codable, CaseIterable {
    case bersertifikat, belumSertifikasi, nonHalal
}

enum Portion: Int, Codable, CaseIterable, Comparable {
    case porsiAnak = 0, reguler = 1, sharing = 2
    static func < (l: Portion, r: Portion) -> Bool { l.rawValue < r.rawValue }
}
