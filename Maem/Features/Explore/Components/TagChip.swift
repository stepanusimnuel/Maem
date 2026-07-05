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
                .frame(width: 15, height: 15)

            Text(tag.title)
                .font(AppFont.caption(weight: .medium))

        }
        .foregroundStyle(AppColor.blue700)
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
