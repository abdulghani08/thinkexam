# 04_UI_UX_SPECIFICATION.md

Version: 1.0

Project: Easy Exam

---

# 1. Purpose

Dokumen ini mendefinisikan standar User Interface (UI) dan User Experience (UX) untuk aplikasi **Easy Exam**.

Tujuannya adalah memastikan seluruh tampilan aplikasi memiliki desain yang konsisten, mudah digunakan, responsif, dan sesuai untuk pengguna utama yaitu Guru (Admin) dan Siswa Sekolah Dasar.

Dokumen ini menjadi acuan utama bagi AI Agent maupun developer dalam membangun seluruh halaman aplikasi.

---

# 2. Design Principles

Seluruh desain Easy Exam harus mengikuti prinsip berikut:

* Sederhana dan mudah dipahami.
* Fokus pada kemudahan penggunaan.
* Konsisten pada seluruh halaman.
* Mengurangi distraksi selama ujian.
* Responsif pada berbagai ukuran layar.
* Mengutamakan aksesibilitas.
* Menggunakan Material Design 3 sebagai dasar desain.

---

# 3. Target Users

## Student (Mobile)

Karakteristik:

* Usia 6–12 tahun.
* Menggunakan smartphone Android.
* Membutuhkan tampilan sederhana.
* Tombol mudah ditekan.
* Teks mudah dibaca.

---

## Admin (Web)

Karakteristik:

* Guru.
* Menggunakan laptop atau desktop.
* Membutuhkan tampilan seperti Google Forms.
* Fokus pada efisiensi input soal dan analisis hasil.

---

# 4. Color Palette

Gunakan warna yang lembut dan profesional.

## Primary Color

* Biru (Blue)

Digunakan untuk:

* Tombol utama.
* App Bar.
* Ikon utama.

---

## Secondary Color

* Hijau

Digunakan untuk:

* Status berhasil.
* Nilai baik.
* Konfirmasi.

---

## Warning Color

* Oranye

Digunakan untuk:

* Peringatan waktu.
* Informasi penting.

---

## Error Color

* Merah

Digunakan untuk:

* Kesalahan.
* Validasi gagal.
* Pelanggaran ujian.

---

## Background

* Putih atau abu-abu sangat terang.

---

# 5. Typography

Gunakan font bawaan Material Design atau font yang mudah dibaca.

Standar:

* Heading
* Title
* Subtitle
* Body
* Caption

Aturan:

* Hindari penggunaan lebih dari dua jenis font.
* Gunakan ukuran teks yang nyaman dibaca oleh siswa sekolah dasar.

---

# 6. Iconography

Gunakan ikon Material Design.

Ikon harus:

* Mudah dipahami.
* Konsisten.
* Tidak menggunakan ikon dekoratif yang tidak memiliki fungsi.

---

# 7. Layout Standards

## Mobile

Menggunakan satu kolom.

Urutan halaman:

* App Bar
* Content
* Bottom Action (jika diperlukan)

---

## Web Admin

Menggunakan layout dua bagian:

* Sidebar
* Content Area

---

# 8. Navigation

## Student

Navigasi sederhana.

Halaman utama:

* Login
* Dashboard
* Exam
* History
* Profile

Selama ujian:

* Tidak boleh berpindah ke halaman lain tanpa mengikuti aturan sistem.

---

## Admin

Sidebar Navigation:

* Dashboard
* Exams
* Questions
* Students
* Results
* Settings

---

# 9. Component Standards

Komponen yang digunakan harus konsisten.

Minimal meliputi:

* Primary Button
* Secondary Button
* Text Field
* Dropdown
* Checkbox
* Radio Button
* Card
* Dialog
* Snackbar
* Loading Indicator

Seluruh komponen harus menggunakan gaya visual yang sama.

---

# 10. Dashboard Design

## Student Dashboard

Menampilkan:

* Foto profil.
* Nama siswa.
* Kelas.
* Daftar ujian yang tersedia.
* Status ujian.

Dashboard harus sederhana dan mudah dipahami.

---

## Admin Dashboard

Menampilkan:

* Total ujian.
* Total siswa.
* Total guru.
* Statistik pelaksanaan ujian.
* Grafik hasil ujian.
* Aktivitas terbaru.

---

# 11. Exam Interface

Halaman ujian harus menjadi fokus utama aplikasi.

Ketentuan:

* Menampilkan satu soal per halaman.
* Nomor soal ditampilkan melalui sidebar.
* Timer selalu terlihat.
* Progress ujian selalu terlihat.
* Tombol Next dan Previous mudah dijangkau.
* Jawaban tersimpan otomatis.

Selama ujian:

* Tidak ada elemen yang mengganggu konsentrasi siswa.

---

# 12. Forms Design

Seluruh form mengikuti standar berikut:

* Label jelas.
* Placeholder seperlunya.
* Validasi langsung ditampilkan.
* Error mudah dipahami.
* Wajib menandai field yang harus diisi.

---

# 13. Loading State

Seluruh proses yang membutuhkan waktu harus memiliki indikator loading.

Gunakan:

* Circular Progress Indicator.
* Linear Progress Indicator.
* Skeleton Loading (jika diperlukan).

---

# 14. Empty State

Jika tidak ada data, tampilkan halaman Empty State.

Contoh:

* Belum ada ujian.
* Belum ada hasil.
* Belum ada siswa.

Gunakan ilustrasi sederhana dan pesan yang mudah dipahami.

---

# 15. Error State

Jika terjadi kesalahan:

* Tampilkan pesan yang jelas.
* Hindari istilah teknis.
* Berikan opsi untuk mencoba kembali jika memungkinkan.

---

# 16. Responsive Design

Aplikasi harus mendukung:

## Mobile

* Smartphone kecil.
* Smartphone besar.
* Tablet (opsional).

## Web

* Laptop.
* Desktop.
* Resolusi Full HD.

---

# 17. Accessibility

Desain harus mempertimbangkan aksesibilitas.

Aturan:

* Kontras warna yang baik.
* Ukuran tombol mudah ditekan.
* Ukuran teks mudah dibaca.
* Fokus keyboard tersedia pada Web Admin.

---

# 18. Animation Standards

Animasi digunakan secukupnya.

Gunakan animasi untuk:

* Perpindahan halaman.
* Dialog.
* Snackbar.
* Loading.

Hindari animasi yang berlebihan selama ujian.

---

# 19. Notification Design

Gunakan tiga jenis notifikasi:

* Success
* Warning
* Error

Pesan harus singkat, jelas, dan mudah dipahami.

---

# 20. Consistency Rules

Seluruh halaman harus konsisten dalam:

* Warna.
* Typography.
* Jarak (Spacing).
* Radius.
* Ikon.
* Tombol.
* Dialog.
* Animasi.

Tidak diperbolehkan membuat komponen baru apabila komponen serupa sudah tersedia.

---

# 21. UX Principles During Exam

Selama sesi ujian:

* Fokus siswa hanya pada soal.
* Gangguan visual harus diminimalkan.
* Navigasi mudah dipahami.
* Timer selalu terlihat.
* Status penyimpanan jawaban ditampilkan.
* Perubahan jawaban langsung tersimpan otomatis.
* Konfirmasi hanya ditampilkan untuk tindakan penting seperti Submit.

---

# 22. Definition of Done

Implementasi UI/UX dianggap selesai apabila:

* Seluruh halaman mengikuti Material Design 3.
* Tampilan konsisten pada seluruh aplikasi.
* Responsif pada perangkat yang didukung.
* Mudah digunakan oleh siswa sekolah dasar.
* Dashboard Admin efisien untuk guru.
* Tidak terdapat inkonsistensi komponen.
* Seluruh state (Loading, Empty, Error, Success) telah diimplementasikan.
* Pengalaman ujian fokus, sederhana, dan minim distraksi.
