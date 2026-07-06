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

            Image(tag.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)

            Text(tag.title)
                .font(AppFont.caption(weight: .medium))
                .lineLimit(1)
                .truncationMode(.tail)

        }
        .foregroundStyle(AppColor.blue700)
        .frame(maxWidth: 90)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(AppColor.blue100)
        .clipShape(Capsule())

    }

}

#Preview("All Tags") {

    ScrollView(.horizontal) {

        HStack(spacing: 8) {

            TagChip(tag: .protein)
            TagChip(tag: .allergen)
            TagChip(tag: .easyToChew)
            TagChip(tag: .kidsPortion)
            TagChip(tag: .notSpicy)
            TagChip(tag: .vegetable)

        }
        .padding()

    }

}
