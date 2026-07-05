//
//  SelectedFoodCourtCard.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI

struct SelectedFoodCourtCard: View {

    let foodCourt: FoodCourtDistance

    let onSelect: () -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text(foodCourt.foodCourt.name)
                .font(.headline)

            Text(foodCourt.foodCourt.address)
                .foregroundStyle(.secondary)

            Label(
                "\(Int(foodCourt.distance)) m away",
                systemImage: "figure.walk"
            )
            .font(.caption)

            Button {

                onSelect()

            } label: {

                Text("Select Food Court")
                    .frame(maxWidth: .infinity)

            }
            .buttonStyle(.borderedProminent)

        }
        .padding()
        .background(.background)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .shadow(radius: 8)

    }

}

#Preview {

    SelectedFoodCourtCard(
        foodCourt: FoodCourtDistance(
            foodCourt: FoodCourt(
                name: "AEON Mall BSD - Food Culture",
                place: "AEON Mall BSD",
                address: "Jalan Raya BSD Utama, Padegangan",
                latitude: 0,
                longitude: 0
            ),
            distance: 182
        )
    ) {

    }

}
