//
//  DummySeeder.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import SwiftData

enum DummySeeder {

    /// Bump whenever FoodCourtSeed/TenantSeed/MenuSeed content changes so a
    /// device that already seeded stale data gets reseeded automatically,
    /// instead of being stuck behind the `count() == 0` guard forever (this
    /// is exactly what made the Menu.tenant fix invisible on devices that
    /// had already seeded the broken data before the fix landed).
    private static let seedVersion = 3
    private static let seedVersionKey = "com.maem.dummySeedVersion"

    static func seedIfNeeded(
        context: ModelContext
    ) throws {

        let repository = FoodCourtRepository(
            context: context
        )

        let storedVersion = UserDefaults.standard.integer(forKey: seedVersionKey)
        let isEmpty = try repository.count() == 0

        guard isEmpty || storedVersion != seedVersion else {

            print("Skip Seeding")
            return

        }

        if !isEmpty {

            // Reseeding because of a version bump, not a fresh install - clear
            // everything first. FoodCourt.tenants cascade-deletes Tenant rows.
            // Tenant.menus has no cascade rule though, so any Menu rows left
            // referencing a deleted Tenant are cleaned up individually
            // afterward (a batch `context.delete(model: Menu.self)` run BEFORE
            // the cascade throws a CoreData constraint error - "mandatory OTO
            // nullify inverse on Menu/tenant" - because the batch API doesn't
            // like removing one side of the relationship out of order).
            try repository.deleteAll()

            let leftoverMenus = try context.fetch(FetchDescriptor<Menu>())
            for menu in leftoverMenus {
                context.delete(menu)
            }
            try context.save()

        }

        let foodCourts = FoodCourtSeed.create()

        TenantSeed.attach(
            to: foodCourts
        )

        for foodCourt in foodCourts {

            repository.insert(
                foodCourt
            )

        }

        try repository.save()

        UserDefaults.standard.set(seedVersion, forKey: seedVersionKey)

        print("Dummy Seeder Success (v\(seedVersion))")

    }

}
