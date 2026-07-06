//
//  MenuListCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct MenuListCard: View {

    let menu: Menu

    var body: some View {

        HStack(alignment: .top, spacing: 16) {

            imageSection

            VStack(alignment: .leading, spacing: 2) {

                infoSection

                tagSection

            }

        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppColor.neutralWhite)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .shadow(
            color: Color.black.opacity(0.10),
            radius: 12,
            x: 0,
            y: 8
        )

    }

}

private extension MenuListCard {

    var imageSection: some View {

        Group {

            if let imageName = menu.imageName {

                Image(imageName)
                    .resizable()
                    .scaledToFill()

            } else {

                Rectangle()
                    .fill(AppColor.red100)

            }

        }
        .frame(width: 120, height: 100)
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )

    }

}

private extension MenuListCard {

    var infoSection: some View {

        VStack(alignment: .leading, spacing: 4) {

            HStack(alignment: .top) {

                Text(menu.name)
                    .font(AppFont.callout(weight: .bold))
                    .foregroundStyle(AppColor.neutralBlack)
                    .lineLimit(2)

                Spacer()

                Button {

                    menu.isBookmarked.toggle()

                } label: {

                    Image(
                        systemName:
                        menu.isBookmarked
                        ? "bookmark.fill"
                        : "bookmark"
                    )
                    .foregroundStyle(AppColor.red700)

                }
                .buttonStyle(.plain)

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

private extension MenuListCard {

    var tagSection: some View {

        VStack(alignment: .leading, spacing: 6) {

            HStack(spacing: 6) {

                ForEach(
                    Array(menu.tags.displayTags.prefix(2)),
                    id: \.self
                ) {

                    TagChip(tag: $0)

                }

            }

            let secondRow = Array(
                menu.tags.displayTags
                    .dropFirst(2)
                    .prefix(2)
            )

            if !secondRow.isEmpty {

                HStack(spacing: 6) {

                    ForEach(
                        secondRow,
                        id: \.self
                    ) {

                        TagChip(tag: $0)

                    }

                }

            }

        }
        .padding(.top, 8)

    }

}
