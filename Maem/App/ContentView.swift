//
//  ContentView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI
import SwiftData
import CoreLocation

struct ContentView: View {

    @Environment(\.modelContext)
    private var modelContext

    @State private var locationManager = LocationManager()

    @State private var showSplash = true
    @State private var showFindingAnimation = false
    
    @State private var hasCompletedFirstAnimation = false
    @State private var locationResolved = false
    @State private var hasEnteredExplore = false

    var body: some View {

        ZStack {

            MainTabView(
                locationManager: locationManager
            )
                .opacity(showSplash || showFindingAnimation ? 0 : 1)

            if showSplash {
                SplashView()
                    .transition(.opacity)
            }

            if showFindingAnimation {
                FindFoodcourtAnimation {

                    hasCompletedFirstAnimation = true

                    checkCanEnterExplore()

                }
            }
        }
        .task {

            do {
                try DummySeeder.seedIfNeeded(context: modelContext)
            } catch {
                print(error.localizedDescription)
            }

            try? await Task.sleep(for: .seconds(1.8))

            withAnimation {
                showSplash = false
            }

            withAnimation {
                showFindingAnimation = true
            }

            locationManager.requestLocationPermission()

            Task {

                try? await Task.sleep(for: .seconds(10))

                if !locationResolved {

                    locationResolved = true

                    checkCanEnterExplore()

                }

            }

        }
        .onChange(of: locationManager.authorizationStatus) { _, status in

            print("Permission:", status)
            switch status {

            case .authorizedAlways,
                 .authorizedWhenInUse:

                withAnimation {
                    showFindingAnimation = true
                }

            case .denied, .restricted:

                locationResolved = true

                checkCanEnterExplore()

            default:
                break
            }

        }
        .onChange(of: locationManager.currentLocation) { _, location in

            guard location != nil else { return }
            print("Location:", location!)
            locationResolved = true

            checkCanEnterExplore()

        }

    }
    
    func checkCanEnterExplore() {

        guard !hasEnteredExplore else { return }

        guard locationResolved else { return }

        guard hasCompletedFirstAnimation else { return }

        hasEnteredExplore = true

        withAnimation(.easeInOut(duration: 0.35)) {

            showFindingAnimation = false

        }

    }
}

#Preview {

    ContentView().modelContainer(for: [FoodCourt.self, SearchHistory.self])

}
