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

    var inferredTags: Set<DisplayTag> = []

    var inferredCookMethod: CookMethod? = nil

    let onApply: () -> Void

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 32
                ) {

                    tagSection

                    cookMethodSection

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
            .background(AppColor.neutralWhite)

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
                    .font(AppFont.headline(weight: .medium))
                    .foregroundStyle(AppColor.red700)
                    .clipShape(Circle())

            }

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
                    .font(AppFont.headline(weight: .medium))
                    .foregroundStyle(AppColor.red700)
                    .clipShape(Circle())

            }

        }

    }

}

private extension FilterSheet {

    var tagSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tags")
                .font(AppFont.body(weight: .bold))

            FlowLayout(spacing: 10) {
                ForEach([DisplayTag.isInstant, .spicy, .notSpicy, .kidsPortion, .halal, .healthy], id: \.self) { tag in
                    let isSelected = isEffectivelyOn(tag)
                    FilterChip(title: tag.title, isSelected: isSelected) {
                        toggle(tag)
                    }
                }
            }
        }
    }

    /// A chip is on if the user explicitly selected it, or if the text parser
    /// implied it and the user hasn't explicitly excluded it. `excludedTags`
    /// always wins, even over an inferred tag, per the design spec's tri-state
    /// model (Section 2).
    func isEffectivelyOn(_ tag: DisplayTag) -> Bool {
        if filter.excludedTags.contains(tag) { return false }
        return filter.selectedTags.contains(tag) || inferredTags.contains(tag)
    }

    /// Tapping always flips explicit intent: on (however it got there) -> move
    /// to excludedTags; off -> move to selectedTags. Applies uniformly to every
    /// tag including safety ones (requireHalal/forKid/mustNotSpicy) — per the
    /// design spec's Section 3, the user chose "keep tappable anyway" over
    /// disabling the tap; the resulting excludedTags membership is a real UI
    /// state, it's SearchIntent.merged(withManual:) that makes it a no-op for
    /// those specific fields, not this function.
    func toggle(_ tag: DisplayTag) {
        if isEffectivelyOn(tag) {
            filter.selectedTags.remove(tag)
            filter.excludedTags.insert(tag)
        } else {
            filter.excludedTags.remove(tag)
            filter.selectedTags.insert(tag)
        }
    }

}

private extension FilterSheet {

    var cookMethodSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Cara Masak")
                .font(AppFont.body(weight: .bold))

            FlowLayout(spacing: 10) {
                ForEach(CookMethod.allCases.filter { $0 != .other }, id: \.self) { method in
                    let isSelected = effectiveCookMethod == method
                    FilterChip(title: method.rawValue, isSelected: isSelected) {
                        if isSelected {
                            filter.cookMethod = .cleared
                        } else {
                            filter.cookMethod = .value(method)
                        }
                    }
                }
            }
        }
    }

    /// Resolves the same way toSearchIntent(inferred:) resolves cookMethod,
    /// so the chip the user sees matches what the next search will actually
    /// filter on: .unset defers to whatever the last submitted query implied,
    /// .cleared shows nothing selected, .value shows that exact choice.
    var effectiveCookMethod: CookMethod? {
        switch filter.cookMethod {
        case .unset:
            return inferredCookMethod
        case .cleared:
            return nil
        case .value(let method):
            return method
        }
    }

}

private extension FilterSheet {

    var allergenSection: some View {
        VStack(alignment: .leading, spacing: 10) {
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

#Preview("With Inferred Tags") {

    @Previewable
    @State var filter = SearchFilter()

    FilterSheet(

        filter: $filter,
        inferredTags: [.halal, .notSpicy],
        inferredCookMethod: .fried

    ) {

    }

}
