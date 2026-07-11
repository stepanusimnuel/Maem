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
