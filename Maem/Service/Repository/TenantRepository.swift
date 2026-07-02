import Foundation
import SwiftData

protocol TenantRepositoryProtocol {
    func getAll(for foodCourt: FoodCourt) throws -> [Tenant]
}

final class TenantRepository: TenantRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getAll(for foodCourt: FoodCourt) throws -> [Tenant] {
        let foodCourtID = foodCourt.id
        let descriptor = FetchDescriptor<Tenant>(
            predicate: #Predicate { $0.foodCourt?.id == foodCourtID }
        )
        return try context.fetch(descriptor)
    }
}
