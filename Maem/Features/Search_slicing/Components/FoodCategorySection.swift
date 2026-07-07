//
//  FoodCategorySection.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct FoodCategorySection: View {

    let categories: [FoodCategory]

    let onSelect: (FoodCategory) -> Void

    private let columns = [

        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())

    ]

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            Text("Rekomendasi")
                .font(
                    AppFont.title2(
                        weight: .bold
                    )
                )

            LazyVGrid(
                columns: columns,
                spacing: 24
            ) {

                ForEach(categories) { category in

                    Button {

                        onSelect(category)

                    } label: {

                        FoodCategoryCard(
                            category: category
                        )

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

}

#Preview {
    FoodCategorySection(categories: [.chicken, .dessert], onSelect: {_ in })
}
