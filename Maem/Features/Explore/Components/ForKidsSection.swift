//
//  ForKidSection.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import SwiftUI

struct ForKidsSection: View {

    let menus: [Menu]

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

                        MenuCard(
                            menu: menu
                        )

                    }

                }
                .padding(.horizontal)

            }

        }

    }

}

private extension ForKidsSection {

    var header: some View {

        VStack(
            alignment: .leading,
            spacing: 2
        ) {

            Text("Untuk Si Kecil")
                .font(AppFont.title2(weight: .bold))
                .foregroundStyle(AppColor.red50)

        }
        .padding(.horizontal)
    }

}

#Preview {

    ScrollView {

        ForKidsSection(
            menus: [

                Menu(
                    name: "Chicken Teriyaki",
                    price: 52000,
                    imageName: nil,
                    tags: MenuTags(
                        carbs: [.rice],
                        animalProtein: [.chicken],
                        plantProtein: nil,
                        allergens: [],
                        portion: .reguler,
                        
                    )
                ),

                Menu(
                    name: "Beef Bowl",
                    price: 56000,
                    imageName: nil,
                    tags: MenuTags(
                        carbs: [.rice],
                        animalProtein: [.beef],
                        plantProtein: nil,
                        allergens: [],
                        portion: .reguler,
                    )
                )

            ]

        )

    }

}
