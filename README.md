Folder

App

Berisi entry point aplikasi (MaemApp) dan root view (ContentView).

Features: berisi seluruh fitur aplikasi.

- Views → Tampilan SwiftUI.
- ViewModels → Mengelola state dan menghubungkan View dengan Services.
- Components → Reusable UI yang dapat digunakan di lebih dari satu View.

Models: berisi model aplikasi menggunakan SwiftData.

Model hanya mendefinisikan:

- Attributes
- Relationships
- Initializer

Services: business logic aplikasi.

- Location → Mengelola akses dan pembaruan lokasi pengguna menggunakan Core Location.
- Repository → Satu-satunya layer yang berkomunikasi dengan SwiftData.
- Seeder → Mengisi dummy data saat aplikasi pertama kali dijalankan.

Rules

- View hanya bertanggung jawab menampilkan UI dan menerima input dari pengguna.
- Business logic berada di ViewModel atau Services, bukan di View.
- ViewModel tidak boleh membaca atau menulis SwiftData secara langsung. Seluruh operasi database harus melalui Repository.
- Reusable UI harus dipindahkan ke folder Components.
- Setiap file sebaiknya memiliki satu tanggung jawab (Single Responsibility Principle).
