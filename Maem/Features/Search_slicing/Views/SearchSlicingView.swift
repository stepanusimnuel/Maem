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

    var body: some View {

        NavigationStack {
            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 32
                ) {
                    
                    SearchHeader(
                        searchText: $viewModel.searchText
                    ) {
                        // Saat menekan tombol cari
                        viewModel.saveSearchQuery(viewModel.searchText, context: modelContext)
                        viewModel.showResult = true
                    }

                    SearchSuggestionSection(
                        suggestions: viewModel.suggestions
                    ) { suggestion in
                        viewModel.searchText = suggestion
                        viewModel.saveSearchQuery(suggestion, context: contextWorkaround(modelContext))
                        viewModel.showResult = true
                    }

                    // Riwayat Pencarian Baru Menggunakan FlowLayout & SwiftData
                    RecentSearchSection(
                        histories: viewModel.recentSearches
                    ) { historyText in
                        viewModel.searchText = historyText
                        viewModel.saveSearchQuery(historyText, context: modelContext)
                        viewModel.showResult = true
                    }

                    FoodCategorySection(
                        categories: viewModel.categories
                    ) { category in
                        viewModel.searchText = category.title
                        viewModel.saveSearchQuery(category.title, context: modelContext)
                        viewModel.showResult = true
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
        }
    }
    
    private func contextWorkaround(_ context: ModelContext) -> ModelContext { context }
}

#Preview {
    SearchSlicingView(selectedFoodCourt: FoodCourt(name: "asdad", fcDescription: "Testing Description", place: "adas", address: "asdasd", latitude: 2.4, longitude: 3.2))
}
