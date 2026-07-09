//
//  ForAllSection.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct ForAllSection: View {

    let menus: [Menu]
    
    var onBookmarkToggled: (Menu) -> Void

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            HStack(alignment: .center, spacing: 3) {
                Text("Untuk Semua")
                    .font(
                        AppFont.title2(weight: .bold)
                    )
                    
                
                Image(systemName: "chevron.right")
                    .font(
                        AppFont.body(weight: .bold)
                    )
                    
            }
            .padding(.horizontal)
            .foregroundStyle(AppColor.red700)

            LazyVStack(spacing: 16) {

                ForEach(menus) { menu in

                    NavigationLink {

                        MenuDetailView(
                            menu: menu
                        )

                    } label: {

                        MenuListCard(
                            menu: menu
                        ) {
                            onBookmarkToggled(menu)
                        }

                    }
                    .buttonStyle(.plain)

                }

            }
            .padding(.horizontal)

        }
        .background(Color.clear)

    }

}
