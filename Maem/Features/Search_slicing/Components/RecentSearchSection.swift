//
//  RecentSearchSection.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct RecentSearchSection: View {
    let histories: [SearchHistory]
    let onHistoryTapped: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if !histories.isEmpty {
                Text("Pencarian Terbaru")
                    .font(AppFont.body(weight: .bold))
                
                VStack {
                    FlowLayout(spacing: 8) {
                        ForEach(histories) { history in
                            Button {
                                onHistoryTapped(history.text)
                            } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                                        .font(AppFont.caption2())
                                        .foregroundStyle(AppColor.neutralDarkGrey)
                                    
                                    Text(history.text)
                                        .font(AppFont.caption2(weight: .regular))
                                        .lineLimit(1)
                                        .foregroundStyle(AppColor.red700)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .foregroundStyle(AppColor.neutralBlack)
                                .background(AppColor.red100)
                                .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(maxHeight: 74, alignment: .topLeading)
                .clipped()
            }
        }
    }
}

#Preview {
    RecentSearchSection(
        histories: [SearchHistory(text: "Test", timestamp: Date())],
        onHistoryTapped: {_ in }
    )
}
