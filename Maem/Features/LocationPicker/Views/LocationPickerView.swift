//
//  LocationPickerView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI

struct LocationPickerView: View {

    enum DisplayMode: String, CaseIterable {
        case list = "List"
        case map = "Map"
    }

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var searchText = ""

    @State
    private var displayMode: DisplayMode = .list

    let foodCourts: [FoodCourtDistance]

    let onSelect: (FoodCourtDistance) -> Void

    var body: some View {

        VStack(spacing: 0) {

            Picker(
                "Display Mode",
                selection: $displayMode
            ) {

                ForEach(DisplayMode.allCases, id: \.self) { mode in

                    Text(mode.rawValue)
                        .tag(mode)

                }

            }
            .pickerStyle(.segmented)
            .padding()

            switch displayMode {

            case .list:

                listView

            case .map:

                LocationMapView(
                    foodCourts: filteredFoodCourts
                ) { selected in

                    onSelect(selected)
                    dismiss()

                }

            }

        }
        .navigationTitle("Choose Food Court")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $searchText,
            prompt: "Search food court"
        )

    }

}

// MARK: - List View

private extension LocationPickerView {

    var listView: some View {

        List {

            if !filteredFoodCourts.isEmpty {

                Section("Nearby") {

                    ForEach(filteredFoodCourts.prefix(3)) { foodCourt in

                        Button {

                            onSelect(foodCourt)
                            dismiss()

                        } label: {

                            FoodCourtRow(
                                foodCourt: foodCourt
                            )

                        }
                        .buttonStyle(.plain)

                    }

                }

            }

            Section("All Food Courts") {

                ForEach(filteredFoodCourts) { foodCourt in

                    Button {

                        onSelect(foodCourt)
                        dismiss()

                    } label: {

                        FoodCourtRow(
                            foodCourt: foodCourt
                        )

                    }
                    .buttonStyle(.plain)

                }

            }

        }
        .listStyle(.insetGrouped)

    }

}

// MARK: - Search

private extension LocationPickerView {

    var filteredFoodCourts: [FoodCourtDistance] {

        guard !searchText.isEmpty else {
            return foodCourts
        }

        return foodCourts.filter {

            $0.foodCourt.name.localizedCaseInsensitiveContains(
                searchText
            )

        }

    }

}

#Preview {

    NavigationStack {

        LocationPickerView(
            foodCourts: [
                FoodCourtDistance(
                    foodCourt: FoodCourt(
                        name: "AEON Mall BSD - Food Culture",
                        address: "AEON Mall BSD",
                        floor: "Ground",
                        latitude: 0,
                        longitude: 0
                    ),
                    distance: 182
                ),
                FoodCourtDistance(
                    foodCourt: FoodCourt(
                        name: "ITC BSD Food Court",
                        address: "ITC BSD",
                        floor: "2",
                        latitude: 0,
                        longitude: 0
                    ),
                    distance: 430
                )
            ]
        ) { _ in

        }

    }

}

#Preview {

    NavigationStack {

        LocationPickerView(foodCourts: [], onSelect: {_ in })

    }
}
