import Foundation

struct KeywordIntentParser: IntentParser {

    func parse(_ text: String) -> SearchIntent {

        let normalized = text.lowercased()
        var intent = SearchIntent()

        intent.avoidAllergens = Self.extractAllergens(from: normalized)
        let compositionText = Self.sanitizeAllergenMentions(from: normalized)

        intent.wantCarbs = matchEnum(Carb.self, in: compositionText)
        intent.wantProteinHewani = matchEnum(AnimalProtein.self, in: compositionText)
        intent.wantProteinNabati = matchEnum(PlantProtein.self, in: compositionText)
        intent.wantVeggies = matchEnum(Veggie.self, in: compositionText)
        intent.cookMethodPreference = matchCookMethod(in: compositionText)

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
            intent.mealCategory = .heavyMeal
        } else if containsAny(normalized, Self.snackPhrases) {
            intent.mealCategory = .snack
        } else if containsAny(normalized, Self.drinkPhrases) {
            intent.mealCategory = .drink
        }

        if containsAny(normalized, Self.healthyPhrases) {
            intent.preferHealthy = true
        }

        intent.maxBudget = Self.extractBudget(from: normalized)
        intent.nameHints = Self.extractNameHints(from: compositionText)
        intent.nameRelevanceWords = Self.extractNameRelevanceWords(from: compositionText)

        return intent
    }

    /// Exposes allergen extraction alone (not full parsing) so callers can run
    /// it as a deterministic safety backstop regardless of which parser
    /// (FoundationModelIntentParser or this one) produced the primary intent —
    /// avoidAllergens is safety-critical and must not depend solely on the
    /// on-device LLM's judgment. See CLAUDE.md: price/allergen/halal are
    /// code-enforced, never model-trusted.
    static func extractAllergensOnly(from text: String) -> [Allergen]? {
        Self.extractAllergens(from: text.lowercased())
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
        "kacang": .peanut,
        "udang": .shrimp,
        "kerang": .shellfish,
        "ikan": .fish,
        "telur": .egg,
        "susu": .milk,
        "gluten": .gluten,
        "kedelai": .soy,
        "wijen": .sesame
    ]

    static let sentinelRawValues: Set<String> = ["other", "none", "tidak ada", "lainnya"]

    /// Trigger phrase, then up to 4 filler words (non-greedy), then one of the
    /// KNOWN allergen words specifically — not "any word" via `\w+`. A plain
    /// `(alergi|tanpa|gak boleh)\s+(\w+)` only matched when the allergen word
    /// was immediately adjacent to the trigger, so common phrasings like
    /// "alergi sama kacang" or "gak boleh makan udang" captured the filler
    /// word ("sama"/"makan") instead of the real allergen and silently missed
    /// it entirely — a real safety gap, since avoidAllergens is meant to be
    /// code-enforced and never miss a stated allergy.
    static let allergenMentionPattern: String = {
        let words = allergenSynonyms.keys.map { NSRegularExpression.escapedPattern(for: $0) }
        return "(alergi|tanpa|gak boleh)(?:\\s+\\w+){0,4}?\\s+(\(words.joined(separator: "|")))\\b"
    }()

    static let knownVocabulary: Set<String> = {
        var words = Set<String>()
        for c in Carb.allCases where !sentinelRawValues.contains(c.rawValue.lowercased()) {
            words.formUnion(c.rawValue.lowercased().split(separator: " ").map(String.init))
        }
        for p in AnimalProtein.allCases where !sentinelRawValues.contains(p.rawValue.lowercased()) {
            words.formUnion(p.rawValue.lowercased().split(separator: " ").map(String.init))
        }
        for p in PlantProtein.allCases where !sentinelRawValues.contains(p.rawValue.lowercased()) {
            words.formUnion(p.rawValue.lowercased().split(separator: " ").map(String.init))
        }
        for v in Veggie.allCases where !sentinelRawValues.contains(v.rawValue.lowercased()) {
            words.formUnion(v.rawValue.lowercased().split(separator: " ").map(String.init))
        }
        for c in CookMethod.allCases where !sentinelRawValues.contains(c.rawValue.lowercased()) {
            words.formUnion(c.rawValue.lowercased().split(separator: " ").map(String.init))
        }
        return words
    }()

    func containsAny(_ text: String, _ phrases: [String]) -> Bool {
        phrases.contains { text.contains($0) }
    }

    func matchEnum<T: RawRepresentable & CaseIterable>(_ type: T.Type, in text: String) -> [T]? where T.RawValue == String {
        let matched = T.allCases.filter {
            !Self.sentinelRawValues.contains($0.rawValue.lowercased()) && text.contains($0.rawValue.lowercased())
        }
        return matched.isEmpty ? nil : matched
    }

    func matchCookMethod(in text: String) -> CookMethod? {
        CookMethod.allCases.first {
            !Self.sentinelRawValues.contains($0.rawValue.lowercased()) && text.contains($0.rawValue.lowercased())
        }
    }

    static func sanitizeAllergenMentions(from text: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: allergenMentionPattern) else {
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

        guard let regex = try? NSRegularExpression(pattern: allergenMentionPattern) else {
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

    static func extractNameHints(from text: String) -> [String]? {
        var seen = Set<String>()
        var hints: [String] = []
        for word in text.split(whereSeparator: { !$0.isLetter }) {
            let lower = word.lowercased()
            guard lower.count >= 3, !stopwords.contains(lower), !knownVocabulary.contains(lower) else { continue }
            if seen.insert(lower).inserted {
                hints.append(lower)
            }
        }
        return hints.isEmpty ? nil : hints
    }

    /// Same tokenizer/stopword filtering as extractNameHints, but - unlike
    /// extractNameHints - does NOT exclude knownVocabulary words. This is the
    /// entire point: a query word recognized as structured vocab (e.g. "nasi"
    /// -> Carb.rice) still gets checked against the literal menu name for
    /// ranking, even though it's excluded from nameHints (which only exists
    /// as a hard-filter fallback for words the structured parser couldn't
    /// place anywhere).
    static func extractNameRelevanceWords(from text: String) -> [String]? {
        var seen = Set<String>()
        var words: [String] = []
        for word in text.split(whereSeparator: { !$0.isLetter }) {
            let lower = word.lowercased()
            guard lower.count >= 3, !stopwords.contains(lower) else { continue }
            if seen.insert(lower).inserted {
                words.append(lower)
            }
        }
        return words.isEmpty ? nil : words
    }

    static let stopwords: Set<String> = [
        "buat", "anak", "bocil", "dedek", "si", "kecil", "balita",
        "gak", "ga", "nggak", "ngga", "tidak", "jangan", "pedas", "pedes", "sambal", "tanpa", "boleh",
        "alergi", "halal",
        "murah", "murmer", "hemat", "budget", "rb", "ribu", "k",
        "ngenyangin", "berat", "mengenyangkan", "cemilan", "ngemil", "snack", "minuman", "haus", "seger",
        "sehat", "berminyak", "fresh", "begah",
        "dan", "di", "ke", "yang", "untuk", "ya", "dong", "aja", "apa", "mau", "banget", "nih", "itu", "ini",
        "atau", "dengan", "biar", "kalau", "kalo", "mo", "pengen", "pengin", "enak",
        "makan", "makanan", "menu", "cari", "carikan", "kasih", "rekomendasi", "kuliner", "jajan",
        "resto", "warung", "kedai", "mo", "pengin", "ada", "adakah", "gimana", "gmn", "kek", "kayak",
        "seperti", "tolong", "please", "min", "kak", "bang", "kenyang", "laper", "lapar"
    ]
}
