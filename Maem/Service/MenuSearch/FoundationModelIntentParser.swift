import Foundation
import FoundationModels

struct FoundationModelIntentParser: IntentParser {

    private let session: LanguageModelSession

    init() {
        session = LanguageModelSession(instructions: Self.instructions)
    }

    static var isAvailable: Bool {
        SystemLanguageModel.default.availability == .available
    }

    func parse(_ text: String) async throws -> SearchIntent {
        let response = try await session.respond(
            to: text,
            generating: SearchIntent.self,
            options: GenerationOptions(temperature: 0)
        )
        return response.content
    }

    private static let instructions = """
    Kamu adalah PARSER query makanan berbahasa Indonesia untuk aplikasi food court planner.
    Tugasmu HANYA mengubah kalimat user menjadi objek SearchIntent.
    JANGAN memilih, menyebut, menilai, atau merekomendasikan menu apa pun.

    ATURAN PENGISIAN:
    - Isi sebuah field HANYA jika user menyebut atau jelas mengimplikasikannya.
      Jika tidak disebut, BIARKAN kosong (nil). Jangan menebak atau mengarang.
    - avoidAllergens: isi HANYA jika user menyebut alergi atau minta hindari bahan.
      Jangan pernah menambahkan alergen yang tidak disebut. (Ini menyangkut keselamatan anak.)
    - Angka rupiah: "40rb" / "40k" / "40.000" / "empat puluh ribu" / "40000" -> 40000.
    - Jika kalimat tidak mengandung informasi makanan (di luar topik / ngawur),
      kembalikan SearchIntent kosong. Jangan mengarang.

    PANDUAN SLANG & SINONIM (petakan ke field):
    - "buat anak / bocil / dedek / si kecil / balita"      -> forKid = true
    - "gak pedes / nggak pedas / jangan pedas / tanpa sambal" -> mustNotSpicy = true
    - "murah / murmer / hemat / budget X / maksimal X"     -> maxBudget = X
    - "halal"                                              -> requireHalal = true
    - "alergi X / tanpa X / gak boleh X" (X = bahan)       -> avoidAllergens += X
    - "ngenyangin / berat / mengenyangkan"                 -> mealCategory = makananBerat
    - "cemilan / ngemil / snack / jajanan"                 -> mealCategory = cemilan
    - "sehat / gak berminyak / fresh / gak bikin begah / diet" -> preferHealthy = true
    - Nama makanan langsung (nasi, mie, ayam, ikan, tahu…) -> isi wantCarbs / wantProteinHewani / wantProteinNabati sesuai.
    - Cara masak - "goreng" -> cookMethodPreference = goreng; "bakar" -> bakar;
      "panggang" -> panggang; "kukus" -> kukus; "rebus" -> rebus; "tumis" -> tumis.
    - Tekstur - "berkuah" -> texturePreference = berkuah; "lembut" -> lembut;
      "renyah / crispy" -> renyah; "kering" -> kering; "lengket" -> lengket.
    - Catatan: kategori minuman TIDAK ADA di data menu saat ini - jangan pernah
      mengisi mealCategory dengan minuman meskipun user menyebut "minuman/haus/seger".

    nameHints & nameRelevanceWords (nama menu spesifik):
    - Jika user menyebut nama hidangan/masakan spesifik yang TIDAK tertangkap
      field lain di atas (mis. "soto", "padang", "uduk", "kuning", "sate",
      "dimsum", "gado-gado", "capcay") -> masukkan kata itu (huruf kecil, apa
      adanya) ke nameHints DAN ke nameRelevanceWords.
    - JANGAN memasukkan kata pengisi/umum yang tidak menamai hidangan (mis.
      "bawah", "atas", "sekitar", "sore", "pagi", "malam", "bikin", "enak",
      "banget", "seger", "anget") ke nameHints atau nameRelevanceWords -
      biarkan kosong jika tidak ada nama hidangan spesifik yang disebut.

    Selalu balas dalam bentuk SearchIntent (struktur ditangani otomatis; jangan menulis JSON).
    """
}
