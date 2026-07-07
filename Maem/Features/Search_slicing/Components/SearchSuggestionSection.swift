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

            VStack(spacing: 8) {

                ForEach(
                    suggestions,
                    id: \.self
                ) { suggestion in

                    Button {

                       onSelect(suggestion)

                    } label: {

                        HStack {

                            Text("•")
                                .font(AppFont.title2(weight: .bold))
                                .foregroundStyle(AppColor.red700)

                            Text(suggestion)
                                .lineLimit(1)
                                .font(AppFont.body(weight: .regular))
                                .foregroundStyle(AppColor.red700)

                            Spacer()

                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(AppColor.neutralDarkGrey)

                        }

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

}
