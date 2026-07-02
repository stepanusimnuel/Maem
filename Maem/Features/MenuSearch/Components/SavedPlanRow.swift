import SwiftUI

struct SavedPlanRow: View {

    let item: SavedPlanItem

    var body: some View {

        VStack(alignment: .leading, spacing: 4) {

            Text(item.menuItem?.name ?? "Menu tidak tersedia")
                .font(.headline)

            if let tenant = item.menuItem?.tenant {

                Text(tenant.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

            }

            if let price = item.menuItem?.price {

                Text("Rp\(price)")
                    .font(.caption)

            }

        }
        .padding(.vertical, 4)

    }

}

#Preview {

    SavedPlanRow(
        item: SavedPlanItem(
            menuItem: MenuItem(
                name: "Ayam Geprek + Nasi",
                price: 22000,
                carbs: [.nasi],
                proteinHewani: [.ayam],
                proteinNabati: [],
                veggies: [],
                toppings: [.sambal],
                allergens: [],
                isPedas: true,
                texture: .renyah,
                mealCategory: .makananBerat,
                cookMethod: .goreng,
                portion: .reguler,
                isInstant: false,
                containsPork: false,
                containsAlcohol: false
            )
        )
    )

}
