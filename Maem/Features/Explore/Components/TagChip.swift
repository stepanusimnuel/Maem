//
//  SwiftUIView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import SwiftUI

struct TagChip: View {

    let tag: DisplayTag

    var body: some View {

        HStack(spacing: 4) {

            icon
                .frame(width: 14, height: 14)

            Text(tag.title)
                .font(AppFont.caption(weight: .regular))
                .lineLimit(1)
                .truncationMode(.tail)

        }
        .foregroundStyle(AppColor.blue700)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(AppColor.blue100)
        .clipShape(Capsule())

    }

}

private extension TagChip {

    /// `.spicy` uses an SF Symbol (there's no literal chili-pepper symbol in
    /// SF Symbols, so `flame.fill` is the closest heat/spice association) -
    /// every other tag keeps using its custom asset icon.
    @ViewBuilder
    var icon: some View {

        if tag == .spicy {

            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()

        } else {

            Image(tag.iconName)
                .resizable()
                .scaledToFit()

        }

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
