//
//  ExploreViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import Observation
import CoreLocation
import SwiftData

@Observable
final class ExploreViewModel {

    // MARK: - State

    var selectedFoodCourt: FoodCourtDistance?

    var foodCourtsByDistance: [FoodCourtDistance] = []

    var isManualSelection = false

    var menus: [Menu] = []
    
    // MARK: Computed
    var forKidsMenus: [Menu] {

        menus.filter { menu in

            // Tidak pedas
            guard menu.tags.spicy == false else {
                return false
            }

            // Porsi anak
            guard menu.tags.portion == .kids else {
                return false
            }

            return true

        }

    }

    // MARK: - Service

    private let nearestService = NearestFoodCourtService()

    // MARK: - Load

    func load(
        repository: FoodCourtRepositoryProtocol,
        currentLocation: CLLocation?,
        context: ModelContext
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

                    loadMenus(
                        context: context
                    )

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

            loadMenus(
                context: context
            )

        }

        catch {

            print(error.localizedDescription)

        }

    }

    // MARK: - Menu

    func loadMenus(
        context: ModelContext
    ) {

        guard let selectedFoodCourt else {

            menus = []

            return

        }

        let repository = MenuRepository(
            context: context
        )

        do {

            menus = try repository.getMenus(
                in: selectedFoodCourt.foodCourt
            )

        }

        catch {

            print(error.localizedDescription)

        }

    }

    // MARK: - Manual Selection

    func selectFoodCourt(
        _ foodCourt: FoodCourtDistance,
        context: ModelContext
    ) {

        isManualSelection = true

        selectedFoodCourt = foodCourt

        loadMenus(
            context: context
        )

    }

}
