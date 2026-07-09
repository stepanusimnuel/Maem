//
//  FilterViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation

enum PriceFilter: String, CaseIterable {

    case below50

    case between50And100

    case above100

    var title: String {

        switch self {

        case .below50:

            "<50.000"

        case .between50And100:

            "50.000 - 100.000"

        case .above100:

            ">100.000"

        }

    }

}

@Observable
final class FilterViewModel {

    var selectedTags: Set<DisplayTag> = []

    var selectedAllergens: Set<Allergen> = []

    var selectedPrice: PriceFilter?

    var minimumPrice = ""

    var maximumPrice = ""

    var selectedCategory: FoodCategory?

}
