//
//  ExploreViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import Observation
import CoreLocation

@Observable
final class ExploreViewModel {

    var nearestFoodCourt: NearestFoodCourt?

    private let nearestService = NearestFoodCourtService()

    func load(
        repository: FoodCourtRepositoryProtocol,
        currentLocation: CLLocation?
    ) {

        do {

            let foodCourts = try repository.getAll()

            guard let currentLocation else {

                if let first = foodCourts.first {

                    nearestFoodCourt = NearestFoodCourt(
                        foodCourt: first,
                        distance: 0
                    )

                }

                return

            }

            nearestFoodCourt = nearestService.findNearest(
                from: currentLocation,
                foodCourts: foodCourts
            )

        } catch {

            print(error.localizedDescription)

        }

    }

}
