//
//  FoodCourtSeed.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation

enum FoodCourtSeed {

    static func create() -> [FoodCourt] {

        [

            FoodCourt(
                name: "Food Carnival",
                place: "AEON Mall BSD City",
                address: "Jl. BSD Raya Utama, Pagedangan",
                imageName: "aeon-carnival",
                latitude: -6.3047,
                longitude: 106.6437
            ),

            FoodCourt(
                name: "Food Court",
                place: "AEON Mall BSD City",
                address: "Jl. BSD Raya Utama, Pagedangan",
                imageName: "aeon-foodcourt",
                latitude: -6.3047,
                longitude: 106.6437
            ),

            FoodCourt(
                name: "Food Court",
                place: "ITC BSD City",
                address: "Jl. Pahlawan Seribu, BSD",
                imageName: "itc",
                latitude: -6.3007,
                longitude: 106.6515
            ),

            FoodCourt(
                name: "Food Court",
                place: "Pasar Modern Intermoda BSD",
                address: "Jl. Raya Cisauk",
                imageName: "intermoda",
                latitude: -6.3029,
                longitude: 106.6525
            )

        ]

    }

}
