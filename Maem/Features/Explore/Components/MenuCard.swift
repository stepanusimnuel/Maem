//
//  MenuCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import SwiftUI

struct MenuCard: View {

    let menu: Menu
    
    let onBookmarkTapped: (Menu) -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            imageSection

            VStack(alignment: .leading, spacing: 14) {
                infoSection
                
                tagSection
            }

        }
        .frame(width: 180, height: 230)
        .padding(8)
        .background(AppColor.neutralWhite)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )

    }

}

// MARK: - Image

private extension MenuCard {
    @ViewBuilder
    var imageSection: some View {
        ZStack(alignment: .topTrailing) {
            Group {
                if let imageName = menu.imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Rectangle()
                        .fill(AppColor.red100)
                }
            }
            .frame(width: 180, height: 120)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

// MARK: - Info

private extension MenuCard {

    var infoSection: some View {

        VStack(alignment: .leading, spacing: 0) {

            HStack {
                Text(menu.name)
                    .font(AppFont.callout(weight: .bold))
                    .foregroundStyle(AppColor.neutralBlack)
                    .lineLimit(2)
                
                Spacer()
                
                Button {
                    onBookmarkTapped(menu)
                } label: {
                    Image(systemName: menu.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(AppFont.callout(weight: .bold))
                        .foregroundStyle(AppColor.red700)
                }
                .buttonStyle(.plain)
            }
            
            HStack(spacing: 2) {
                Image(systemName: "storefront.circle")
                    .frame(width: 15, height: 15)
                
                Text(menu.tenant?.name ?? "Unknown")
            }
            .font(AppFont.caption2())
            .foregroundStyle(AppColor.neutralBlack)

            Text(
                menu.price,
                format: .currency(code: "IDR")
            )
            .font(AppFont.caption3())
            .foregroundStyle(AppColor.neutralSystemGrey)

        }

    }

}

// MARK: - Tags

private extension MenuCard {

    var tagSection: some View {

        HStack(spacing: 6) {

            ForEach(Array(menu.tags.displayTags.prefix(1)), id: \.self) {

                TagChip(tag: $0, style: .compact)

            }

        }

    }

}
