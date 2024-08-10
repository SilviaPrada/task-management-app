# Task Management App

Aplikasi manajemen tugas sederhana menggunakan Flutter. Aplikasi ini dapat menampilkan daftar tugas, menambahkan tugas baru, mengedit tugas yang ada, dan menghapus tugas. Semua data tugas harus disimpan dan diambil melalui REST API.

## Cara Menjalankan

1. **Extract Zip File & Buka Project**  
   Extract file yang telah diunduh. Setelah itu, buka folder project menggunakan VSCode.

2. **Install Dependensi Flutter**  
   Jalankan perintah `flutter pub get` di terminal atau buka file `pubspec.yaml` dan klik "Get Packages" untuk menginstal semua dependensi yang diperlukan.

3. **Install Dependensi Project API**  
   Arahkan terminal ke direktori `task-management-api` dengan perintah `cd task-management-api`. Kemudian, jalankan `npm install` untuk menginstal semua dependensi yang dibutuhkan untuk API.

4. **Jalankan API**  
   Di terminal, masih dalam direktori `task-management-api`, jalankan perintah `npm start` untuk memulai server API.

5. **Jalankan Aplikasi Flutter**  
   Kembali ke direktori root project dengan perintah `cd ..`. Kemudian, jalankan perintah `flutter run` di terminal atau pilih opsi "Run" dari file `main.dart` di VSCode untuk menjalankan aplikasi Flutter.


# Task Management App

Aplikasi manajemen tugas sederhana menggunakan Flutter. Aplikasi ini dapat menampilkan daftar tugas, menambahkan tugas baru, mengedit tugas yang ada, dan menghapus tugas. Semua data tugas harus disimpan dan diambil melalui REST API.

## Fitur dan Penggunaan

| Screenshot | Keterangan |
|------------|------------|
| <img src="documentation/home.png" alt="Screenshot of home" width="250"/> | Tampilan utama aplikasi yang menampilkan daftar tugas yang ada. |
| <img src="documentation/add_task.png" alt="Screenshot of add_task" width="250"/> | Formulir untuk menambahkan tugas baru. Pengguna dapat memasukkan judul dan deskripsi tugas. |
| <img src="documentation/home_after_add.png" alt="Screenshot of home_after_add" width="250"/> | Tampilan utama setelah tugas baru berhasil ditambahkan. Tugas baru muncul dalam daftar tugas. |
| <img src="documentation/filter_completed.png" alt="Screenshot of filter_completed" width="250"/> | Tampilan ketika daftar tugas difilter untuk hanya menampilkan tugas yang telah diselesaikan. |
| <img src="documentation/filter_incomplete.png" alt="Screenshot of filter_incomplete" width="250"/> | Tampilan ketika daftar tugas difilter untuk hanya menampilkan tugas yang belum diselesaikan. |
| <img src="documentation/search.png" alt="Screenshot of search" width="250"/> | Fitur pencarian yang memungkinkan pengguna mencari tugas tertentu berdasarkan kata kunci. |
| <img src="documentation/update_task.png" alt="Screenshot of update_task" width="250"/> | Formulir untuk mengedit tugas yang ada. Pengguna dapat memperbarui judul dan deskripsi tugas. |
| <img src="documentation/delete.png" alt="Screenshot of delete" width="250"/> | Konfirmasi penghapusan tugas yang menanyakan apakah pengguna yakin ingin menghapus tugas. |
| <img src="documentation/delete_success.png" alt="Screenshot of delete_success" width="250"/> | Tampilan setelah tugas berhasil dihapus dari daftar tugas. |
| <img src="documentation/update.png" alt="Screenshot of update_task" width="250"/> | Tampilan saat salah satu list tugas diklik untuk mengedit judul dan status tugas. |
| <img src="documentation/update_success.png" alt="Screenshot of update_success" width="250"/> | Tampilan setelah tugas berhasil diupdate. |



