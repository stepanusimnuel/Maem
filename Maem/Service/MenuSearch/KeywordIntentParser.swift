import Foundation

struct KeywordIntentParser: IntentParser {

    func parse(_ text: String) -> SearchIntent {

        let normalized = text.lowercased()
        var intent = SearchIntent()

        intent.avoidAllergens = Self.extractAllergens(from: normalized)
        let compositionText = Self.sanitizeAllergenMentions(from: normalized)

        intent.wantCarbs = matchEnum(Carb.self, in: compositionText)
        intent.wantProteinHewani = matchEnum(ProteinHewani.self, in: compositionText)
        intent.wantProteinNabati = matchEnum(ProteinNabati.self, in: compositionText)
        intent.wantVeggies = matchEnum(Veggie.self, in: compositionText)

        if containsAny(normalized, Self.forKidPhrases) {
            intent.forKid = true
        }

        if containsAny(normalized, Self.mustNotSpicyPhrases) {
            intent.mustNotSpicy = true
        }

        if normalized.contains("halal") {
            intent.requireHalal = true
        }

        if containsAny(normalized, Self.heavyMealPhrases) {
            intent.mealCategory = .makananBerat
        } else if containsAny(normalized, Self.snackPhrases) {
            intent.mealCategory = .cemilan
        } else if containsAny(normalized, Self.drinkPhrases) {
            intent.mealCategory = .minuman
        }

        if containsAny(normalized, Self.healthyPhrases) {
            intent.preferHealthy = true
        }

        intent.maxBudget = Self.extractBudget(from: normalized)

        return intent
    }
}

private extension KeywordIntentParser {

    static let forKidPhrases = ["buat anak", "bocil", "dedek", "si kecil", "balita"]
    static let mustNotSpicyPhrases = ["gak pedes", "nggak pedas", "tidak pedas", "jangan pedas", "tanpa sambal"]
    static let heavyMealPhrases = ["ngenyangin", "berat", "mengenyangkan"]
    static let snackPhrases = ["cemilan", "ngemil", "snack"]
    static let drinkPhrases = ["minuman", "haus", "seger"]
    static let healthyPhrases = ["sehat", "gak berminyak", "fresh", "gak bikin begah"]

    static let allergenSynonyms: [String: Allergen] = [
        "kacang": .kacang,
        "udang": .udangKerang,
        "kerang": .udangKerang,
        "ikan": .ikan,
        "telur": .telur,
        "susu": .susu,
        "gluten": .gluten,
        "kedelai": .kedelai,
        "wijen": .wijen
    ]

    func containsAny(_ text: String, _ phrases: [String]) -> Bool {
        phrases.contains { text.contains($0) }
    }

    func matchEnum<T: RawRepresentable & CaseIterable>(_ type: T.Type, in text: String) -> [T]? where T.RawValue == String {
        let matched = T.allCases.filter { $0.rawValue != "other" && text.contains(Self.deCamelCase($0.rawValue)) }
        return matched.isEmpty ? nil : matched
    }

    static func deCamelCase(_ value: String) -> String {
        var result = ""
        for character in value {
            if character.isUppercase {
                result.append(" ")
                result.append(contentsOf: character.lowercased())
            } else {
                result.append(character)
            }
        }
        return result
    }

    static func sanitizeAllergenMentions(from text: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: #"(alergi|tanpa|gak boleh)\s+(\w+)"#) else {
            return text
        }
        let range = NSRange(text.startIndex..., in: text)
        return regex.stringByReplacingMatches(in: text, range: range, withTemplate: " ")
    }

    static func extractBudget(from text: String) -> Int? {

        if let regex = try? NSRegularExpression(pattern: #"(\d+)\s*(rb|ribu|k)\b"#) {
            let range = NSRange(text.startIndex..., in: text)
            if let match = regex.firstMatch(in: text, range: range),
               let numRange = Range(match.range(at: 1), in: text),
               let number = Int(text[numRange]) {
                return number * 1000
            }
        }

        if let regex = try? NSRegularExpression(pattern: #"(\d{1,3}(?:\.\d{3})+|\d{4,})"#) {
            let range = NSRange(text.startIndex..., in: text)
            if let match = regex.firstMatch(in: text, range: range),
               let numRange = Range(match.range(at: 1), in: text) {
                let cleaned = text[numRange].replacingOccurrences(of: ".", with: "")
                return Int(cleaned)
            }
        }

        return nil
    }

    static func extractAllergens(from text: String) -> [Allergen]? {

        guard let regex = try? NSRegularExpression(pattern: #"(alergi|tanpa|gak boleh)\s+(\w+)"#) else {
            return nil
        }

        let range = NSRange(text.startIndex..., in: text)
        let matches = regex.matches(in: text, range: range)

        var found: Set<Allergen> = []
        for match in matches {
            guard let wordRange = Range(match.range(at: 2), in: text) else { continue }
            let word = String(text[wordRange])
            if let allergen = allergenSynonyms[word] {
                found.insert(allergen)
            }
        }

        return found.isEmpty ? nil : Array(found)
    }
}
