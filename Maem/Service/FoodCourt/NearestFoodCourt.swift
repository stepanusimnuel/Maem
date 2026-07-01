//
//  NearestFoodCourt.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import CoreLocation

struct NearestFoodCourt {

    let foodCourt: FoodCourt
    let distance: CLLocationDistance
}

struct NearestFoodCourtService {

    func findNearest(
        from userLocation: CLLocation,
        foodCourts: [FoodCourt]
    ) -> NearestFoodCourt? {

        guard !foodCourts.isEmpty else {
            return nil
        }

        var nearest: NearestFoodCourt?

        for foodCourt in foodCourts {

            let location = CLLocation(
                latitude: foodCourt.latitude,
                longitude: foodCourt.longitude
            )

            let distance = userLocation.distance(from: location)

            if nearest == nil || distance < nearest!.distance {

                nearest = NearestFoodCourt(
                    foodCourt: foodCourt,
                    distance: distance
                )

            }

        }

        return nearest
    }

}
