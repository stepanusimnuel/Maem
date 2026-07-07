//
//  RecentSearchSection.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct RecentSearchSection: View {

    let histories: [String]

    let onSelect: (String) -> Void

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            Text("Pencarian Terbaru")
                .font(AppFont.body(weight: .bold))

            VStack(spacing: 10) {

                ForEach(histories, id: \.self) { history in

                    Button {

                        onSelect(history)

                    } label: {

                        RecentSearchChip(
                            history: history
                        )

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

}

#Preview {
    RecentSearchSection(
        histories: ["Makanan untuk bayi"],
        onSelect: {_ in }
    )
}
