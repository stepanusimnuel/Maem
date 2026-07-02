import Foundation

protocol IntentParser {
    func parse(_ text: String) async throws -> SearchIntent
}
