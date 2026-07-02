import SwiftUI
import SwiftData

struct MenuSearchView: View {

    @Environment(\.modelContext)
    private var modelContext

    let foodCourt: FoodCourt

    @State
    private var viewModel = MenuSearchViewModel()

    @State
    private var showSavedPlan = false

    var body: some View {

        VStack(spacing: 0) {

            if viewModel.useManualFilter {

                ManualFilterForm(filters: $viewModel.manualFilters) {
                    Task { await viewModel.search() }
                }

            } else {

                searchBar

            }

            resultsList

        }
        .navigationTitle("Cari Menu")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarTrailing) {

                Button {
                    showSavedPlan = true
                } label: {
                    Image(systemName: "bookmark")
                }

            }

        }
        .sheet(isPresented: $showSavedPlan) {

            NavigationStack {
                SavedPlanView(repository: SavedPlanRepository(context: modelContext))
            }

        }
        .task {

            viewModel.load(
                foodCourt: foodCourt,
                menuRepo: MenuRepository(context: modelContext),
                savedRepo: SavedPlanRepository(context: modelContext)
            )

        }
        .alert(
            "Terjadi Masalah",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )
        ) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }

    }

}

private extension MenuSearchView {

    var searchBar: some View {

        HStack {

            TextField(
                "mis. nasi ayam buat anak, gak pedes, 30rb",
                text: $viewModel.searchText
            )
            .textFieldStyle(.roundedBorder)

            Button("Cari") {
                Task { await viewModel.search() }
            }
            .disabled(viewModel.searchText.isEmpty || viewModel.isLoading)

        }
        .padding()

    }

    @ViewBuilder
    var resultsList: some View {

        if viewModel.isLoading {

            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if let result = viewModel.result {

            if result.items.isEmpty {

                ContentUnavailableView(
                    "Tidak ada menu cocok",
                    systemImage: "fork.knife",
                    description: Text(result.bindingConstraint ?? "Coba ubah kriteria pencarian.")
                )

            } else {

                List {

                    if !result.relaxationNotes.isEmpty {

                        Section {
                            ForEach(result.relaxationNotes, id: \.self) { note in
                                Text(note)
                                    .font(.caption)
                                    .foregroundStyle(.orange)
                            }
                        }

                    }

                    ForEach(result.items) { item in

                        MenuResultCard(
                            item: item,
                            isSaved: viewModel.savedIDs.contains(item.menuItem.persistentModelID),
                            onToggleSave: {
                                viewModel.toggleSave(
                                    item,
                                    savedRepo: SavedPlanRepository(context: modelContext)
                                )
                            }
                        )
                        .listRowSeparator(.hidden)

                    }

                }
                .listStyle(.plain)

            }

        } else {

            ContentUnavailableView(
                "Cari menu yuk",
                systemImage: "magnifyingglass",
                description: Text("Ketik apa yang ingin dicari, misalnya \"nasi ayam buat anak, gak pedes\".")
            )

        }

    }

}

#Preview {

    NavigationStack {

        MenuSearchView(
            foodCourt: FoodCourt(
                name: "Pasar Modern Intermoda BSD",
                address: "Jl. Raya Cisauk, BSD City",
                floor: "Ground",
                latitude: -6.3029,
                longitude: 106.6525
            )
        )

    }

}
