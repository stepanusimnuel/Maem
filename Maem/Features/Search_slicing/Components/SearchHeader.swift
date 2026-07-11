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

        HStack(spacing: 4) {

            Image(systemName: "magnifyingglass")
                .font(AppFont.body(weight: .medium))

            if isEditable {

                // TextField's .foregroundStyle colors the placeholder AND the
                // typed text the same - overlaying a separately-styled
                // placeholder is the only way to keep the placeholder muted
                // while typed input stays clearly legible.
                ZStack(alignment: .leading) {

                    if searchText.isEmpty {
                        Text("makanan untuk anak radang")
                            .font(AppFont.caption(weight: .medium))
                            .foregroundStyle(AppColor.neutralMedGrey)
                    }

                    TextField(
                        "",
                        text: $searchText
                    )
                    .font(AppFont.caption(weight: .medium))
                    .foregroundStyle(AppColor.neutralBlack)
                    .onSubmit {
                        onSearch()
                    }

                }

            } else {

                Text(searchText.isEmpty
                     ? "makanan untuk anak radang"
                     : searchText)
                    .font(AppFont.caption(weight: .medium))
                    .foregroundStyle(searchText.isEmpty ? AppColor.neutralMedGrey : AppColor.neutralBlack)

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
        .background(AppColor.neutralWhite)
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
