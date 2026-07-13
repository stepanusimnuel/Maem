//
//  HorizontalMenuSection.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct HorizontalMenuSection: View {

    let title: String

    let menus: [Menu]

    let onSeeAll: () -> Void
    
    var onBookmarkTapped: (Menu) -> Void

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 4
        ) {

            header

            ScrollView(
                .horizontal,
                showsIndicators: false
            ) {

                LazyHStack(
                    spacing: 16
                ) {

                    ForEach(menus) { menu in

                        NavigationLink {

                            MenuDetailView(
                                menu: menu
                            )

                        } label: {

                            MenuCard(menu: menu) { clickedMenu in
                                onBookmarkTapped(clickedMenu)
                            }
                            .shadow(color: Color.black.opacity(0.25), radius: 3, x: 0, y: 2)

                        }
                        .buttonStyle(.plain)

                    }

                }
                .padding(8)

            }

        }

    }

}

private extension HorizontalMenuSection {

    var header: some View {

        HStack {

            Text(title)
                .font(
                    AppFont.body(
                        weight: .bold
                    )
                )

            Spacer()

            Button {

                onSeeAll()

            } label: {

                HStack(spacing: 4) {
                    Text("Lihat Lainnya")
                      
                    Image(systemName: "chevron.right")
                }
                .font(
                    AppFont.callout(
                        weight: .semibold
                    )
                )
                .foregroundStyle(AppColor.red700)

            }

        }

    }

}
