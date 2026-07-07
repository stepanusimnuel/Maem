//
//  RecentSearchChip.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct RecentSearchChip: View {
    
    var history: String = "History"
    
    var body: some View {
        HStack {

            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                .foregroundStyle(AppColor.neutralDarkGrey)

            Text(history)
                .font(AppFont.callout(weight: .regular))
                .foregroundStyle(AppColor.red700)
                .lineLimit(1)

            Spacer()

        }
    }
}

#Preview {
    RecentSearchChip()
}
