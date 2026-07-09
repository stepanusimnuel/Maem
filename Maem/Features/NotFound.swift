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
    
    var body: some View {
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
    }
}

#Preview {
    NotFound(title: "Test", subtitle: "Test")
}
