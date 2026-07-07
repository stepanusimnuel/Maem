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
                    AppFont.headline()
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

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Tag")
                .font(AppFont.title2(weight: .bold))

            ForEach(
                DisplayTag.allCases,
                id: \.self
            ) { tag in

                FilterRow(

                    title: tag.title,

                    isSelected:
                        filter.tags.contains(tag)

                ) {

                    if filter.tags.contains(tag) {

                        filter.tags.remove(tag)

                    }

                    else {

                        filter.tags.insert(tag)

                    }

                }

            }

        }

    }

}

private extension FilterSheet {

    var allergenSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Alergen")
                .font(AppFont.title2(weight: .bold))

            ForEach(
                Allergen.allCases,
                id: \.self
            ) { allergen in

                FilterRow(

                    title: allergen.rawValue.capitalized,

                    isSelected:
                        filter.allergens.contains(allergen)

                ) {

                    if filter.allergens.contains(allergen) {

                        filter.allergens.remove(allergen)

                    }

                    else {

                        filter.allergens.insert(allergen)

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
                .font(AppFont.title2(weight: .bold))

            ForEach(
                PriceFilter.allCases,
                id: \.self
            ) { option in

                PriceOptionRow(

                    title: option.title,

                    isSelected:
                        filter.priceFilter == option

                ) {

                    filter.priceFilter = option

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

            Text("Harga Manual")
                .font(AppFont.title2(weight: .bold))

            PriceRangeInput(

                minimum: $filter.minimumPrice,

                maximum: $filter.maximumPrice

            )

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
                .font(AppFont.title2(weight: .bold))

            ForEach(
                FoodCategory.allCases
            ) { category in

                FoodCategoryRow(

                    category: category,

                    isSelected:
                        filter.category == category

                ) {

                    filter.category = category

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
