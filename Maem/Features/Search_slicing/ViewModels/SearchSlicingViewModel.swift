//
//  SearchSlicingViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation

@Observable
final class SearchSlicingViewModel {

    var searchText = ""
    var showResult = false

    var recentSearches: [SearchHistory] = []

    /// 2 picked from `easySuggestions` + 3 from `naturalLanguageSuggestions`, shuffled
    /// together - recomputed each time a fresh SearchSlicingViewModel is created (i.e.
    /// each time the user opens the search page, since it's pushed fresh via
    /// NavigationLink from ExploreView, not kept alive as a persistent tab).
    let suggestions: [String]

    let categories: [FoodCategory] = [
        .rice, .noodle, .fish, .chicken, .snack, .soupy, .drink, .dessert, .porridge
    ]

    init() {
        let pickedEasy = Self.easySuggestions.shuffled().prefix(2)
        let pickedNaturalLanguage = Self.naturalLanguageSuggestions.shuffled().prefix(3)
        suggestions = (pickedEasy + pickedNaturalLanguage).shuffled()
    }

    /// Short, obviously-easy dish-name queries (e.g. "nasi ayam").
    static let easySuggestions = [
        "nasi ayam",
        "mie bakso",
        "nasi goreng",
        "ayam bakar",
        "soto ayam",
        "bubur ayam",
        "mie ayam",
        "nasi kambing",
        "sup ayam",
        "nasi padang"
    ]

    /// Attribute-based, close-to-natural-language queries (e.g. constraints on
    /// budget, spice, halal, allergen, kid-friendliness, cook method).
    static let naturalLanguageSuggestions = [
        "nasi uduk buat anak gak pedes 20rb",
        "menu yang gak berminyak",
        "cemilan enak",
        "ayam goreng buat anak tidak pedas",
        "cari yang halal di bawah 25rb",
        "menu tanpa kacang buat yang alergi",
        "makanan berkuah yang bikin anget",
        "sarapan sehat gak bikin begah",
        "menu kukus buat diet",
        "jajanan buat ngemil sore-sore",
        "nasi kuning buat balita gak pedes",
        "minuman seger di bawah 15rb"
    ]

    func fetchRecentSearches(repository: SearchHistoryRepositoryProtocol) {
        do {
            recentSearches = try repository.getRecent(limit: 5)
        } catch {
            print("Gagal mengambil riwayat: \(error.localizedDescription)")
        }
    }

    func saveSearchQuery(_ text: String, repository: SearchHistoryRepositoryProtocol) {
        do {
            try repository.save(query: text)
            fetchRecentSearches(repository: repository)
        } catch {
            print("Gagal menyimpan riwayat: \(error.localizedDescription)")
        }
    }
}
