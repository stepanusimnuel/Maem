//
//  SearchFilter.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation

struct SearchFilter {

    var tags: Set<DisplayTag> = []

    var allergens: Set<Allergen> = []

    var priceFilter: PriceFilter?

    var minimumPrice = ""

    var maximumPrice = ""

    var category: FoodCategory?

}
