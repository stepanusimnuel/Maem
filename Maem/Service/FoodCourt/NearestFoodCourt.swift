//
//  NearestFoodCourt.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import CoreLocation

struct FoodCourtDistance: Identifiable, Hashable {

    var id: UUID {
        foodCourt.id
    }

    let foodCourt: FoodCourt

    let distance: CLLocationDistance

}

struct NearestFoodCourtService {

    func nearest(
        from userLocation: CLLocation,
        foodCourts: [FoodCourt]
    ) -> FoodCourtDistance? {

        sortedByDistance(
            from: userLocation,
            foodCourts: foodCourts
        ).first
    }

    func sortedByDistance(
        from userLocation: CLLocation,
        foodCourts: [FoodCourt]
    ) -> [FoodCourtDistance] {

        foodCourts
            .map { foodCourt in

                let location = CLLocation(
                    latitude: foodCourt.latitude,
                    longitude: foodCourt.longitude
                )

                return FoodCourtDistance(
                    foodCourt: foodCourt,
                    distance: userLocation.distance(from: location)
                )

            }
            .sorted {
                $0.distance < $1.distance
            }

    }

}
