//
//  DisplayTag.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation

enum DisplayTag: Hashable {

    case kidsPortion

    case protein

    case notSpicy

    case allergen

    case vegetable

    case easyToChew

}

extension DisplayTag {

    var title: String {

        switch self {

        case .kidsPortion:
            return "Porsi Anak"

        case .protein:
            return "Protein"

        case .notSpicy:
            return "Tidak Pedas"

        case .allergen:
            return "Alergen"

        case .vegetable:
            return "Sayur"

        case .easyToChew:
            return "Mudah Dikunyah"

        }

    }

    var iconName: String {

        switch self {

        case .kidsPortion:
            return "tag-kids"

        case .protein:
            return "tag-protein"

        case .notSpicy:
            return "tag-not-spicy"

        case .allergen:
            return "tag-allergen"

        case .vegetable:
            return "tag-vegetable"

        case .easyToChew:
            return "tag-easy-chew"

        }

    }

}
