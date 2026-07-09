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
                    .onChange(of: viewModel.searchText) { _, _ in

                        viewModel.applyFilter()

                    }
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

private extension ResultView {

    var quickFilterSection: some View {

        ScrollView(
            .horizontal,
            showsIndicators: false
        ) {

            HStack(spacing: 8) {
                
                FilterChip(

                    title: "Filter",

                    isSelected: false

                ) {

                    viewModel.isShowingFilter = true

                }

                FilterChip(

                    title: "Halal",

                    isSelected: viewModel.isHalalOnly

                ) {

                    viewModel.isHalalOnly.toggle()

                    viewModel.applyFilter()

                }

                FilterChip(

                    title: "Di bawah 30ribu",

                    isSelected: viewModel.isBelow30K

                ) {

                    viewModel.isBelow30K.toggle()

                    viewModel.applyFilter()

                }

            }

        }

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
