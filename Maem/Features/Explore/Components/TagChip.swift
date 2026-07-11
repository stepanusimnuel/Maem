//
//  SwiftUIView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import SwiftUI

enum TagChipStyle {
    case compact
    case regular
    case small
    
    var horizontalPadding: CGFloat {
        switch self {
        case .compact, .small: 8
        case .regular: 10
        }
    }
    
    var verticalPadding: CGFloat {
        switch self {
        case .compact, .small: 6
        case .regular: 8
        }
    }
    
    var font: Font {
        switch self {
        case .compact, .small: AppFont.caption2(weight: .regular)
        case .regular: AppFont.callout(weight: .regular)
        }
    }
    
    var iconSize: CGFloat { 14 }
}

struct TagChip: View {
    let tag: DisplayTag
    var style: TagChipStyle = .compact
    
    var body: some View {
        HStack(spacing: 4) {
            Image(tag.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: style.iconSize, height: style.iconSize)
            
            Text(tag.title)
                .font(style.font)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .foregroundStyle(AppColor.blue700)
        .padding(.horizontal, style.horizontalPadding)
        .padding(.vertical, style.verticalPadding)
        .background(AppColor.blue100)
        .clipShape(Capsule())
    }
}


#Preview("All Tags") {

    ScrollView(.horizontal) {

        HStack(spacing: 8) {

            TagChip(tag: .protein)
            TagChip(tag: .allergen)
            TagChip(tag: .kidsPortion)
            TagChip(tag: .notSpicy)
            TagChip(tag: .vegetable)

        }
        .padding()

    }

}
