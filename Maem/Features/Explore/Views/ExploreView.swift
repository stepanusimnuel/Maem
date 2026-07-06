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
    
    @State private var isShowingLocationPicker = false

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {

                CurrentLocationCard(
                    selectedFoodCourt: viewModel.selectedFoodCourt,
                    currentLocation: locationManager.currentLocation,
                    authorizationStatus: locationManager.authorizationStatus,
                    onLocationButtonTapped: {
                        isShowingLocationPicker = true
                    }
                )
                
                ForKidsSection(
                    menus: viewModel.forKidsMenus
                )
                .frame(maxWidth: .infinity, maxHeight: 320)
                .padding(.leading, 4)
                .padding(.vertical, 16)
                
                ForAllSection(

                    menus: viewModel.menus

                )

            }

        }
        .padding()
        .task {

            let repository = FoodCourtRepository(
                context: modelContext
            )

            locationManager.requestLocationPermission()

            viewModel.load(
                repository: repository,
                currentLocation: locationManager.currentLocation,
                context: modelContext
            )

        }
        .onChange(of: locationManager.currentLocation) { _, newLocation in

            guard !viewModel.isManualSelection else {
                return
            }

            let repository = FoodCourtRepository(
                context: modelContext
            )

            viewModel.load(
                repository: repository,
                currentLocation: newLocation,
                context: modelContext
            )

        }
        
        .background(
            AppColor.red50
        )
        
        .sheet(isPresented: $isShowingLocationPicker) {

            LocationPickerView(
                foodCourts: viewModel.foodCourtsByDistance,
                selectedFoodCourt: viewModel.selectedFoodCourt
            ) { selected in

                viewModel.selectFoodCourt(
                    selected,
                    context: modelContext
                )

            }
            .presentationDetents([.fraction(0.9)])
        }
        
        .ignoresSafeArea()

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
