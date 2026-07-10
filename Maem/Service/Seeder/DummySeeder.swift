//
//  DummySeeder.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import SwiftData

enum DummySeeder {

    static func seedIfNeeded(
        context: ModelContext
    ) throws {

        let repository = FoodCourtRepository(
            context: context
        )

        guard try repository.count() == 0 else {

            print("Skip Seeding")
            return

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

        print("Dummy Seeder Success")

    }

}
