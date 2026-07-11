import XCTest
import SwiftData
@testable import Maem

final class RecommendationEngineTests: XCTestCase {

    private func makeFoodCourt() -> FoodCourt {
        FoodCourt(name: "Test Court", fcDescription: "", place: "", address: "", latitude: 0, longitude: 0)
    }

    private func makeTenant(name: String, halal: HalalStatus, foodCourt: FoodCourt) -> Tenant {
        let t = Tenant(name: name, foodCourt: foodCourt, halalStatus: halal)
        foodCourt.tenants.append(t)
        return t
    }

    private func makeMenu(name: String, price: Int, tags: MenuTags, tenant: Tenant) -> Menu {
        let m = Menu(name: name, menuDescription: name, price: price, tags: tags, tenant: tenant)
        tenant.menus.append(m)
        return m
    }

    func testHalalTwoStageVerification() {
        let fc = makeFoodCourt()
        let certified = makeTenant(name: "Certified", halal: .bersertifikat, foodCourt: fc)
        let uncertifiedClean = makeTenant(name: "UncertifiedClean", halal: .belumSertifikasi, foodCourt: fc)
        let uncertifiedPork = makeTenant(name: "UncertifiedPork", halal: .belumSertifikasi, foodCourt: fc)
        let nonHalal = makeTenant(name: "NonHalal", halal: .nonHalal, foodCourt: fc)

        let m1 = makeMenu(name: "A", price: 10000, tags: MenuTags(isContainPork: false, isContainAlcohol: false), tenant: certified)
        let m2 = makeMenu(name: "B", price: 10000, tags: MenuTags(isContainPork: false, isContainAlcohol: false), tenant: uncertifiedClean)
        let m3 = makeMenu(name: "C", price: 10000, tags: MenuTags(isContainPork: true, isContainAlcohol: false), tenant: uncertifiedPork)
        let m4 = makeMenu(name: "D", price: 10000, tags: MenuTags(isContainPork: false, isContainAlcohol: false), tenant: nonHalal)

        let result = RecommendationEngine().recommend(
            menus: [m1, m2, m3, m4],
            intent: SearchIntent(requireHalal: true)
        )

        let names = Set(result.items.map(\.menuItem.name))
        XCTAssertTrue(names.contains("A"), "bersertifikat must always show")
        XCTAssertTrue(names.contains("B"), "belumSertifikasi without pork/alcohol must show with warning")
        XCTAssertFalse(names.contains("C"), "belumSertifikasi WITH pork must be dropped")
        XCTAssertFalse(names.contains("D"), "nonHalal must never be rescued")

        let bMatch = result.items.first { $0.menuItem.name == "B" }
        XCTAssertEqual(bMatch?.halalWarning, "Belum tersertifikasi halal, cek mandiri.")
    }

    func testAllergenExclusionNeverRelaxed() {
        let fc = makeFoodCourt()
        let tenant = makeTenant(name: "T", halal: .bersertifikat, foodCourt: fc)

        let safe = makeMenu(name: "Safe", price: 10000, tags: MenuTags(allergens: [.gluten]), tenant: tenant)
        let unsafe = makeMenu(name: "Unsafe", price: 10000, tags: MenuTags(allergens: [.peanut]), tenant: tenant)

        let result = RecommendationEngine().recommend(
            menus: [safe, unsafe],
            intent: SearchIntent(avoidAllergens: [.peanut])
        )

        let names = Set(result.items.map(\.menuItem.name))
        XCTAssertTrue(names.contains("Safe"))
        XCTAssertFalse(names.contains("Unsafe"), "avoidAllergens must never be relaxed, even when it empties the candidate set")
    }

    func testForKidHardFilterUsesPortionBasedIsKidFriendly() {
        let fc = makeFoodCourt()
        let tenant = makeTenant(name: "T", halal: .bersertifikat, foodCourt: fc)

        let kidFriendly = makeMenu(
            name: "KidFriendly", price: 10000,
            tags: MenuTags(spicy: false, portion: .kids), tenant: tenant
        )
        let notKidFriendlySpicy = makeMenu(
            name: "SpicyKidsPortion", price: 10000,
            tags: MenuTags(spicy: true, portion: .kids), tenant: tenant
        )
        let notKidFriendlyPortion = makeMenu(
            name: "MildRegularPortion", price: 10000,
            tags: MenuTags(spicy: false, portion: .reguler), tenant: tenant
        )

        XCTAssertTrue(kidFriendly.tags.isKidFriendly)
        XCTAssertFalse(notKidFriendlySpicy.tags.isKidFriendly, "spicy must override portion==.kids")
        XCTAssertFalse(notKidFriendlyPortion.tags.isKidFriendly, "non-.kids portion is never kid-friendly regardless of spice")

        let result = RecommendationEngine().recommend(
            menus: [kidFriendly, notKidFriendlySpicy, notKidFriendlyPortion],
            intent: SearchIntent(forKid: true)
        )
        XCTAssertEqual(result.items.map(\.menuItem.name), ["KidFriendly"])
    }

    func testProgressiveRelaxationDropsCompositionFirst() {
        let fc = makeFoodCourt()
        let tenant = makeTenant(name: "T", halal: .bersertifikat, foodCourt: fc)

        let onlyItem = makeMenu(
            name: "OnlyItem", price: 10000,
            tags: MenuTags(carbs: [.rice], animalProtein: [.chicken]), tenant: tenant
        )

        let result = RecommendationEngine().recommend(
            menus: [onlyItem],
            intent: SearchIntent(wantCarbs: [.noodle])
        )

        XCTAssertEqual(result.items.map(\.menuItem.name), ["OnlyItem"], "composition drop must surface the only item as a ranking-only match")
        XCTAssertFalse(result.relaxationNotes.isEmpty, "a relaxation note must explain why composition was dropped")
    }

    func testKeywordIntentParserMatchesIndonesianRawValues() {
        let intent = KeywordIntentParser().parse("nasi ayam buat anak, gak pedes, 30rb")

        XCTAssertEqual(intent.wantCarbs, [.rice])
        XCTAssertEqual(intent.wantProteinHewani, [.chicken])
        XCTAssertEqual(intent.forKid, true)
        XCTAssertEqual(intent.mustNotSpicy, true)
        XCTAssertEqual(intent.maxBudget, 30000)
    }

    /// Regression check against the REAL translated dataset (Task 8), not a hand-built fixture —
    /// this is the "port the 145-item dataset as a test fixture" requirement from the spec.
    func testFullSeedDatasetInvariants() throws {
        let schema = Schema([FoodCourt.self, Tenant.self, Menu.self, SearchHistory.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [config])
        let context = ModelContext(container)

        let foodCourts = FoodCourtSeed.create()
        TenantSeed.attach(to: foodCourts)
        for fc in foodCourts { context.insert(fc) }
        try context.save()

        let intermoda = foodCourts[3]
        XCTAssertEqual(intermoda.tenants.count, 18)

        for tenant in intermoda.tenants {
            let kidCount = tenant.menus.filter { $0.tags.isKidFriendly }.count
            let generalCount = tenant.menus.count - kidCount
            XCTAssertGreaterThanOrEqual(kidCount, 3, "\(tenant.name) must have >= 3 kid-friendly menu items")
            XCTAssertGreaterThanOrEqual(generalCount, 3, "\(tenant.name) must have >= 3 general menu items")
        }

        let totalMenus = intermoda.tenants.reduce(0) { $0 + $1.menus.count }
        XCTAssertEqual(totalMenus, 145)

        for fc in foodCourts[0...2] {
            XCTAssertTrue(fc.tenants.isEmpty, "\(fc.name) at \(fc.place) should have no tenants per this plan's seed decision")
        }

        // Safety spot-check across the full real dataset: allergen exclusion must never leak,
        // even at 145-item scale (mirrors the harness verification done earlier in this project).
        let allMenus = intermoda.tenants.flatMap(\.menus)
        let result = RecommendationEngine().recommend(
            menus: allMenus,
            intent: SearchIntent(avoidAllergens: [.peanut])
        )
        for item in result.items {
            XCTAssertFalse((item.menuItem.tags.allergens ?? []).contains(.peanut))
        }
    }

    /// Covers the 3 new SearchIntent hard filters added in Task 7 for manual-filter support
    /// (requireInstant/requireSpicy/minBudget) — none of these existed before the 2026-07-10
    /// scope expansion, so they need direct engine-level coverage, not just via the UI layer.
    func testNewHardFiltersInstantSpicyMinBudget() {
        let fc = makeFoodCourt()
        let tenant = makeTenant(name: "T", halal: .bersertifikat, foodCourt: fc)

        let instantCheap = makeMenu(name: "InstantCheap", price: 15000, tags: MenuTags(spicy: false, isInstant: true), tenant: tenant)
        let freshCheap = makeMenu(name: "FreshCheap", price: 15000, tags: MenuTags(spicy: false, isInstant: false), tenant: tenant)
        let spicyExpensive = makeMenu(name: "SpicyExpensive", price: 60000, tags: MenuTags(spicy: true, isInstant: false), tenant: tenant)

        let instantResult = RecommendationEngine().recommend(
            menus: [instantCheap, freshCheap, spicyExpensive],
            intent: SearchIntent(requireInstant: true)
        )
        XCTAssertEqual(instantResult.items.map(\.menuItem.name), ["InstantCheap"])

        let spicyResult = RecommendationEngine().recommend(
            menus: [instantCheap, freshCheap, spicyExpensive],
            intent: SearchIntent(requireSpicy: true)
        )
        XCTAssertEqual(spicyResult.items.map(\.menuItem.name), ["SpicyExpensive"])

        let minBudgetResult = RecommendationEngine().recommend(
            menus: [instantCheap, freshCheap, spicyExpensive],
            intent: SearchIntent(minBudget: 50000)
        )
        XCTAssertEqual(minBudgetResult.items.map(\.menuItem.name), ["SpicyExpensive"], "minBudget must exclude items below the floor and is never relaxed")
    }

    /// Covers SearchIntent.merged(withManual:) (Task 4) — the rule the spec's "Manual Filter →
    /// SearchIntent Mapping" section documents: safety fields OR-combine, everything else lets
    /// the manual side win on conflict.
    func testSearchIntentMergePrefersManualButUnionsSafety() {
        let textIntent = SearchIntent(
            wantCarbs: [.noodle],
            avoidAllergens: [.peanut],
            maxBudget: 20000,
            requireHalal: nil
        )
        let manualIntent = SearchIntent(
            wantCarbs: [.rice],
            avoidAllergens: [.shrimp],
            maxBudget: 50000,
            requireHalal: true
        )

        let merged = textIntent.merged(withManual: manualIntent)

        XCTAssertEqual(merged.wantCarbs, [.rice], "non-safety field: manual wins on conflict")
        XCTAssertEqual(merged.maxBudget, 50000, "non-safety field: manual wins on conflict")
        XCTAssertEqual(Set(merged.avoidAllergens ?? []), [.peanut, .shrimp], "safety field: union, neither side dropped")
        XCTAssertEqual(merged.requireHalal, true, "safety field: manual's true is never dropped even though text side was nil")
    }

    /// Covers SearchFilter.toSearchIntent() and FoodCategory.apply(to:) (Task 10) — the concrete
    /// mapping table from the spec, including the strict kidsPortion→forKid semantics (decision 10)
    /// and the .fish category's OR-match against both fish and shrimp (mirrors the old foodCategories rule).
    func testSearchFilterToSearchIntentCategoryMapping() {
        var filter = SearchFilter()
        filter.tags = [.kidsPortion, .halal]
        filter.category = .fish

        let intent = filter.toSearchIntent()

        XCTAssertEqual(intent.forKid, true, "kidsPortion tag maps to forKid (strict isKidFriendly), not a separate raw-portion filter")
        XCTAssertEqual(intent.requireHalal, true)
        XCTAssertEqual(intent.wantProteinHewani, [.fish, .shrimp], ".fish category must OR-match fish and shrimp")

        var priceFilter = SearchFilter()
        priceFilter.priceFilter = .between50And100
        let priceIntent = priceFilter.toSearchIntent()
        XCTAssertEqual(priceIntent.minBudget, 50000)
        XCTAssertEqual(priceIntent.maxBudget, 100000)
    }
}
