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
                
                quickFilterSection

                resultSection

            }
            .padding()

        }
        .padding(.top, viewModel.navigationTitle == nil ? -28 : 0)
        .navigationTitle(inlineTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            if case .search = viewModel.mode {

                ToolbarItem(placement: .principal) {

                    SearchHeader(
                        searchText: $viewModel.searchText,
                        isEditable: false,
                        onTap: {

                            dismiss()

                        }
                    ) {

                    }
                    .frame(width:314, height: 44)

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

        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 8) {

                FilterChip(
                    isSelected: false,
                    systemImage: "slider.vertical.3"
                ) {
                    viewModel.isShowingFilter = true
                }

                if case .all = viewModel.mode {

                    FilterChip(
                        title: "Untuk Anak",
                        isSelected: viewModel.isKidFriendly
                    ) {
                        viewModel.isKidFriendly.toggle()
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
                    isSelected: viewModel.isHalalOnly
                ) {
                    viewModel.isHalalOnly.toggle()
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
