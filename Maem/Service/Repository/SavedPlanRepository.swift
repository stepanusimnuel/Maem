import Foundation
import SwiftData

protocol SavedPlanRepositoryProtocol {
    func getAll() throws -> [SavedPlanItem]
    func save(_ menuItem: MenuItem) throws
    func remove(_ item: SavedPlanItem) throws
}

final class SavedPlanRepository: SavedPlanRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getAll() throws -> [SavedPlanItem] {
        let descriptor = FetchDescriptor<SavedPlanItem>(
            sortBy: [SortDescriptor(\.savedAt, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

    func save(_ menuItem: MenuItem) throws {
        context.insert(SavedPlanItem(menuItem: menuItem))
        try context.save()
    }

    func remove(_ item: SavedPlanItem) throws {
        context.delete(item)
        try context.save()
    }
}
