//
//  SearchResultViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation
import SwiftData

enum MenuListMode {

    case kids
    case all
    case search(String)
    case category(FoodCategory)
    case similar(Menu)
}


@Observable
final class ResultViewModel {
    
    let foodCourt: FoodCourt
    
    let mode: MenuListMode

    var searchText: String
    
    var allMenus: [Menu] = []

    var filteredMenus: [Menu] = []

    var filter = SearchFilter()

    var isShowingFilter = false

    var isHalalOnly = false

    var isBelow30K = false
    
    var isKidFriendly = false
    
    var navigationTitle: String? {

        switch mode {

        case .search:
            return nil

        case .kids:
            return "Untuk Si Kecil"

        case .all:
            return "Untuk Semua"
            
        case .category:
            return nil

        case .similar:
            return "Menu Serupa"
        }

    }

    var shouldShowSearchHeader: Bool {

        switch mode {

        case .search,
             .category:
            return true

        default:
            return false
        }

    }

    /// `.similar` has no free-text search and no manual-filter UI (spec decision
    /// 7 - not requested, and "similar to this menu" isn't expressible as a
    /// SearchIntent for FilterSheet/quick-filter chips to refine anyway).
    var shouldShowQuickFilterSection: Bool {

        if case .similar = mode {
            return false
        }

        return true

    }
    
    var activeFilterCount: Int {

        var count = 0

        // Quick Filter
        if isKidFriendly {
            count += 1
        }

        if isBelow30K {
            count += 1
        }

        if isHalalOnly {
            count += 1
        }

        // Display Tags
        count += filter.selectedTags.count

        // Alergen
        count += filter.allergens.count

        // Kategori
        if filter.category != nil {
            count += 1
        }

        // Preset harga
        if filter.priceFilter != nil {
            count += 1
        }

        // Custom harga
        if !filter.minimumPrice.isEmpty {
            count += 1
        }

        if !filter.maximumPrice.isEmpty {
            count += 1
        }

        return count
    }

    init(
        mode: MenuListMode,
        foodCourt: FoodCourt
    ) {

        self.mode = mode

        self.foodCourt = foodCourt

        switch mode {

        case .search(let query):

            self.searchText = query

        default:

            self.searchText = ""

        }

    }

    var relaxationNotes: [String] = []
    var bindingConstraint: String? = nil

    /// The most recently resolved free-text SearchIntent, kept so FilterSheet
    /// can show which chips the parser inferred from the last submitted search.
    /// nil before any search has run, or when searchText is empty (the
    /// early-return branch of applyFilter() never calls runSearch, so there's
    /// no text intent to report).
    private(set) var lastTextIntent: SearchIntent?

    func load(context: ModelContext) {

        let repository = MenuRepository(
            context: context
        )

        do {

            if case .similar(let referenceMenu) = mode {

                let result = try repository.getSimilarMenus(to: referenceMenu)

                filteredMenus = result.items
                relaxationNotes = result.isRelaxed
                    ? ["Tidak ada menu yang sangat mirip - berikut yang paling mendekati."]
                    : []
                bindingConstraint = nil

                return

            }

            allMenus = try repository.getMenus(
                in: foodCourt
            )

            applyFilter()

        }

        catch {

        }

    }

    /// Single entry point for all 3 modes and the FilterSheet. Everything funnels into one
    /// merged SearchIntent so RecommendationEngine is the one place filtering/ranking/
    /// relaxation logic lives (spec decision 7) — this replaces the 8 independent predicate
    /// chains the teammate's original applyFilter() ran (search text, tags, kidsFriendly,
    /// below30K, halalOnly, allergens, category, price preset/min/max).
    func applyFilter() {

        guard !searchText.isEmpty else {
            lastTextIntent = nil
            applyResult(RecommendationEngine().recommend(menus: allMenus, intent: manualIntent()))
            return
        }

        Task {
            await runSearch(manual: manualIntent())
        }

    }

    /// Builds the SearchIntent from everything that ISN'T free text: FilterSheet's `filter`,
    /// `mode` (`.kids` implies forKid; `.category` implies the same mapping as filter.category,
    /// when the user hasn't separately picked one in the sheet), and the 3 quick toggles above
    /// the list (isKidFriendly/isHalalOnly/isBelow30K — these duplicate FilterSheet controls in
    /// the UI, so they're unioned in the same safety-preserving way, not treated as a separate
    /// mechanism).
    private func manualIntent() -> SearchIntent {

        var intent = filter.toSearchIntent(inferred: lastTextIntent?.impliedTags() ?? [])

        if case .kids = mode {
            intent.forKid = true
        }

        if case .category(let category) = mode, filter.category == nil {
            category.apply(to: &intent)
        }

        if isKidFriendly {
            intent.forKid = true
        }
        if isHalalOnly {
            intent.requireHalal = true
        }
        if isBelow30K {
            intent.maxBudget = min(intent.maxBudget ?? 30_000, 30_000)
        }

        return intent

    }

    private func runSearch(manual: SearchIntent) async {

        let textIntent = await resolveTextIntent(for: searchText)
        lastTextIntent = textIntent
        let merged = textIntent.merged(withManual: manual)

        applyResult(RecommendationEngine().recommend(menus: allMenus, intent: merged))

    }

    /// Tries the on-device LLM parser first when available, but falls back to
    /// the deterministic KeywordIntentParser - never to an empty SearchIntent()
    /// - if it throws (guardrail violation, unsupported language, model
    /// hiccup, etc). Falling back to an empty intent silently discards
    /// everything the user typed and makes search look completely broken
    /// (every query returns all menus, since no hard filters remain);
    /// KeywordIntentParser is deterministic and never actually throws.
    ///
    /// Regardless of which parser wins above, avoidAllergens is additionally
    /// backstopped with the deterministic regex extractor and unioned in.
    /// Allergen exclusion is safety-critical and must never depend solely on
    /// the on-device LLM's judgment (CLAUDE.md: price/allergen/halal are
    /// code-enforced, never model-trusted) - this closes a real gap where
    /// FoundationModelIntentParser could under-extract an allergen mention the
    /// deterministic parser catches reliably every time.
    private func resolveTextIntent(for query: String) async -> SearchIntent {

        var intent: SearchIntent

        if FoundationModelIntentParser.isAvailable,
           let fmIntent = try? await FoundationModelIntentParser().parse(query) {
            intent = fmIntent
        } else {
            intent = (try? await KeywordIntentParser().parse(query)) ?? SearchIntent()
        }

        if let deterministicAllergens = KeywordIntentParser.extractAllergensOnly(from: query),
           !deterministicAllergens.isEmpty {
            let combined = Set(intent.avoidAllergens ?? []).union(deterministicAllergens)
            intent.avoidAllergens = Array(combined)
        }

        return intent

    }

    private func applyResult(_ result: RecommendationResult) {
        filteredMenus = result.items.map(\.menuItem)
        relaxationNotes = result.relaxationNotes
        bindingConstraint = result.bindingConstraint
    }
}
