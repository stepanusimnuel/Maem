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


    @State private var searchText = ""

    let foodCourts: [FoodCourtDistance]
    let selectedFoodCourt: FoodCourtDistance?
    let onSelect: (FoodCourtDistance) -> Void

    var body: some View {

        VStack(spacing: 20) {

            header

            VStack (spacing: 24) {
                searchField

                ScrollView {

                    LazyVStack(alignment:.leading, spacing: 16) {
                        
                        Text("Terdekat dari lokasimu")
                            .font(AppFont.body(weight: .semibold))

                        ForEach(filteredFoodCourts) { foodCourt in

                            Button {

                                onSelect(foodCourt)
                                dismiss()

                            } label: {

                                FoodCourtCard(
                                    foodCourt: foodCourt,
                                    isSelected: selectedFoodCourt?.id == foodCourt.id
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 24, x: 0, y: 8)

                            }
                            .buttonStyle(.plain)

                        }

                    }
                    .padding(.horizontal)

                }
            }

        }
        .padding(.top)
        .background(AppColor.neutralWhite)

    }

}

private extension LocationPickerView {

    var header: some View {

        ZStack {
            Text("Pilih Lokasi")
                .font(AppFont.body(weight: .bold))
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(AppFont.title2(weight: .medium))
                        .frame(width: 44, height: 44)
                        .glassEffect()
                        .foregroundStyle(AppColor.red700)
                }
                .clipShape(Circle())
                
                Spacer()
            }
        }
        .padding(.horizontal)


    }

}

private extension LocationPickerView {

    var searchField: some View {

        HStack(spacing: 8) {

            Image(systemName: "magnifyingglass")
                .font(AppFont.headline(weight: .medium))

            TextField(
                "cari food court",
                text: $searchText
            )

        }
        .font(AppFont.callout(weight: .medium))
        .padding(.horizontal, 12)
        .frame(height: 44)
        .glassEffect(in: .capsule)
        .padding(.horizontal)

    }

}

private extension LocationPickerView {

    var filteredFoodCourts: [FoodCourtDistance] {

        if searchText.isEmpty {
            return foodCourts
        }

        return foodCourts.filter {

            $0.foodCourt.name.localizedCaseInsensitiveContains(searchText)

        }

    }

}
