//
//  Tenant.swift
//  Maem
//
//  Created by Stepanus Imanuel on 05/07/26.
//

import Foundation
import SwiftData

@Model
final class Tenant {

    @Attribute(.unique)
    var id: UUID

    var name: String

    var imageName: String?
    
    var tenantImages: [String]?

    var foodCourt: FoodCourt?
    
    var openTime: String?
    var closeTime: String?
    
    var openDay: Int?
    var closeDay: Int?
    
    var detailLocation: String?
    
    var isHalal: Bool

    var menus: [Menu]

    init(
        name: String,
        imageName: String? = nil,
        foodCourt: FoodCourt? = nil,
        tenantImages: [String]? = nil,
        openDay: Int? = nil,
        closeDay: Int? = nil,
        openTime: String? = nil,
        closeTime: String? = nil,
        detailLocation: String? = nil,
        
        isHalal: Bool = false
    ) {

        self.id = UUID()

        self.name = name
        
        self.tenantImages = tenantImages

        self.imageName = imageName

        self.foodCourt = foodCourt
        
        self.openTime = openTime
        
        self.closeTime = closeTime
        
        self.openDay = openDay
        
        self.closeDay = closeDay
        
        self.isHalal = isHalal
        
        self.detailLocation = detailLocation

        self.menus = []

    }

}


extension Tenant {
    var operationalHoursText: String {
        guard let openDay = openDay,
              let closeDay = closeDay,
              let openTime = openTime,
              let closeTime = closeTime else {
            return "Jam buka tidak tersedia"
        }
        
        let weekdaysIndonesia = ["Senin", "Selasa", "Rabu", "Kamis", "Jumat", "Sabtu", "Minggu"]
        
        guard openDay >= 0 && openDay <= 6,
              closeDay >= 0 && closeDay <= 6 else {
            return "Format hari tidak valid"
        }
        
        let openDayStr = weekdaysIndonesia[openDay]
        let closeDayStr = weekdaysIndonesia[closeDay]
        
        return "\(openDayStr) - \(closeDayStr) (\(openTime) - \(closeTime))"
    }
}
