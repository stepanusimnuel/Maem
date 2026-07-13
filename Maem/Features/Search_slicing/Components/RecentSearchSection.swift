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
                    FlowLayout() {
                        ForEach(histories) { history in
                            Button {
                                onHistoryTapped(history.text)
                            } label: {
                                HStack(spacing: 4) {
                                    Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                                        .font(AppFont.caption())
                                        .foregroundStyle(AppColor.neutralDarkGrey)
                                    
                                    Text(history.text)
                                        .font(AppFont.caption(weight: .regular))
                                        .lineLimit(1)
                                        .foregroundStyle(AppColor.red700)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .foregroundStyle(AppColor.neutralBlack)
                                .background(AppColor.red100)
                                .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(maxHeight: 95, alignment: .topLeading)
                .clipped()
            }
        }
    }
}

#Preview {
    RecentSearchSection(
        histories: [SearchHistory(text: "snack gluten free", timestamp: Date())],
        onHistoryTapped: {_ in }
    )
}
