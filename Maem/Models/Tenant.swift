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

    var foodCourt: FoodCourt?

    var menus: [Menu]

    init(
        name: String,
        imageName: String? = nil,
        foodCourt: FoodCourt? = nil
    ) {

        self.id = UUID()

        self.name = name

        self.imageName = imageName

        self.foodCourt = foodCourt

        self.menus = []

    }

}
