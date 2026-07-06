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

}
