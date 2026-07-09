//
//  SearchSlicingViewModel.swift
//  Maem
//
//  Created by Stepanus Imanuel on 06/07/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class SearchSlicingViewModel {

    var searchText = ""
    var showResult = false

    var recentSearches: [SearchHistory] = []

    let suggestions = [
        "Makanan yang bukan junk food",
        "Minuman hangat untuk anak",
        "Makanan berprotein tinggi"
    ]

    let categories: [FoodCategory] = [
        .rice, .noodle, .fish, .chicken, .snack, .soupy, .drink, .dessert, .porridge
    ]

    func fetchRecentSearches(context: ModelContext) {
        let descriptor = FetchDescriptor<SearchHistory>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)] // Riwayat terbaru di paling atas
        )
        do {
            // Membatasi maksimum riwayat yang ditampilkan (misal 5 riwayat teratas)
            let allHistories = try context.fetch(descriptor)
            self.recentSearches = Array(allHistories.prefix(5))
        } catch {
            print("Gagal mengambil riwayat: \(error.localizedDescription)")
        }
    }

    func saveSearchQuery(_ text: String, context: ModelContext) {
        let cleanText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanText.isEmpty else { return }

        // Cek jika teks sudah pernah dicari sebelumnya
        let predicate = #Predicate<SearchHistory> { $0.text == cleanText }
        var descriptor = FetchDescriptor<SearchHistory>(predicate: predicate)
        descriptor.fetchLimit = 1

        do {
            if let existingHistory = try context.fetch(descriptor).first {
                // Perbarui waktu ke waktu sekarang agar naik ke baris paling depan
                existingHistory.timestamp = Date()
            } else {
                // Buat data riwayat baru
                let newHistory = SearchHistory(text: cleanText)
                context.insert(newHistory)
            }
            try context.save()
            fetchRecentSearches(context: context) // Segarkan tampilan setelah menyimpan
        } catch {
            print("Gagal menyimpan riwayat: \(error.localizedDescription)")
        }
    }
}
