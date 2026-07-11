//
//  MainTabView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct MainTabView: View {

    let locationManager: LocationManager

    var body: some View {

        TabView {

            NavigationStack {
                ExploreView(
                    locationManager: locationManager
                )
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

                VStack {
                    Image(systemName: "bookmark")
                        .environment(\.symbolVariants, .none)

                    Text("Tersimpan")
                }

            }

        }

    }

}

#Preview {

    MainTabView(locationManager: LocationManager())

}
