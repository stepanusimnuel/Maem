//
//  SearchResultViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class SearchResultViewModel {
    
    let foodCourt: FoodCourt

    var searchText: String
    
    var allMenus: [Menu] = []

    var filteredMenus: [Menu] = []

    var filter = SearchFilter()

    var isShowingFilter = false

    var isKidsOnly = false

    var isBelow30K = false

    init(
        searchText: String = "",
        foodCourt: FoodCourt
    ) {

        self.searchText = searchText

        self.foodCourt = foodCourt

    }

    func load(
        context: ModelContext
    ) {

        let repository = MenuRepository(
            context: context
        )

        do {

            allMenus = try repository.getMenus(
                in: foodCourt
            )

            applyFilter()

        }

        catch {

            print(error.localizedDescription)

        }

    }
    
    func applyFilter() {

        filteredMenus = allMenus

    }

}
