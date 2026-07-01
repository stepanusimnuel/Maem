//
//  ContentView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 01/07/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext)
    private var modelContext

    var body: some View {
        NavigationStack {
            ExploreView()
        }
        .task {
            do {
                try DummySeeder.seedIfNeeded(context: modelContext)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(for: FoodCourt.self)
}
