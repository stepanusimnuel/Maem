//
//  FilterChip.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import SwiftUI

struct FilterChip: View {
    var title: String? = nil
    let isSelected: Bool
    var systemImage: String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            
            HStack {
                if systemImage != nil {
                    Image(systemName: systemImage ?? "")
                }
                
                if title != nil {
                    Text(title ?? "")
                        .lineLimit(1)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? AppColor.red100 : AppColor.neutralLightGrey)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(lineWidth: 1)
                    .foregroundStyle(isSelected ? AppColor.red700 : AppColor.neutralDarkGrey)
            )
            .foregroundStyle(isSelected ? AppColor.red700 : AppColor.neutralDarkGrey)
            .font(AppFont.body(weight: .regular))
            
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FilterChip(title: "Halal", isSelected: false, action: {})
}
