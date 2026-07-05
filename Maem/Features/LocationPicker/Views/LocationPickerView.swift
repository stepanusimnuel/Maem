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

            searchField

            ScrollView {

                LazyVStack(spacing: 12) {

                    ForEach(filteredFoodCourts) { foodCourt in

                        Button {

                            onSelect(foodCourt)
                            dismiss()

                        } label: {

                            FoodCourtCard(
                                foodCourt: foodCourt,
                                isSelected: selectedFoodCourt?.id == foodCourt.id
                            )

                        }
                        .buttonStyle(.plain)

                    }

                }
                .padding(.horizontal)

            }

        }
        .padding(.top)
        .background(AppColor.red50)

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
                        .foregroundStyle(Color(#colorLiteral(red: 0.4470588235, green: 0.4470588235, blue: 0.4470588235, alpha: 1)))
                }
                .background(Color(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.5019607843, alpha: 1)).opacity(0.16))
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
