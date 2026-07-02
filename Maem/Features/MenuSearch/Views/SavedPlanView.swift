import SwiftUI

struct SavedPlanView: View {

    @Environment(\.dismiss)
    private var dismiss

    let repository: SavedPlanRepositoryProtocol

    @State
    private var items: [SavedPlanItem] = []

    @State
    private var errorMessage: String?

    var body: some View {

        List {

            if items.isEmpty {

                ContentUnavailableView(
                    "Belum ada menu tersimpan",
                    systemImage: "bookmark"
                )

            } else {

                ForEach(items) { item in
                    SavedPlanRow(item: item)
                }
                .onDelete(perform: delete)

            }

        }
        .navigationTitle("Menu Tersimpan")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {

            ToolbarItem(placement: .topBarLeading) {
                Button("Tutup") { dismiss() }
            }

        }
        .task {
            load()
        }
        .alert(
            "Terjadi Masalah",
            isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )
        ) {
            Button("OK") { errorMessage = nil }
        } message: {
            Text(errorMessage ?? "")
        }

    }

}

private extension SavedPlanView {

    func load() {

        do {
            items = try repository.getAll()
        } catch {
            errorMessage = "Gagal memuat menu tersimpan."
        }

    }

    func delete(at offsets: IndexSet) {

        for index in offsets {

            do {
                try repository.remove(items[index])
            } catch {
                errorMessage = "Gagal menghapus menu."
            }

        }

        load()

    }

}

private struct PreviewSavedPlanRepository: SavedPlanRepositoryProtocol {
    func getAll() throws -> [SavedPlanItem] { [] }
    func save(_ menuItem: MenuItem) throws {}
    func remove(_ item: SavedPlanItem) throws {}
}

#Preview {

    NavigationStack {
        SavedPlanView(repository: PreviewSavedPlanRepository())
    }

}
