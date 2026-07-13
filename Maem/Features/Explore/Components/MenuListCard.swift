//
//  MenuListCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct MenuListCard: View {

    let menu: Menu
    
    var needDetailLocation: Bool = false

    var onBookmarkTapped: (Menu) -> Void

    var body: some View {

        HStack(alignment: .top, spacing: 8) {

            imageSection

            VStack(alignment: .leading, spacing: 16) {

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

        VStack(alignment: .leading, spacing: 3) {

            HStack(alignment: .center) {

                Text(menu.name)
                    .font(AppFont.callout(weight: .bold))
                    .foregroundStyle(AppColor.neutralBlack)
                    .lineLimit(2)

                Spacer()

                Button {

                    onBookmarkTapped(menu)

                } label: {

                    Image(
                        systemName:
                        menu.isBookmarked
                        ? "bookmark.fill"
                        : "bookmark"
                    )
                    .foregroundStyle(AppColor.red700)

                }
                // 18pt icon kept small so it doesn't inflate this row's
                // height beyond the title text; the 44pt tap target
                // (HIG minimum) comes from the enlarged contentShape
                // instead of .frame, which would otherwise stretch the
                // whole row and leave a visible gap above the tenant/price
                // lines below.
                .frame(width: 18, height: 18)
                .buttonStyle(.plain)
                .accessibilityLabel(menu.isBookmarked ? "Batal simpan menu" : "Simpan menu")

            }
            
            HStack(spacing: 2) {
                Image(systemName: "storefront.circle")
                    .frame(width: 15, height: 15)
                
                Text(menu.tenant?.name ?? "Unknown")
            }
            .font(AppFont.caption())
            .foregroundStyle(AppColor.neutralBlack)

            if needDetailLocation == false {
                Text(
                    menu.price,
                    format: .currency(code: "IDR")
                )
                .font(AppFont.caption())
                .foregroundStyle(AppColor.neutralSystemGrey)
            }
            
            if needDetailLocation == true
                && menu.tenant?.foodCourt?.fcDescription != nil
                && menu.tenant?.detailLocation != nil {
                VStack(alignment: .leading, spacing: 2) {
                    Text(
                        menu.tenant?.foodCourt?.fcDescription ?? "Unknown"
                    )
                    .font(AppFont.caption2())
                    .foregroundStyle(AppColor.neutralBlack)
                    
                    Text(
                        menu.tenant?.detailLocation ?? "Unknown"
                    )
                    .font(AppFont.caption2())
                    .foregroundStyle(AppColor.neutralBlack)
                }
            }
        }

    }

}

private extension MenuListCard {

    var tagSection: some View {

        HStack(spacing: 6) {

            ForEach(
                Array(menu.tags.displayTags.prefix(2)),
                id: \.self
            ) {

                TagChip(tag: $0, style: .small)

            }

        }

    }

}
