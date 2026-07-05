//
//  FoodCourtRow.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI

struct FoodCourtRow: View {

    let foodCourt: FoodCourtDistance

    var body: some View {

        HStack(alignment: .top, spacing: 16) {

            Image(systemName: "fork.knife.circle.fill")
                .font(.title2)
                .foregroundStyle(.orange)

            VStack(alignment: .leading, spacing: 4) {

                Text(foodCourt.foodCourt.name)
                    .font(.headline)

                Text(foodCourt.foodCourt.address)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

            }

            Spacer()

            Text("\(Int(foodCourt.distance)) m")
                .font(.caption)
                .foregroundStyle(.blue)

        }
        .padding(.vertical, 6)

    }

}

#Preview {

    FoodCourtRow(
        foodCourt: FoodCourtDistance(
            foodCourt: FoodCourt(
                name: "AEON Mall BSD - Food Culture",
                place: "AEON Mall BSD",
                address: "Jalan BSD Raya Utama, Padegangan",
                latitude: 0,
                longitude: 0
            ),
            distance: 182
        )
    )

}
