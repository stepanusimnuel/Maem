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
    
    let locationManager: LocationManager
    
    @State private var showAlert = false
    
    @State private var isShowingLocationPicker = false

    var body: some View {

        ZStack {
            ScrollView {

                VStack(alignment: .leading, spacing: 15) {
                    
                    CurrentLocationCard(
                        selectedFoodCourt: viewModel.selectedFoodCourt,
                        currentLocation: locationManager.currentLocation,
                        authorizationStatus: locationManager.authorizationStatus,
                        onLocationButtonTapped: {
                            isShowingLocationPicker = true
                        }
                    )
                    .padding(.top, 64)
                    .padding(.horizontal)
                    
                    if let selectedFoodCourt = viewModel.selectedFoodCourt {
                        
                        NavigationLink {
                            
                            SearchSlicingView(
                                
                                selectedFoodCourt: selectedFoodCourt.foodCourt
                                
                            )
                            
                        } label: {
                            
                            HStack(spacing: 8) {
                                Image(systemName: "magnifyingglass")
                                    .font(AppFont.headline(weight: .medium))
                                
                                Text("makanan untuk anak radang")
                                    .font(AppFont.caption(weight: .medium))
                                    .foregroundStyle(AppColor.neutralMedGrey)
                                
                                Spacer()
                            }
                            .padding()
                            .frame(height: 48)
                            .overlay(
                                Capsule()
                                    .stroke(
                                        LinearGradient(
                                            colors: [AppColor.red700, AppColor.blue500],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                            .padding(.horizontal)
                            .shadow(
                                color: Color.blue500.opacity(0.12),
                                radius: 16,
                                x: 0,
                                y: 8
                            )
                            
                        }
                        .buttonStyle(.plain)
                    }
                    
                    if let selectedFoodCourt = viewModel.selectedFoodCourt {

                        NavigationLink {

                            ResultView(
                                mode: .kids,
                                foodCourt: selectedFoodCourt.foodCourt
                            )

                        } label: {

                            ForKidsSection(
                                menus: viewModel.forKidsMenus
                            ) { clickedMenu in

                                clickedMenu.isBookmarked.toggle()

                                if clickedMenu.isBookmarked {

                                    withAnimation(.spring()) {

                                        showAlert = true

                                    }

                                }

                            }
                            .frame(maxWidth: .infinity, maxHeight: 320)
                            .padding(.leading, 4)

                        }
                        .padding(.horizontal)
                        
                        NavigationLink {

                            ResultView(

                                mode: .all,

                                foodCourt: viewModel.selectedFoodCourt!.foodCourt

                            )

                        } label: {
                            ForAllSection(

                                menus: viewModel.forAllMenus

                            ) { menu in
                                menu.isBookmarked.toggle()
                                if menu.isBookmarked {
                                    withAnimation(.spring()) {
                                        showAlert = true
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                    }
                }

            }
            .task {

                let repository = FoodCourtRepository(
                    context: modelContext
                )

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
            
            .scrollIndicators(.hidden)
            
            .fullScreenCover(isPresented: $isShowingLocationPicker) {

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
            
            .background(AppColor.neutralWhite)
            
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

#Preview {

    NavigationStack {

        ExploreView(locationManager: LocationManager())

    }

}
