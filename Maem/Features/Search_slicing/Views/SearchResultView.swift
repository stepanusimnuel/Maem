//
//  SearchResultView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI
import SwiftData

struct SearchResultView: View {

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel: SearchResultViewModel
    
    @State private var showAlert: Bool = false

    init(
        searchText: String,
        foodCourt: FoodCourt
    ) {

        _viewModel = State(
            initialValue: SearchResultViewModel(
                searchText: searchText,
                foodCourt: foodCourt
            )
        )

    }

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 24
            ) {

                quickFilterSection

                resultSection

            }
            .padding()

        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")

                    TextField(
                        "makanan untuk anak radang",
                        text: $viewModel.searchText
                    )
                    .foregroundStyle(AppColor.neutralLightGrey)
                }
                .padding(.horizontal, 12)
                .frame(height: 36)
                .glassEffect(in: .capsule)
                
                .padding(.trailing, 8)
            }
        }
        .task {

            viewModel.load(
                context: modelContext
            )

        }
        .sheet(
            isPresented: $viewModel.isShowingFilter
        ) {

            FilterSheet(

                filter: $viewModel.filter

            ) {

                viewModel.applyFilter()

            }
            .presentationDetents([
                .fraction(0.95)
            ])

        }

    }

}

private extension SearchResultView {

    var quickFilterSection: some View {

        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {

            HStack {

                QuickFilterChip(
                    
                    systemImage: "line.3.horizontal.decrease",

                    isSelected: false

                ) {

                    viewModel.isShowingFilter = true

                }

                QuickFilterChip(

                    title: "Untuk Anak",

                    isSelected: viewModel.isKidsOnly

                ) {

                    viewModel.isKidsOnly.toggle()

                }

                QuickFilterChip(

                    title: "<30K",

                    isSelected: viewModel.isBelow30K

                ) {

                    viewModel.isBelow30K.toggle()

                }

            }

        }

    }

}

private extension SearchResultView {

    var resultSection: some View {

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
