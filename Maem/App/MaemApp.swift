//
//  MaemApp.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI
import SwiftData

@main
struct MaemApp: App {

    let container: ModelContainer

    init() {
        container = Self.makeContainer()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}

private extension MaemApp {

    static func makeContainer() -> ModelContainer {

        let schema = Schema([
            FoodCourt.self,
            Tenant.self,
            Menu.self,
            SearchHistory.self
        ])

        let configuration = ModelConfiguration(schema: schema)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {

            // The store is seeded dummy data, not real user data - if automatic
            // lightweight migration can't handle a schema change (e.g. a new
            // non-optional attribute with no default on existing rows), it's
            // safer to wipe and reseed than leave the app permanently stuck
            // with a persistent store that will never load.
            print("ModelContainer failed to load (\(error)) - deleting incompatible store and retrying")

            let url = configuration.url
            try? FileManager.default.removeItem(at: url)
            try? FileManager.default.removeItem(at: url.appendingPathExtension("shm"))
            try? FileManager.default.removeItem(at: url.appendingPathExtension("wal"))

            guard let recovered = try? ModelContainer(for: schema, configurations: [configuration]) else {
                fatalError("ModelContainer could not be created even after deleting the incompatible store: \(error)")
            }

            return recovered
        }

    }

}
