//
//  MainTabView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {

        TabView {

            NavigationStack {
                ExploreView()
            }
                .tabItem {

                    Label(
                        "Jelajah",
                        systemImage: "magnifyingglass"
                    )

                }

            NavigationStack {
                BookmarkView()
            }
                .tabItem {

                    Label(
                        "Tersimpan",
                        systemImage: "bookmark"
                    )

                }

        }
        .tint(AppColor.red700)

    }

}

#Preview {

    MainTabView()

}
