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
    
    @State private var showAlert = false
    
    @State private var isShowingLocationPicker = false

    var body: some View {

        NavigationStack {
            ZStack {
                ScrollView {

                    VStack(alignment: .leading, spacing: 10) {

                        CurrentLocationCard(
                            selectedFoodCourt: viewModel.selectedFoodCourt,
                            currentLocation: locationManager.currentLocation,
                            authorizationStatus: locationManager.authorizationStatus,
                            onLocationButtonTapped: {
                                isShowingLocationPicker = true
                            }
                        )
                        .padding(.top, 56)
                        
                        if let selectedFoodCourt = viewModel.selectedFoodCourt {
                            
                            NavigationLink {
                                
                                SearchSlicingView(
                                    
                                    selectedFoodCourt: selectedFoodCourt.foodCourt
                                    
                                )
                                
                            } label: {
                                
                                HStack(spacing: 8) {
                                    
                                    Image(systemName: "magnifyingglass")
                                    
                                    Text("makanan untuk anak radang")
                                        .font(AppFont.callout(weight: .medium))
                                        .foregroundStyle(AppColor.neutralSystemGrey)
                                    
                                    Spacer()
                                    
                                }
                                .padding(.horizontal, 10)
                                .frame(height: 44)
                                .glassEffect(in: .capsule)
                                
                            }
                            .buttonStyle(.plain)
                        }
                        
                        
                        ForKidsSection(
                            menus: viewModel.forKidsMenus
                        )
                        .frame(maxWidth: .infinity, maxHeight: 320)
                        .padding(.leading, 4)
                        
                        ForAllSection(

                            menus: viewModel.menus

                        ) { menu in
                            if menu.isBookmarked {
                                withAnimation(.spring()) {
                                    showAlert = true
                                }
                            }
                        }

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
                
                .scrollIndicators(.hidden)
                
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
                
                if showAlert {
                    VStack {
                        SaveSuccessAlert(isPresented: $showAlert)
                            .padding(.top, 16)
                        Spacer()
                    }
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(100)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    showAlert = false
                                }
                            }
                        }
                }
            }
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
