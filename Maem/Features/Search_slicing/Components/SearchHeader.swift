//
//  SearchHeader.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct SearchHeader: View {

    @Binding var searchText: String

    let onSearch: () -> Void

    var body: some View {

        HStack(spacing: 8) {

            Image(systemName: "magnifyingglass")

            TextField(
                "makanan untuk anak radang",
                text: $searchText
            )
            .font(AppFont.callout())
            .onSubmit {

                onSearch()

            }

        }
        .padding(.horizontal, 10)
        .frame(height: 44)
        .glassEffect(in: .capsule)

    }

}

#Preview {
    NavigationStack {
        SearchHeader(searchText: .constant("Hello"), onSearch: {})
    }
}
