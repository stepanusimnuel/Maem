//
//  SearchSuggestionChip.swift
//  Maem
//
//  Created by Stepanus Imanuel on 10/07/26.
//

import SwiftUI

struct SearchSuggestionChip: View {

    let title: String

    let action: () -> Void

    var body: some View {

        Button(action: action) {

            HStack(spacing: 8) {

                Text(title)
                    .font(AppFont.caption(weight: .medium))
                    .foregroundStyle(AppColor.neutralBlack)

            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay(
                Capsule()
                    .stroke(
                        LinearGradient(
                            colors: [
                                AppColor.red700,
                                AppColor.blue500
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            )
            .shadow(
                color: Color.blue500.opacity(0.12),
                radius: 16,
                x: 0,
                y: 8
            )

        }
        .buttonStyle(.plain)

    }

}

#Preview {
    SearchSuggestionChip(title: "Test", action: {})
}
