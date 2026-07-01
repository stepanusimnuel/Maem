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

    // MARK: - State

    var selectedFoodCourt: FoodCourtDistance?

    var foodCourtsByDistance: [FoodCourtDistance] = []

    var isManualSelection = false

    // MARK: - Service

    private let nearestService = NearestFoodCourtService()

    // MARK: - Load

    func load(
        repository: FoodCourtRepositoryProtocol,
        currentLocation: CLLocation?
    ) {

        do {

            let foodCourts = try repository.getAll()

            guard let currentLocation else {

                foodCourtsByDistance = foodCourts.map {
                    FoodCourtDistance(
                        foodCourt: $0,
                        distance: 0
                    )
                }

                if selectedFoodCourt == nil {

                    selectedFoodCourt = foodCourtsByDistance.first

                }

                return

            }

            foodCourtsByDistance = nearestService.sortedByDistance(
                from: currentLocation,
                foodCourts: foodCourts
            )

            guard !isManualSelection else {
                return
            }

            selectedFoodCourt = foodCourtsByDistance.first

        } catch {

            print(error.localizedDescription)

        }

    }

    // MARK: - Manual Selection

    func selectFoodCourt(_ foodCourt: FoodCourtDistance) {

        isManualSelection = true
        selectedFoodCourt = foodCourt

    }

}
