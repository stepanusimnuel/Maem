//
//  FoodCourtMapSheet.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI

struct FoodCourtMapSheet: View {

    @Environment(\.dismiss)
    private var dismiss

    let foodCourt: FoodCourtDistance

    let onSelect: () -> Void

    var body: some View {

        VStack(spacing: 20) {

            Image(systemName: "fork.knife.circle.fill")
                .font(.system(size: 48))
                .foregroundStyle(.orange)

            Text(foodCourt.foodCourt.name)
                .font(.title3.bold())

            Text(foodCourt.foodCourt.address)
                .foregroundStyle(.secondary)

            Text(foodCourt.foodCourt.floor)
                .foregroundStyle(.secondary)

            Label(
                "\(Int(foodCourt.distance)) m away",
                systemImage: "figure.walk"
            )

            Button {

                onSelect()
                dismiss()

            } label: {

                Text("Select Food Court")
                    .frame(maxWidth: .infinity)

            }
            .buttonStyle(.borderedProminent)

        }
        .padding()

    }

}
