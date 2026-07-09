//
//  DisplayTag.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation

enum DisplayTag: CaseIterable, Hashable {

    case kidsPortion

    case protein

    case notSpicy
    
    case spicy

    case allergen

    case vegetable
    
    case isInstant
    
    case soupy

}

extension DisplayTag {

    var title: String {

        switch self {

        case .kidsPortion:
            return "Porsi Kecil"

        case .protein:
            return "Protein"

        case .notSpicy:
            return "Tidak Pedas"
            
        case .spicy:
            return "Pedas"

        case .allergen:
            return "Alergen"

        case .vegetable:
            return "Sayur"
            
        case .isInstant:
            return "Cepat Saji"
            
        case .soupy:
            return "Berkuah"
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
            
        case .spicy:
            return "tag-spicy"

        case .allergen:
            return "tag-allergen"

        case .vegetable:
            return "tag-vegetable"
            
        case .isInstant:
            return "tag-is-instant"
            
        case .soupy:
            return "tag-soupy"

        }

    }

}
