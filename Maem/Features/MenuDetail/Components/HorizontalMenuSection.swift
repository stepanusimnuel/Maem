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

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 16
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

                            MenuCard(
                                menu: menu
                            )

                        }
                        .buttonStyle(.plain)

                    }

                }

            }

        }

    }

}

private extension HorizontalMenuSection {

    var header: some View {

        HStack {

            Text(title)
                .font(
                    AppFont.title2(
                        weight: .bold
                    )
                )

            Spacer()

            Button {

                onSeeAll()

            } label: {

                Text("Lihat Semua")
                    .font(
                        AppFont.callout(
                            weight: .semibold
                        )
                    )

            }

        }

    }

}
