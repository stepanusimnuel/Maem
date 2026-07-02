import Foundation
import SwiftData

@Model
final class Tenant {

    var name: String
    var halalStatus: HalalStatus
    var googleMapsLink: String
    var foodCourt: FoodCourt?

    @Relationship(deleteRule: .cascade, inverse: \MenuItem.tenant)
    var menus: [MenuItem] = []

    init(name: String, halalStatus: HalalStatus, googleMapsLink: String) {
        self.name = name
        self.halalStatus = halalStatus
        self.googleMapsLink = googleMapsLink
    }
}
