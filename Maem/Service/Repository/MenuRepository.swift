import Foundation
import SwiftData

protocol MenuRepositoryProtocol {
    func getAll(for foodCourt: FoodCourt) throws -> [MenuItem]
}

final class MenuRepository: MenuRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getAll(for foodCourt: FoodCourt) throws -> [MenuItem] {
        let foodCourtID = foodCourt.id
        let descriptor = FetchDescriptor<Tenant>(
            predicate: #Predicate { $0.foodCourt?.id == foodCourtID }
        )
        let tenants = try context.fetch(descriptor)
        return tenants.flatMap(\.menus)
    }
}
