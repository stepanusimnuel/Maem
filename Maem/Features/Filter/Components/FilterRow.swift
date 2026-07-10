//
//  FilterRow.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct FilterRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                HStack {
                    Text(title)
                        .font(AppFont.body())
                        .foregroundStyle(AppColor.neutralBlack)

                    Spacer()

                    ZStack {
                        Circle()
                            .stroke(
                                isSelected ? AppColor.red700 : AppColor.neutralSystemGrey.opacity(0.6),
                                lineWidth: 2
                            )
                            .frame(width: 19, height: 19)
                        
                        if isSelected {
                            Circle()
                                .fill(AppColor.red700)
                                .frame(width: 14, height: 14)
                        }
                    }
                }
                .frame(height: 48)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            
            Divider()
                .background(AppColor.neutralSystemGrey)
        }

    }
}

#Preview {
    FilterRow(title: "Judul", isSelected: true, action: {})
}
