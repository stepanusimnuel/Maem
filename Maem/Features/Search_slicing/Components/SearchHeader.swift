//
//  SearchHeader.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct SearchHeader: View {

    @Binding var searchText: String

    var isEditable: Bool = true

    let onTap: (() -> Void)?

    let onSearch: () -> Void

    var body: some View {

        HStack(spacing: 8) {

            Image(systemName: "magnifyingglass")
                .font(AppFont.headline(weight: .medium))

            if isEditable {

                TextField(
                    "makanan untuk anak radang",
                    text: $searchText
                )
                .font(AppFont.caption(weight: .medium))
                .foregroundStyle(AppColor.neutralMedGrey)
                .onSubmit {
                    onSearch()
                }

            } else {

                Text(searchText.isEmpty
                     ? "makanan untuk anak radang"
                     : searchText)
                    .font(AppFont.caption(weight: .medium))
                    .foregroundStyle(AppColor.neutralMedGrey)

                Spacer()
            }

        }
        .padding()
        .frame(height: 48)
        .overlay(
            Capsule()
                .stroke(
                    LinearGradient(
                        colors: [AppColor.red700, AppColor.blue500],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
        )
        .glassEffect(.clear)
        .shadow(
            color: Color.blue500.opacity(0.12),
            radius: 16,
            x: 0,
            y: 8
        )
        .contentShape(Rectangle())
        .onTapGesture {

            guard !isEditable else { return }

            onTap?()

        }

    }

}

#Preview {
    NavigationStack {
        SearchHeader(searchText: .constant("Hello"), onTap: {}, onSearch: {})
    }
}
