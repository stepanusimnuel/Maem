import SwiftUI

struct MenuResultCard: View {

    let item: ScoredMenuItem
    let isSaved: Bool
    let onToggleSave: () -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            HStack(alignment: .top) {

                VStack(alignment: .leading, spacing: 4) {

                    Text(item.menuItem.name)
                        .font(.headline)

                    Text(item.tenant.name)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                }

                Spacer()

                Button(action: onToggleSave) {
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                }
                .buttonStyle(.plain)

            }

            Text("Rp\(item.menuItem.price)")
                .font(.subheadline.bold())

            HStack(spacing: 8) {

                if item.isKidFriendlyMatch {

                    Label("Ramah anak", systemImage: "figure.and.child.holdinghands")
                        .font(.caption)
                        .foregroundStyle(.green)

                }

                if let halalWarning = item.halalWarning {

                    Label(halalWarning, systemImage: "exclamationmark.triangle")
                        .font(.caption)
                        .foregroundStyle(.orange)

                }

            }

        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {

            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.2))

        }

    }

}

#Preview {

    MenuResultCard(
        item: ScoredMenuItem(
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
            ),
            tenant: Tenant(name: "Ayam Bu Tini", halalStatus: .bersertifikat, googleMapsLink: ""),
            score: 5,
            halalWarning: nil,
            isKidFriendlyMatch: false
        ),
        isSaved: false,
        onToggleSave: {}
    )
    .padding()

}
