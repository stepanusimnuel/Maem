//
//  SearchHistory.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import Foundation
import SwiftData

@Model
final class SearchHistory {
    @Attribute(.unique) var text: String
    var timestamp: Date

    init(text: String, timestamp: Date = Date()) {
        self.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        self.timestamp = timestamp
    }
}

