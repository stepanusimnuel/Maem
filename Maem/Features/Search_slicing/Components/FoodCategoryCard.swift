//
//  FoodCategoryCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct FoodCategoryCard: View {

    let category: FoodCategory

    var body: some View {

        VStack(
            spacing: 8
        ) {

            Image(category.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 20
                    )
                )

            Text(category.title)
                .font(AppFont.caption())
                .multilineTextAlignment(.center)
                .lineLimit(2)

        }

    }

}

#Preview {
    FoodCategoryCard(category: .chicken)
}
