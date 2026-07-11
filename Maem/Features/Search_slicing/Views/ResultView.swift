//
//  SearchResultView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI
import SwiftData

struct ResultView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel: ResultViewModel
    
    @State private var showAlert: Bool = false
    
    @State private var inlineTitle: String = ""
    
    private var isFilterActive: Bool {
        viewModel.activeFilterCount > 0
    }

    init(
        mode: MenuListMode,
        foodCourt: FoodCourt
    ) {
        _viewModel = State(
            initialValue: ResultViewModel(
                mode: mode,
                foodCourt: foodCourt
            )
        )
    }

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 15
            ) {
                
                if let t = viewModel.navigationTitle {
                    Text(t)
                        .font(AppFont.title2(weight: .bold))
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .global).minY) { _, minY in
                                        if minY < -20 {
                                            withAnimation {
                                                inlineTitle = t
                                            }
                                        } else {
                                            inlineTitle = ""
                                        }
                                    }
                            }
                        )
                }
                
                if viewModel.shouldShowQuickFilterSection {
                    quickFilterSection
                }

                resultSection

            }
            .padding()

        }
        .padding(.top, viewModel.navigationTitle == nil ? -28 : 0)
        .navigationTitle(inlineTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            if viewModel.shouldShowSearchHeader {

                ToolbarItem(placement: .principal) {

                    SearchHeader(
                        searchText: $viewModel.searchText,
                        isEditable: false,
                        onTap: {
                            dismiss()
                        }
                    ) {

                    }
                    .frame(width: 314, height: 44)

                }

            }

        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            
            let inlineAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                .foregroundColor: UIColor(AppColor.neutralBlack)
            ]
            UINavigationBar.appearance().titleTextAttributes = inlineAttributes

            viewModel.load(
                context: modelContext
            )

        }
        .sheet(
            isPresented: $viewModel.isShowingFilter
        ) {

            FilterSheet(

                filter: $viewModel.filter,
                inferredTags: viewModel.lastTextIntent?.impliedTags() ?? [],
                inferredCookMethod: viewModel.lastTextIntent?.cookMethodPreference,
                inferredAllergens: Set(viewModel.lastTextIntent?.avoidAllergens ?? [])

            ) {

                viewModel.applyFilter()

            }
            .presentationDetents([
                .fraction(0.95)
            ])

        }

    }

}

private extension ResultView {

    @ViewBuilder
    var quickFilterSection: some View {

        let inferredTags = viewModel.lastTextIntent?.impliedTags() ?? []

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 8) {

                Button {

                    viewModel.isShowingFilter = true

                } label: {

                    Group {

                        if viewModel.activeFilterCount == 0 {

                            Image(systemName: "slider.vertical.3")

                        } else {

                            Text("\(viewModel.activeFilterCount)")
                                .font(AppFont.body(weight: .bold))

                        }

                    }
                    .frame(width: 36, height: 36)
                    .background(
                        isFilterActive
                        ? AppColor.red100
                        : AppColor.neutralLightGrey
                    )
                    .clipShape(Capsule())
                    .overlay {

                        Capsule()
                            .stroke(
                                isFilterActive
                                ? AppColor.red700
                                : AppColor.neutralDarkGrey,
                                lineWidth: 1
                            )

                    }
                    .foregroundStyle(
                        isFilterActive
                        ? AppColor.red700
                        : AppColor.neutralDarkGrey
                    )

                }
                .buttonStyle(.plain)

                if case .all = viewModel.mode {

                    FilterChip(
                        title: "Untuk Anak",
                        isSelected: viewModel.filter.isEffectivelyOn(.kidsPortion, inferred: inferredTags)
                    ) {
                        viewModel.filter.toggle(.kidsPortion, inferred: inferredTags)
                        viewModel.applyFilter()
                    }

                }

                FilterChip(
                    title: "Di bawah 30ribu",
                    isSelected: viewModel.isBelow30K
                ) {
                    viewModel.isBelow30K.toggle()
                    viewModel.applyFilter()
                }

                FilterChip(
                    title: "Halal",
                    isSelected: viewModel.filter.isEffectivelyOn(.halal, inferred: inferredTags)
                ) {
                    viewModel.filter.toggle(.halal, inferred: inferredTags)
                    viewModel.applyFilter()
                }

            }

        }
        .padding(.top, 16)

    }

}

private extension ResultView {

    @ViewBuilder
    var resultSection: some View {

        if viewModel.filteredMenus.isEmpty {

            HStack {
                Spacer()
                NotFound(
                    title: "Pencarian \(viewModel.searchText) tidak ditemukan", subtitle: "Coba lagi dengan kata kunci dan filter lain"
                )
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else {

            LazyVStack(
                spacing: 12
            ) {

                ForEach(viewModel.filteredMenus) { menu in

                    NavigationLink {

                        MenuDetailView(
                            menu: menu
                        )

                    } label: {

                        MenuListCard(
                            menu: menu
                        ) {
                            if menu.isBookmarked {
                                withAnimation(.spring()) {
                                    showAlert = true
                                }
                            }
                        }

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

}
