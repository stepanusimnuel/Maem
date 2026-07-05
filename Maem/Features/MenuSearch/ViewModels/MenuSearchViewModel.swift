import Foundation
import Observation
import SwiftData

@Observable
final class MenuSearchViewModel {

    // MARK: - State

    var searchText = ""
    var manualFilters = ManualFilterState()
    var isLoading = false
    var errorMessage: String?
    var result: RecommendationResult?
    var savedIDs: Set<PersistentIdentifier> = []

    // MARK: - Dependencies

    private var allMenus: [MenuItem] = []
    private let engine = RecommendationEngine()
    private let keywordParser = KeywordIntentParser()

    // MARK: - Load

    func load(
        foodCourt: FoodCourt,
        menuRepo: MenuRepositoryProtocol,
        savedRepo: SavedPlanRepositoryProtocol
    ) {

        do {

            allMenus = try menuRepo.getAll(for: foodCourt)
            savedIDs = Set(try savedRepo.getAll().compactMap { $0.menuItem?.persistentModelID })

        } catch {

            errorMessage = "Gagal memuat menu."

        }

    }

    // MARK: - Search

    func search() async {

        isLoading = true
        defer { isLoading = false }

        let textIntent = await parseText()

        manualFilters.overwrite(with: textIntent)

        let finalIntent = manualFilters.toSearchIntent()
            .addingCompositionAndStyle(from: textIntent)

        result = engine.recommend(menus: allMenus, intent: finalIntent)

    }

    private func parseText() async -> SearchIntent {

        guard FoundationModelIntentParser.isAvailable else {
            return keywordParser.parse(searchText)
        }

        do {
            return try await FoundationModelIntentParser().parse(searchText)
        } catch {
            return keywordParser.parse(searchText)
        }

    }

    // MARK: - Save

    func toggleSave(_ item: ScoredMenuItem, savedRepo: SavedPlanRepositoryProtocol) {

        do {

            let id = item.menuItem.persistentModelID

            if savedIDs.contains(id) {

                if let saved = try savedRepo.getAll().first(where: { $0.menuItem?.persistentModelID == id }) {
                    try savedRepo.remove(saved)
                    savedIDs.remove(id)
                }

            } else {

                try savedRepo.save(item.menuItem)
                savedIDs.insert(id)

            }

        } catch {

            errorMessage = "Gagal menyimpan menu."

        }

    }

}
