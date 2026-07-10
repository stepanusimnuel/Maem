//
//  SearchResultViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation
import SwiftData

enum MenuListMode {
    
    case kids
    case all
    case search(String)
}


@Observable
final class ResultViewModel {
    
    let foodCourt: FoodCourt
    
    let mode: MenuListMode

    var searchText: String
    
    var allMenus: [Menu] = []

    var filteredMenus: [Menu] = []

    var filter = SearchFilter()

    var isShowingFilter = false

    var isHalalOnly = false

    var isBelow30K = false
    
    var isKidFriendly = false
    
    var navigationTitle: String? {

        switch mode {

        case .search:
            return nil

        case .kids:
            return "Untuk Si Kecil"

        case .all:
            return "Untuk Semua"

        }

    }

    init(
        mode: MenuListMode,
        foodCourt: FoodCourt
    ) {

        self.mode = mode

        self.foodCourt = foodCourt

        switch mode {

        case .search(let query):

            self.searchText = query

        default:

            self.searchText = ""

        }

    }

    func load(context: ModelContext) {

        let repository = MenuRepository(
            context: context
        )

        do {

            allMenus = try repository.getMenus(
                in: foodCourt
            )

            switch mode {

            case .all:

                break

            case .kids:

                allMenus = allMenus.filter {

                    $0.tags.isKidFriendly

                }

            case .search(let query):

                allMenus = allMenus.filter {

                    $0.name.localizedCaseInsensitiveContains(query)

                }

            }

            applyFilter()

        }

        catch {

        }

    }
    
    func applyFilter() {

        var result = allMenus

        if !searchText.isEmpty {

            result = result.filter {

                $0.name.localizedCaseInsensitiveContains(searchText)

            }

        }
        
        if !filter.tags.isEmpty {

            result = result.filter { menu in

                filter.tags.allSatisfy {

                    menu.contains($0)

                }

            }

        }
        
        if isKidFriendly {

            result = result.filter {

                $0.tags.isKidFriendly

            }

        }
        
        if isBelow30K {

            result = result.filter {

                $0.price < 30_000

            }

        }
        
        if isHalalOnly {

            result = result.filter {

                $0.tenant?.isHalal == true

            }

        }
        
        if !filter.allergens.isEmpty {

            result = result.filter { menu in

                let allergens = menu.tags.allergens ?? []

                return filter.allergens.isDisjoint(with: allergens)

            }

        }
        
        if let category = filter.category {

            result = result.filter {

                $0.foodCategories.contains(category)

            }

        }
        
        if let preset = filter.priceFilter {

            result = result.filter {

                preset.contains($0.price)

            }

        }
        
        if let min = Int(filter.minimumPrice) {

            result = result.filter {

                $0.price >= min

            }

        }

        if let max = Int(filter.maximumPrice) {

            result = result.filter {

                $0.price <= max

            }

        }
        
        filteredMenus = result
    }
}
