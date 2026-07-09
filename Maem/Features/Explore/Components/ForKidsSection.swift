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
            spacing: 12
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
                .padding(.horizontal)

            }

        }
        .padding(.vertical, 16)
        .background(AppColor.red300)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )

    }

}

private extension ForKidsSection {

    var header: some View {

        VStack(
            alignment: .leading,
            spacing: 2
        ) {

            HStack(alignment: .center, spacing: 3) {
                Text("Untuk Si Kecil")
                    .font(AppFont.title2(weight: .bold))
                    
                
                Image(systemName: "chevron.right")
                    .font(AppFont.body(weight: .bold))
            }.foregroundStyle(AppColor.red700)

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
                    menuDescription: "Test",
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
                    menuDescription: "Test",
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
