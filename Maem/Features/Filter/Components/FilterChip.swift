//
//  FilterChip.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import SwiftUI

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.body(weight: .regular))
                .lineLimit(1)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .foregroundStyle(isSelected ? AppColor.neutralWhite : AppColor.red700)
                .background(isSelected ? AppColor.red700 : AppColor.red100)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(lineWidth: 1)
                        .foregroundStyle(AppColor.red700)
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FilterChip(title: "test", isSelected: true, action: {})
}
