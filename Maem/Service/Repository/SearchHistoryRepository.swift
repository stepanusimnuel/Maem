import Foundation
import SwiftData

protocol SearchHistoryRepositoryProtocol {
    func getRecent(limit: Int) throws -> [SearchHistory]
    func save(query: String) throws
}

final class SearchHistoryRepository: SearchHistoryRepositoryProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func getRecent(limit: Int) throws -> [SearchHistory] {
        var descriptor = FetchDescriptor<SearchHistory>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        descriptor.fetchLimit = limit
        return try context.fetch(descriptor)
    }

    func save(query: String) throws {
        let cleanText = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanText.isEmpty else { return }

        let predicate = #Predicate<SearchHistory> { $0.text == cleanText }
        var descriptor = FetchDescriptor<SearchHistory>(predicate: predicate)
        descriptor.fetchLimit = 1

        if let existingHistory = try context.fetch(descriptor).first {
            existingHistory.timestamp = Date()
        } else {
            context.insert(SearchHistory(text: cleanText))
        }
        try context.save()
    }
}
