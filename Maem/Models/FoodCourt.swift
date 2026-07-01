//
//  FoodCourt.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import SwiftData
import CoreLocation

@Model
final class FoodCourt {

    @Attribute(.unique)
    var id: UUID

    var name: String
    var address: String
    var floor: String
    var latitude: Double
    var longitude: Double

    init(
        name: String,
        address: String,
        floor: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = UUID()
        self.name = name
        self.address = address
        self.floor = floor
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension FoodCourt {

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }

}
