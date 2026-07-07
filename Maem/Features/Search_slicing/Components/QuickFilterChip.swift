//
//  QuickFilterChip.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct QuickFilterChip: View {

    var title: String?

    var systemImage: String?
    
    var isSelected: Bool


    let action: () -> Void

    var body: some View {

        Button {

            action()

        } label: {

            HStack(spacing: 6) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                if let title {
                    Text(title)
                }
            }
            .font(AppFont.callout(weight: .regular))
            .foregroundStyle(
                isSelected
                ? AppColor.neutralWhite
                : AppColor.red700
            )
            .padding(.horizontal, 10)
            .frame(height: 36)
            .background(
                isSelected
                ? AppColor.red700
                : AppColor.red100
            )
            .clipShape(Capsule())

        }
        .buttonStyle(.plain)

    }

}


#Preview {
    QuickFilterChip(title: "Test", isSelected: false, action: {})
}
