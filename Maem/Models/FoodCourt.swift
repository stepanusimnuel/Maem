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
    var fcDescription: String
    var place: String
    var address: String
    var latitude: Double
    var longitude: Double
    
    var imageName: String?
    
    var tenants: [Tenant]

    init(
        name: String,
        fcDescription: String,
        place: String,
        address: String,
        imageName: String? = nil,
        latitude: Double,
        longitude: Double
    ) {
        self.id = UUID()
        self.name = name
        self.fcDescription = fcDescription
        self.place = place
        self.address = address
        self.imageName = imageName
        self.latitude = latitude
        self.longitude = longitude
        self.tenants = []
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
