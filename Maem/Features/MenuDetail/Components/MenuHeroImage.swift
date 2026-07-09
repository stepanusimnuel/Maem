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
        .frame(width: .infinity, height: 340)
        .clipped()

    }

}
