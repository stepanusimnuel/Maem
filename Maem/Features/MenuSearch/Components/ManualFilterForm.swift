import SwiftUI

struct ManualFilterForm: View {

    @Binding var filters: ManualFilterState
    let onSearch: () -> Void

    var body: some View {

        Form {

            Section("Budget") {

                Stepper(
                    value: Binding(
                        get: { filters.maxBudget ?? 20000 },
                        set: { filters.maxBudget = $0 }
                    ),
                    in: 5000...100000,
                    step: 5000
                ) {
                    Text(filters.maxBudget.map { "Maksimal Rp\($0)" } ?? "Tanpa batas budget")
                }

                if filters.maxBudget != nil {

                    Button("Hapus batas budget") {
                        filters.maxBudget = nil
                    }
                    .font(.caption)

                }

            }

            Section("Kategori") {

                Picker("Kategori makanan", selection: $filters.mealCategory) {
                    Text("Semua").tag(MealCategory?.none)
                    ForEach(MealCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(MealCategory?.some(category))
                    }
                }

            }

            Section("Preferensi") {

                Toggle("Untuk anak", isOn: $filters.forKid)
                Toggle("Tidak pedas", isOn: $filters.mustNotSpicy)
                Toggle("Halal", isOn: $filters.requireHalal)

            }

            Section("Hindari alergen") {

                ForEach(Allergen.allCases, id: \.self) { allergen in

                    Button {

                        if filters.avoidAllergens.contains(allergen) {
                            filters.avoidAllergens.remove(allergen)
                        } else {
                            filters.avoidAllergens.insert(allergen)
                        }

                    } label: {

                        Label(
                            allergen.rawValue,
                            systemImage: filters.avoidAllergens.contains(allergen)
                                ? "checkmark.circle.fill"
                                : "circle"
                        )

                    }
                    .buttonStyle(.plain)

                }

            }

            Section {

                Button(action: onSearch) {
                    Text("Cari Menu")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

            }

        }

    }

}

#Preview {
    ManualFilterForm(filters: .constant(ManualFilterState()), onSearch: {})
}
