//
//  SearchSlicingViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation

@Observable
final class SearchSlicingViewModel {

    var searchText = ""
    var showResult = false

    let suggestions = [

        "Makanan yang bukan junk food",

        "Minuman hangat untuk anak",

        "Makanan berprotein tinggi"

    ]

    let recentSearches = [

        "Ayam yang tidak pedas",

        "Bubur untuk anak"

    ]

    let categories: [FoodCategory] = [

        .rice,

        .noodle,

        .fish,

        .chicken,

        .snack,

        .soupy,

        .drink,

        .dessert,

        .porridge

    ]

}
