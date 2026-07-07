//
//  FoodCategory.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation

enum FoodCategory: CaseIterable, Identifiable {

    case rice

    case noodle

    case fish

    case chicken

    case snack

    case soupy

    case drink

    case dessert

    case porridge

    var id: Self {

        self

    }

}

extension FoodCategory {

    var title: String {

        switch self {

        case .rice:

            "Aneka nasi"

        case .noodle:

            "Aneka mie"

        case .fish:

            "Ikan"

        case .chicken:

            "Ayam & bebek"

        case .snack:

            "Jajanan"

        case .soupy:

            "Berkuah"

        case .drink:

            "Minuman"

        case .dessert:

            "Dessert"

        case .porridge:

            "Bubur"

        }

    }

    var imageName: String {

        switch self {

        case .rice:

            "category-rice"

        case .noodle:

            "category-noodle"

        case .fish:

            "category-fish"

        case .chicken:

            "category-chicken"

        case .snack:

            "category-snack"

        case .soupy:

            "category-soupy"

        case .drink:

            "category-drink"

        case .dessert:

            "category-dessert"

        case .porridge:

            "category-porridge"

        }

    }

}
