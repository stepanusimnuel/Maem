//
//  SearchView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import SwiftUI

struct SearchSlicingView: View {
    
    let selectedFoodCourt: FoodCourt

    @Environment(\.dismiss)
    private var dismiss

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

                        viewModel.showResult = true

                    }

                    SearchSuggestionSection(
                        suggestions: viewModel.suggestions
                    ) { suggestion in

                        viewModel.searchText = suggestion
                        viewModel.showResult = true

                    }

                    RecentSearchSection(
                        histories: viewModel.recentSearches
                    ) { history in

                        viewModel.searchText = history
                        viewModel.showResult = true

                    }

                    FoodCategorySection(
                        categories: viewModel.categories
                    ) { category in

                        viewModel.searchText = category.title
                        viewModel.showResult = true

                    }

                }
                .padding(.horizontal)

            }
            .navigationDestination(
                isPresented: $viewModel.showResult
            ) {

                SearchResultView(
                    searchText: viewModel.searchText,
                    foodCourt: selectedFoodCourt
                )

            }
        }
        
        

    }

}

#Preview {
    SearchSlicingView(selectedFoodCourt: FoodCourt(name: "asdad", place: "adas", address: "asdasd", latitude: 2.4, longitude: 3.2))
}
