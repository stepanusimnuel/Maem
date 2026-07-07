//
//  PriceRangeInput.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct PriceRangeInput: View {

    @Binding

    var minimum: String

    @Binding

    var maximum: String

    var body: some View {

        HStack(

            spacing: 12

        ) {

            TextField(

                "Min",

                text: $minimum

            )

            .keyboardType(.numberPad)

            .textFieldStyle(.roundedBorder)

            Text("-")

            TextField(

                "Max",

                text: $maximum

            )

            .keyboardType(.numberPad)

            .textFieldStyle(.roundedBorder)

        }

    }

}

#Preview {
    PriceRangeInput(minimum: .constant("0"), maximum: .constant("100000"))
}
