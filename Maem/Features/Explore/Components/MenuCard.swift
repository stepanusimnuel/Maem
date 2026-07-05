//
//  MenuCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import SwiftUI

struct MenuCard: View {

    let menu: Menu

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            imageSection

            infoSection

            tagSection

        }
        .frame(width: 180)
        .padding(12)
        .background(AppColor.neutralWhite)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
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
            .frame(height: 140)
            .clipped()
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )

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

                    menu.isBookmarked.toggle()

                } label: {

                    Image(
                        systemName: menu.isBookmarked
                        ? "bookmark.fill"
                        : "bookmark"
                    )
                    .font(AppFont.callout(weight: .bold))
                    .foregroundStyle(AppColor.red700)

                }
            }

            Text(
                menu.price,
                format: .currency(code: "IDR")
            )
            .font(AppFont.caption())
            .foregroundStyle(AppColor.neutralSystemGrey)

        }

    }

}

// MARK: - Tags

private extension MenuCard {

    var tagSection: some View {

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 6) {

                ForEach(menu.tags.displayTags, id: \.self) { tag in

                    TagChip(
                        tag: tag
                    )

                }

            }

        }

    }

}
