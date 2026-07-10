//
//  FoodCourtCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 03/07/26.
//

import SwiftUI

struct FoodCourtCard: View {

    let foodCourt: FoodCourtDistance
    let isSelected: Bool

    var body: some View {

        HStack(spacing: 16) {

            if (foodCourt.foodCourt.imageName != nil) {
                Image(foodCourt.foodCourt.imageName!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Image(systemName: "building.2.crop.circle.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(AppColor.red700)
                    .frame(width: 110, height: 80)
                    .background(AppColor.red100)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 8) {

                Text("\(foodCourt.foodCourt.name), \(foodCourt.foodCourt.place)")
                    .font(AppFont.callout(weight: .bold))
                    .foregroundStyle(isSelected ? AppColor.red50 : AppColor.neutralBlack)

                Text(foodCourt.foodCourt.address)
                    .font(AppFont.caption(weight: .regular))
                    .foregroundStyle(isSelected ? AppColor.neutralLightGrey : AppColor.neutralSystemGrey)

            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(isSelected ? AppColor.red700: Color.clear)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )

    }

}
