//
//  SearchSuggestionSection.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct SearchSuggestionSection: View {

    let suggestions: [String]

    let onSelect: (String) -> Void

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            Text("Kamu bisa coba")
                .font(AppFont.body(weight: .bold))
                .foregroundStyle(AppColor.neutralBlack)

            FlowLayout(spacing: 12) {

                ForEach(suggestions, id: \.self) { suggestion in

                    SearchSuggestionChip(
                        title: suggestion
                    ) {
                        onSelect(suggestion)
                    }

                }

            }

        }

    }

}
