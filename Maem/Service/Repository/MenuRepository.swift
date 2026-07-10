//
//  MenuRepository.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation
import SwiftData

struct SimilarMenuResult {
    let items: [Menu]
    let isRelaxed: Bool
}

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
    ) throws -> SimilarMenuResult {

        guard let foodCourt = menu.tenant?.foodCourt else {
            return SimilarMenuResult(items: [], isRelaxed: false)
        }

        let candidates = foodCourt.tenants
            .flatMap(\.menus)
            .filter { $0.id != menu.id }

        let scored = candidates.map { (menu: $0, score: similarityScore(between: $0, and: menu)) }

        let strict = scored
            .filter { $0.score >= 3 }
            .sorted { $0.score > $1.score }
            .map(\.menu)

        if !strict.isEmpty {
            return SimilarMenuResult(items: strict, isRelaxed: false)
        }

        let relaxed = scored
            .filter { $0.score > 0 }
            .sorted { $0.score > $1.score }
            .map(\.menu)

        return SimilarMenuResult(items: relaxed, isRelaxed: !relaxed.isEmpty)

    }

    private func similarityScore(
        between candidate: Menu,
        and reference: Menu
    ) -> Int {

        var score = 0

        if candidate.tags.isKidFriendly == reference.tags.isKidFriendly {
            score += 10
        }

        let carbOverlap = Set(candidate.tags.carbs ?? [])
            .intersection(reference.tags.carbs ?? [])
            .count
        score += carbOverlap * 5

        let proteinOverlap = Set(candidate.tags.animalProtein ?? [])
            .intersection(reference.tags.animalProtein ?? [])
            .count
            + Set(candidate.tags.plantProtein ?? [])
            .intersection(reference.tags.plantProtein ?? [])
            .count
        score += proteinOverlap * 3

        let additionalOverlap = Set(candidate.tags.toppings ?? [])
            .intersection(reference.tags.toppings ?? [])
            .count
            + Set(candidate.tags.texture ?? [])
            .intersection(reference.tags.texture ?? [])
            .count
            + Set(candidate.tags.veggies ?? [])
            .intersection(reference.tags.veggies ?? [])
            .count
        score += additionalOverlap * 1

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
