# NoteQ - Your Daily Notes Companion 📝

Aplikasi mobile berbasis Flutter untuk mencatat dan mengelola pengingat harian Anda dengan mudah.

---

## 🌟 Fitur Unggulan

* **Pencatatan Cepat & Mudah:** Buat catatan dan pengingat dalam hitungan detik dengan antarmuka yang intuitif.
* **Pengingat Fleksibel:** Atur pengingat untuk tugas-tugas penting agar tidak ada yang terlewat.
* **Sinkronisasi Real-time:** Data Anda tersimpan aman dan tersinkronisasi di cloud berkat Firebase, dapat diakses dari perangkat mana pun.
* **Antarmuka Bersih & Minimalis:** Fokus pada esensi pencatatan tanpa gangguan visual.

---

## 🛠️ Teknologi yang Digunakan

* **Flutter:** Framework UI open-source dari Google untuk membangun aplikasi mobile yang indah secara *natively* dari satu basis kode.
* **Firebase:** Platform pengembangan aplikasi dari Google yang menyediakan berbagai layanan *backend* seperti:
    * **Firestore:** Database NoSQL *cloud-hosted* untuk menyimpan dan menyinkronkan data.
    * **Authentication:** Mengelola otentikasi pengguna (misalnya, *login* anonim, email/password, Google Sign-In, dll. - *sebutkan yang Anda pakai*).

---

## 🚀 Instalasi & Menjalankan Proyek

Ikuti langkah-langkah di bawah ini untuk menjalankan NoteQ di lingkungan pengembangan Anda:

### Prasyarat

Pastikan Anda telah menginstal yang berikut:

* [**Flutter SDK**](https://flutter.dev/docs/get-started/install) (versi rekomendasi: `flutter doctor`)
* **Editor Kode:** [VS Code](https://code.visualstudio.com/download) dengan ekstensi Flutter dan Dart, atau Android Studio.
* **Perangkat Virtual/Fisik:** Emulator Android/iOS atau perangkat fisik yang terhubung.

### Langkah-langkah

1.  **Kloning Repositori:**
    ```bash
    git clone [https://github.com/KokoYuardiA/NoteQ.git](https://github.com/KokoYuardiA/NoteQ.git)
    cd NoteQ
    ```

2.  **Instal Dependensi:**
    ```bash
    flutter pub get
    ```

3.  **Konfigurasi Firebase:**
    * Buat proyek baru di [Firebase Console](https://console.firebase.google.com/).
    * Tambahkan aplikasi Android dan iOS ke proyek Firebase Anda.
    * Unduh file `google-services.json` (untuk Android) dan `GoogleService-Info.plist` (untuk iOS) dan letakkan di direktori yang sesuai (`android/app/` dan `ios/Runner/`).
    * Aktifkan layanan Firebase yang digunakan (misalnya, Firestore, Authentication) di Firebase Console Anda.

4.  **Jalankan Aplikasi:**
    ```bash
    flutter run
    ```

---

## 🤝 Kontribusi

Sangat dipersilakan untuk berkontribusi pada proyek NoteQ! Jika Anda menemukan *bug* atau memiliki ide untuk fitur baru, silakan buka *issue* atau kirimkan *pull request*.

---

## 🧑‍💻 Pengembang

**Koko Yuardi** - [GitHub](https://github.com/KokoYuardiA)
