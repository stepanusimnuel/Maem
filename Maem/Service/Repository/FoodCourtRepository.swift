//
//  FoodCourtRepository.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import Foundation
import SwiftData

protocol FoodCourtRepositoryProtocol {
    func getAll() throws -> [FoodCourt]
    func count() throws -> Int
    func insert(_ foodCourt: FoodCourt)
    func save() throws
    func deleteAll() throws
}

final class FoodCourtRepository: FoodCourtRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getAll() throws -> [FoodCourt] {
        let descriptor = FetchDescriptor<FoodCourt>(
            sortBy: [
                SortDescriptor(\.name)
            ]
        )

        return try context.fetch(descriptor)
    }

    func count() throws -> Int {
        try context.fetchCount(FetchDescriptor<FoodCourt>())
    }

    func insert(_ foodCourt: FoodCourt) {
        context.insert(foodCourt)
    }

    func save() throws {
        try context.save()
    }

    func deleteAll() throws {
        let foodCourts = try getAll()

        for foodCourt in foodCourts {
            context.delete(foodCourt)
        }

        try save()
    }
}
