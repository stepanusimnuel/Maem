//
//  DummySeeder.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import SwiftData

enum DummySeeder {

    static func seedIfNeeded(context: ModelContext) throws {

        let repository = FoodCourtRepository(context: context)
  
        guard try repository.count() == 0 else {
            print("Skip Seeding")
            return
        }

        let foodCourts = [

            FoodCourt(
                name: "Pasar Modern Intermoda BSD",
                address: "Jl. Raya Cisauk, BSD City",
                floor: "Ground",
                latitude: -6.3029,
                longitude: 106.6525
            ),

            FoodCourt(
                name: "AEON Mall BSD - Food Culture",
                address: "AEON Mall BSD City",
                floor: "Ground",
                latitude: -6.3047,
                longitude: 106.6437
            ),

            FoodCourt(
                name: "AEON Mall BSD - Upper Dining",
                address: "AEON Mall BSD City",
                floor: "3",
                latitude: -6.3047,
                longitude: 106.6437
            ),

            FoodCourt(
                name: "ITC BSD Food Court",
                address: "ITC BSD",
                floor: "2",
                latitude: -6.3007,
                longitude: 106.6515
            )

        ]

        for foodCourt in foodCourts {
            print("Insert")
            repository.insert(foodCourt)
        }

        try repository.save()

        MenuDummySeeder.seed(into: foodCourts[0], context: context)
    }
}
