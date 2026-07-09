//
//  FilterSheet.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct FilterSheet: View {

    @Environment(\.dismiss)
    private var dismiss

    @Binding
    var filter: SearchFilter
    
    let onApply: () -> Void

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 32
                ) {

                    tagSection

                    allergenSection

                    priceSection

                    manualPriceSection

                    categorySection

                }
                .padding()

            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                toolbar

            }
            .background(AppColor.red50)

        }

    }

}

private extension FilterSheet {

    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {

        ToolbarItem(
            placement: .topBarLeading
        ) {

            Button {

                dismiss()

            } label: {

                Image(systemName: "xmark")
                    .font(AppFont.caption(weight: .bold))
                    .foregroundStyle(AppColor.red700)
                    .frame(width: 12, height: 12)

            }
            .buttonStyle(.glass)
            .clipShape(Circle())

        }

        ToolbarItem(
            placement: .principal
        ) {

            Text("Filter")
                .font(
                    AppFont.body(weight: .bold)
                )

        }

        ToolbarItem(
            placement: .topBarTrailing
        ) {

            Button {

                onApply()
                dismiss()

            } label: {

                Image(systemName: "checkmark")
                    .font(AppFont.caption(weight: .bold))
                    .foregroundStyle(AppColor.red700)
                    .frame(width: 12, height: 12)

            }
            .buttonStyle(.glass)
            .clipShape(Circle())

        }

    }

}

private extension FilterSheet {

    var tagSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tags")
                .font(AppFont.body(weight: .bold))

            FlowLayout(spacing: 12) {
                ForEach([DisplayTag.isInstant, .spicy, .kidsPortion], id: \.self) { tag in
                    let isSelected = filter.tags.contains(tag)
                    FilterChip(title: tag.title, isSelected: isSelected) {
                        if isSelected {
                            filter.tags.remove(tag)
                        } else {
                            filter.tags.insert(tag)
                        }
                    }
                }
            }
        }
    }

}

private extension FilterSheet {

    var allergenSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Alergen")
                .font(AppFont.body(weight: .bold))

            FlowLayout(spacing: 12) {
                ForEach(Allergen.allCases, id: \.self) { allergen in
                    let isSelected = filter.allergens.contains(allergen)
                    FilterChip(title: allergen.rawValue.capitalized, isSelected: isSelected) {
                        if isSelected {
                            filter.allergens.remove(allergen)
                        } else {
                            filter.allergens.insert(allergen)
                        }
                    }
                }
            }
        }
    }

}


private extension FilterSheet {

    var priceSection: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            Text("Harga")
                .font(AppFont.body(weight: .bold))

            FlowLayout(spacing: 12) {
                ForEach(PriceFilter.allCases, id: \.self) { option in
                    let isSelected = filter.priceFilter == option
                    
                    FilterChip(title: option.title, isSelected: isSelected) {
                        if isSelected {
                            filter.priceFilter = nil
                        } else {
                            filter.priceFilter = option
                        }
                    }
                }
            }
        }
    }

}

private extension FilterSheet {

    var manualPriceSection: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            HStack(spacing: 16) {
                CustomPriceField(label: "Min", text: $filter.minimumPrice)
                CustomPriceField(label: "Max", text: $filter.maximumPrice)
            }
        }
        .padding(.horizontal)
    }

}

struct CustomPriceField: View {
    let label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(AppFont.callout(weight: .regular))
                .foregroundStyle(AppColor.neutralBlack)
            
            Rectangle()
                .fill(AppColor.neutralSystemGrey.opacity(0.3))
                .frame(height: 1)
            
            VStack(spacing: 0) {
                TextField("0", text: $text)
                    .keyboardType(.numberPad)
                    .font(AppFont.body())
                    .frame(height: 48)
            }
        }
    }
}

private extension FilterSheet {

    var categorySection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Jenis Makanan")
                .font(AppFont.body(weight: .bold))
            
            FilterRow(
                title: "Semua makanan",
                isSelected: filter.category == nil
            ) {
                filter.category = nil
            }

            ForEach(FoodCategory.allCases) { category in

                FilterRow(
                    title: category.title,
                    isSelected: filter.category == category
                ) {
                    if filter.category == category {
                        filter.category = nil
                    } else {
                        filter.category = category
                    }
                }

            }

        }

    }

}




#Preview {

    @Previewable
    @State var filter = SearchFilter()

    FilterSheet(

        filter: $filter

    ) {

    }

}
