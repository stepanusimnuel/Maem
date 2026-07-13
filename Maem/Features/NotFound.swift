//
//  MenuNotFound.swift
//  Maem
//
//  Created by Stepanus Imanuel on 07/07/26.
//

import SwiftUI

struct NotFound: View {
    let title: String
    let subtitle: String
    var suggestions: [Menu] = []
    var onBookmarkToggled: (Menu) -> Void = { _ in }

    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 7) {
                Image("menu-not-found")
                    .resizable()
                    .frame(width: 122, height: 86)
                Text(title)
                    .font(AppFont.body(weight: .bold))
                Text(subtitle)
                    .font(AppFont.callout())
            }
            .foregroundStyle(AppColor.neutralBlack)

            if !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Menu Serupa")
                        .font(AppFont.body(weight: .bold))
                    ForEach(suggestions) { menu in
                        NavigationLink {
                            MenuDetailView(menu: menu)
                        } label: {
                            MenuListCard(menu: menu) { tappedMenu in
                                onBookmarkToggled(tappedMenu)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

#Preview("Empty, no suggestions") {
    NotFound(title: "Test", subtitle: "Test")
}

#Preview("With suggestions") {
    NotFound(
        title: "Yah, menu ngga ketemu.",
        subtitle: "Coba menu lainnya, yuk!",
        suggestions: []
    )
}
