//
//  ExploreView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI
import SwiftData

struct ExploreView: View {

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel = ExploreViewModel()

    @State
    private var locationManager = LocationManager()

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                CurrentLocationCard(
                    selectedFoodCourt: viewModel.selectedFoodCourt,
                    currentLocation: locationManager.currentLocation,
                    authorizationStatus: locationManager.authorizationStatus
                )

                NavigationLink {

                    LocationPickerView(
                        foodCourts: viewModel.foodCourtsByDistance
                    ) { selectedFoodCourt in

                        viewModel.selectFoodCourt(selectedFoodCourt)

                    }

                } label: {

                    Label(
                        "Change Location",
                        systemImage: "location.circle"
                    )
                    .frame(maxWidth: .infinity)

                }
                .buttonStyle(.borderedProminent)

                placeholderSection(
                    title: "Search Menu",
                    icon: "magnifyingglass"
                )

                placeholderSection(
                    title: "Kids Friendly",
                    icon: "figure.and.child.holdinghands"
                )

                placeholderSection(
                    title: "Other Menus",
                    icon: "fork.knife"
                )

            }
            .padding()

        }
        .navigationTitle("Explore")
        .task {

            let repository = FoodCourtRepository(
                context: modelContext
            )

            locationManager.requestLocationPermission()

            viewModel.load(
                repository: repository,
                currentLocation: locationManager.currentLocation
            )

        }
        .onChange(of: locationManager.currentLocation) { _, newLocation in

            guard viewModel.selectedFoodCourt == nil else {
                return
            }

            let repository = FoodCourtRepository(
                context: modelContext
            )

            viewModel.load(
                repository: repository,
                currentLocation: newLocation
            )

        }

    }

    @ViewBuilder
    private func placeholderSection(
        title: String,
        icon: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 8) {

            Label(title, systemImage: icon)
                .font(.headline)

            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.1))
                .frame(height: 100)
                .overlay {

                    Text("Coming Soon")
                        .foregroundStyle(.secondary)

                }

        }

    }

}

#Preview {

    NavigationStack {

        ExploreView()

    }

}
