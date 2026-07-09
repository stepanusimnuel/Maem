//
//  MenuHeroImage.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct MenuHeroImage: View {

    let imageName: String?

    var body: some View {

        Group {

            if let imageName {

                Image(imageName)
                    .resizable()
                    .scaledToFill()

            }

            else {

                Rectangle()
                    .fill(
                        AppColor.red100
                    )

            }

        }
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20,
                topTrailingRadius: 0
            )
        )
        .frame(maxWidth: .infinity)
        .frame(height: 384)

    }

}
