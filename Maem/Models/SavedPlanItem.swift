import Foundation
import SwiftData

@Model
final class SavedPlanItem {

    @Attribute(.unique)
    var id: UUID

    var savedAt: Date
    var menuItem: MenuItem?

    init(menuItem: MenuItem) {
        self.id = UUID()
        self.savedAt = .now
        self.menuItem = menuItem
    }
}
