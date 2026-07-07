//
//  FilterRow.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct FilterRow: View {

    let title: String

    let isSelected: Bool

    let action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            HStack {

                Text(title)

                Spacer()

                Image(

                    systemName:

                    isSelected

                    ? "checkmark.circle.fill"

                    : "circle"

                )
                .foregroundStyle(

                    isSelected

                    ? AppColor.red700

                    : AppColor.neutralSystemGrey

                )

            }

            .frame(height: 48)

        }

        .buttonStyle(.plain)

    }

}
#Preview {
    FilterRow(title: "Judul", isSelected: true, action: {})
}
