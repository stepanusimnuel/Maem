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
        count += filter.tags.count

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

    func load(context: ModelContext) {

        let repository = MenuRepository(
            context: context
        )

        do {

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

        let manual = manualIntent()

        guard !searchText.isEmpty else {
            applyResult(RecommendationEngine().recommend(menus: allMenus, intent: manual))
            return
        }

        Task {
            await runSearch(manual: manual)
        }

    }

    /// Builds the SearchIntent from everything that ISN'T free text: FilterSheet's `filter`,
    /// `mode` (`.kids` implies forKid; `.category` implies the same mapping as filter.category,
    /// when the user hasn't separately picked one in the sheet), and the 3 quick toggles above
    /// the list (isKidFriendly/isHalalOnly/isBelow30K — these duplicate FilterSheet controls in
    /// the UI, so they're unioned in the same safety-preserving way, not treated as a separate
    /// mechanism).
    private func manualIntent() -> SearchIntent {

        var intent = filter.toSearchIntent()

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
    private func resolveTextIntent(for query: String) async -> SearchIntent {

        if FoundationModelIntentParser.isAvailable,
           let intent = try? await FoundationModelIntentParser().parse(query) {
            return intent
        }

        return (try? await KeywordIntentParser().parse(query)) ?? SearchIntent()

    }

    private func applyResult(_ result: RecommendationResult) {
        filteredMenus = result.items.map(\.menuItem)
        relaxationNotes = result.relaxationNotes
        bindingConstraint = result.bindingConstraint
    }
}
