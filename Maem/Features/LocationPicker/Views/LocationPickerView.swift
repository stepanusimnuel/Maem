//
//  LocationPickerView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI

struct LocationPickerView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var searchText = ""

    let foodCourts: [FoodCourtDistance]

    let onSelect: (FoodCourtDistance) -> Void

    var body: some View {

        List {

            Section("Nearby") {

                ForEach(filtered.prefix(3), id: \.foodCourt.id) { foodCourt in

                    Button {

                        onSelect(foodCourt)
                        dismiss()

                    } label: {

                        FoodCourtRow(foodCourt: foodCourt)

                    }
                    .buttonStyle(.plain)

                }

            }

            Section("All Food Courts") {

                ForEach(filtered, id: \.foodCourt.id) { foodCourt in

                    Button {

                        onSelect(foodCourt)
                        dismiss()

                    } label: {

                        FoodCourtRow(foodCourt: foodCourt)

                    }
                    .buttonStyle(.plain)

                }

            }

        }
        .searchable(
            text: $searchText,
            prompt: "Search food court"
        )
        .navigationTitle("Choose Food Court")
        .navigationBarTitleDisplayMode(.inline)

    }

    private var filtered: [FoodCourtDistance] {

        guard !searchText.isEmpty else {
            return foodCourts
        }

        return foodCourts.filter {

            $0.foodCourt.name.localizedCaseInsensitiveContains(searchText)

        }

    }

}

#Preview {

    NavigationStack {

        LocationPickerView(foodCourts: [], onSelect: {_ in })

    }
}
