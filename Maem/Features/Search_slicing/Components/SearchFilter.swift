//
//  SearchFilter.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation

struct SearchFilter {

    /// Tags the user explicitly turned on — wins over text inference.
    var selectedTags: Set<DisplayTag> = []

    /// Tags the user explicitly turned off — wins over text inference for
    /// non-safety fields; is a UI-only no-op for safety fields, since
    /// SearchIntent.merged(withManual:) OR-combines those regardless of what
    /// toSearchIntent(inferred:) emits for them (see spec, "Safety-field lock").
    var excludedTags: Set<DisplayTag> = []

    var allergens: Set<Allergen> = []

    var priceFilter: PriceFilter?

    var minimumPrice = ""

    var maximumPrice = ""

    var category: FoodCategory?

    var cookMethod: ManualOverride<CookMethod> = .unset

}

extension SearchFilter {

    /// A tag is on if the user explicitly selected it, or if the text parser
    /// implied it and the user hasn't explicitly excluded it. `excludedTags`
    /// always wins, even over an inferred tag. This is the single source of
    /// truth for tag chip state — every UI surface that shows a DisplayTag
    /// chip (FilterSheet's Tags row, ResultView's quick-filter row below the
    /// search field) must read through this, not keep its own separate flag,
    /// or the two can visually disagree about the same underlying filter.
    func isEffectivelyOn(_ tag: DisplayTag, inferred: Set<DisplayTag>) -> Bool {
        if excludedTags.contains(tag) { return false }
        return selectedTags.contains(tag) || inferred.contains(tag)
    }

    /// Tapping always flips explicit intent: on (however it got there) -> move
    /// to excludedTags; off -> move to selectedTags. Applies uniformly to every
    /// tag including safety ones (requireHalal/forKid/mustNotSpicy) — the
    /// resulting excludedTags membership is a real UI state, it's
    /// SearchIntent.merged(withManual:) that makes it a no-op for those
    /// specific fields, not this function.
    mutating func toggle(_ tag: DisplayTag, inferred: Set<DisplayTag>) {
        if isEffectivelyOn(tag, inferred: inferred) {
            selectedTags.remove(tag)
            excludedTags.insert(tag)
        } else {
            excludedTags.remove(tag)
            selectedTags.insert(tag)
        }
    }

}
