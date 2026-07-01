//
//  LocationMapsView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI
import MapKit

struct LocationMapView: View {

    @State
    private var cameraPosition: MapCameraPosition

    @State
    private var selectedFoodCourt: FoodCourtDistance?

    let foodCourts: [FoodCourtDistance]

    let onSelect: (FoodCourtDistance) -> Void

    init(
        foodCourts: [FoodCourtDistance],
        onSelect: @escaping (FoodCourtDistance) -> Void
    ) {

        self.foodCourts = foodCourts
        self.onSelect = onSelect

        if let first = foodCourts.first {

            _cameraPosition = State(
                initialValue: .region(
                    MKCoordinateRegion(
                        center: first.foodCourt.coordinate,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.02,
                            longitudeDelta: 0.02
                        )
                    )
                )
            )

        } else {

            _cameraPosition = State(
                initialValue: .automatic
            )

        }

    }

    var body: some View {

        ZStack(alignment: .bottom) {

            Map(position: $cameraPosition) {

                ForEach(foodCourts) { foodCourt in

                    Annotation(
                        foodCourt.foodCourt.name,
                        coordinate: foodCourt.foodCourt.coordinate
                    ) {

                        Button {

                            selectedFoodCourt = foodCourt

                        } label: {

                            VStack(spacing: 4) {

                                Image(systemName: "fork.knife.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(
                                        selectedFoodCourt?.id == foodCourt.id
                                        ? .orange
                                        : .red
                                    )

                                Circle()
                                    .fill(.white)
                                    .frame(width: 8, height: 8)

                            }

                        }
                        .buttonStyle(.plain)

                    }

                }

            }

            if let selectedFoodCourt {

                SelectedFoodCourtCard(
                    foodCourt: selectedFoodCourt
                ) {

                    onSelect(selectedFoodCourt)

                }
                .padding()

            }

        }

    }

}

#Preview {

    NavigationStack {

        LocationMapView(
            foodCourts: []
        ) { _ in

        }

    }

}
