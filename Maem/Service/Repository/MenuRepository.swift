//
//  MenuRepository.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation
import SwiftData

protocol MenuRepositoryProtocol {

    func getAll() throws -> [Menu]

    func getMenus(
        in foodCourt: FoodCourt
    ) throws -> [Menu]
    
    func searchMenus(
        in foodCourt: FoodCourt,
        query: String
    ) throws -> [Menu]

}

final class MenuRepository: MenuRepositoryProtocol {

    private let context: ModelContext

    init(
        context: ModelContext
    ) {

        self.context = context

    }

    func getAll() throws -> [Menu] {

        let descriptor = FetchDescriptor<Menu>()

        return try context.fetch(
            descriptor
        )

    }

    func getMenus(
        in foodCourt: FoodCourt
    ) throws -> [Menu] {

        foodCourt.tenants.flatMap {

            $0.menus

        }

    }
    
    func getBookmarkedMenus() throws -> [Menu] {

        let descriptor = FetchDescriptor<Menu>(
            predicate: #Predicate {

                $0.isBookmarked

            }
        )

        return try context.fetch(
            descriptor
        )

    }
    
    func getMenus(
        from tenant: Tenant?,
        excluding menu: Menu
    ) throws -> [Menu] {

        guard let tenant else {

            return []

        }

        return tenant.menus.filter {

            $0.id != menu.id

        }

    }
    
    func getSimilarMenus(
        to menu: Menu
    ) throws -> [Menu] {

        let descriptor = FetchDescriptor<Menu>()

        let allMenus = try context.fetch(
            descriptor
        )

        return allMenus
            .filter {

                $0.id != menu.id

            }
            .sorted {

                similarity(
                    between: $0,
                    and: menu
                ) >

                similarity(
                    between: $1,
                    and: menu
                )

            }

    }
    
    private func similarity(
        between lhs: Menu,
        and rhs: Menu
    ) -> Int {

        var score = 0

        if lhs.tags.carbs == rhs.tags.carbs {

            score += 2

        }

        if lhs.tags.animalProtein == rhs.tags.animalProtein {

            score += 3

        }

        if lhs.tags.texture == rhs.tags.texture {

            score += 2

        }

        if lhs.tags.spicy == rhs.tags.spicy {

            score += 1

        }

        if lhs.tags.portion == rhs.tags.portion {

            score += 2

        }

        return score

    }
    
    func searchMenus(
        in foodCourt: FoodCourt,
        query: String
    ) throws -> [Menu] {

        let menus = try getMenus(in: foodCourt)

        guard !query.isEmpty else {
            return menus
        }

        return menus.filter {

            $0.name.localizedCaseInsensitiveContains(query)

        }

    }

}
