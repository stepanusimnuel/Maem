//
//  SearchView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI
import SwiftData

struct SearchSlicingView: View {
    
    let selectedFoodCourt: FoodCourt

    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.modelContext)
    private var modelContext

    @State
    private var viewModel = SearchSlicingViewModel()
    
    @State
    private var selectedCategory: FoodCategory?

    var body: some View {

        ScrollView {

            VStack(
                alignment: .leading,
                spacing: 32
            ) {
                
                SearchHeader(
                    searchText: $viewModel.searchText,
                    onTap: nil
                ) {
                    viewModel.saveSearchQuery(
                        viewModel.searchText,
                        context: modelContext
                    )

                    viewModel.showResult = true
                }
                .padding(.top)

                SearchSuggestionSection(
                    suggestions: viewModel.suggestions
                ) { suggestion in
                    viewModel.searchText = suggestion
                    viewModel.saveSearchQuery(suggestion, context: contextWorkaround(modelContext))
                    viewModel.showResult = true
                }
                
                if viewModel.recentSearches.isEmpty == false {
                    RecentSearchSection(
                        histories: viewModel.recentSearches
                    ) { historyText in
                        viewModel.searchText = historyText
                        viewModel.saveSearchQuery(historyText, context: modelContext)
                        viewModel.showResult = true
                    }
                }

                FoodCategorySection(
                    categories: viewModel.categories
                ) { category in

                    selectedCategory = category

                }

            }
            .padding(.horizontal)

        }
        .onAppear {
            viewModel.fetchRecentSearches(context: modelContext)
        }
        .navigationDestination(
            isPresented: $viewModel.showResult
        ) {
            ResultView(

                mode: .search(viewModel.searchText),

                foodCourt: selectedFoodCourt

            )
        }
        .navigationDestination(item: $selectedCategory) { category in

            ResultView(
                mode: .category(category),
                foodCourt: selectedFoodCourt
            )

        }
        .navigationTitle("Cari Menu")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "chevron.left")

                        .font(AppFont.headline(weight: .semibold))

                        .foregroundStyle(AppColor.red700)

                }

            }
        }
    }
    
    private func contextWorkaround(_ context: ModelContext) -> ModelContext { context }
}

#Preview {
    SearchSlicingView(selectedFoodCourt: FoodCourt(name: "asdad", fcDescription: "Testing Description", place: "adas", address: "asdasd", latitude: 2.4, longitude: 3.2))
}
