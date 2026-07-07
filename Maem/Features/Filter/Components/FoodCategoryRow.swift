//
//  FoodCategoryRow.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct FoodCategoryRow: View {

    let category: FoodCategory

    let isSelected: Bool

    let action: () -> Void

    var body: some View {

        Button {

            action()

        }

        label: {

            HStack {

                Text(

                    category.title

                )

                Spacer()

                ZStack {

                    Circle()

                        .stroke(

                            AppColor.red700,

                            lineWidth: 2

                        )

                        .frame(width: 22, height: 22)

                    if isSelected {

                        Circle()

                            .fill(

                                AppColor.red700

                            )

                            .padding(5)

                    }

                }

            }

            .frame(height: 48)

        }

        .buttonStyle(.plain)

    }

}

#Preview {
    FoodCategoryRow(category: .chicken, isSelected: true, action: {})
}
