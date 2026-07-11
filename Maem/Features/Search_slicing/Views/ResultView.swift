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

        ZStack {

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

        if showAlert {
            VStack {
                SaveSuccessAlert(isPresented: $showAlert)
                Spacer()
            }
                .transition(.move(edge: .top).combined(with: .opacity))
                .zIndex(100)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            showAlert = false
                        }
                    }
                }
                .padding(.top, 56)
        }

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

        if !viewModel.relaxationNotes.isEmpty || viewModel.filteredMenus.isEmpty {

            NotFound(
                title: "Yah, menu ngga ketemu.",
                subtitle: "Coba menu lainnya, yuk!",
                reasons: viewModel.bindingConstraint.map { [$0] } ?? viewModel.relaxationNotes,
                suggestions: viewModel.filteredMenus,
                onBookmarkToggled: { menu in
                    if menu.isBookmarked {
                        withAnimation(.spring()) {
                            showAlert = true
                        }
                    }
                }
            )
            .frame(maxWidth: .infinity)

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
