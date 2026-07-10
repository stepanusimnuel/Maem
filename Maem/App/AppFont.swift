//
//  AppFont.swift
//  Maem
//
//  Created by Stepanus Imanuel on 03/07/26.
//


import SwiftUI

enum AppFont {

    static func largeTitle(weight: Font.Weight = .bold) -> Font {
        .system(size: 34, weight: weight, design: .rounded)
    }

    static func title(weight: Font.Weight = .bold) -> Font {
        .system(size: 28, weight: weight, design: .rounded)
    }

    static func title2(weight: Font.Weight = .semibold) -> Font {
        .system(size: 24, weight: weight, design: .rounded)
    }

    static func headline(weight: Font.Weight = .semibold) -> Font {
        .system(size: 17, weight: weight, design: .rounded)
    }

    static func body(weight: Font.Weight = .regular) -> Font {
        .system(size: 18, weight: weight, design: .rounded)
    }

    static func callout(weight: Font.Weight = .regular) -> Font {
        .system(size: 16, weight: weight, design: .rounded)
    }

    static func caption(weight: Font.Weight = .regular) -> Font {
        .system(size: 14, weight: weight, design: .rounded)
    }
    
    static func caption2(weight: Font.Weight = .regular) -> Font {
        .system(size: 12, weight: weight, design: .rounded)
    }
    
    static func caption3(weight: Font.Weight = .regular) -> Font {
        .system(size: 10, weight: weight, design: .rounded)
    }
}
