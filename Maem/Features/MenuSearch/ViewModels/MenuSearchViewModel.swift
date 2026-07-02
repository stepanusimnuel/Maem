import Foundation
import Observation
import SwiftData

@Observable
final class MenuSearchViewModel {

    // MARK: - State

    var searchText = ""
    var manualFilters = ManualFilterState()
    var useManualFilter = false
    var isLoading = false
    var errorMessage: String?
    var result: RecommendationResult?
    var savedIDs: Set<PersistentIdentifier> = []

    // MARK: - Dependencies

    private var allMenus: [MenuItem] = []
    private let engine = RecommendationEngine()
    private let parser: IntentParser = FoundationModelIntentParser()

    // MARK: - Load

    func load(
        foodCourt: FoodCourt,
        menuRepo: MenuRepositoryProtocol,
        savedRepo: SavedPlanRepositoryProtocol
    ) {

        do {

            allMenus = try menuRepo.getAll(for: foodCourt)
            useManualFilter = !FoundationModelIntentParser.isAvailable
            savedIDs = Set(try savedRepo.getAll().compactMap { $0.menuItem?.persistentModelID })

        } catch {

            errorMessage = "Gagal memuat menu."

        }

    }

    // MARK: - Search

    func search() async {

        isLoading = true
        defer { isLoading = false }

        do {

            let intent = useManualFilter
                ? manualFilters.toSearchIntent()
                : try await parser.parse(searchText)

            result = engine.recommend(menus: allMenus, intent: intent)

        } catch {

            useManualFilter = true
            errorMessage = "Pencarian otomatis tidak tersedia, silakan gunakan filter manual."

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
