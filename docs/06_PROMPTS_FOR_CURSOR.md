# 06_PROMPTS_FOR_CURSOR.md

Version: 1.0

Project: Easy Exam

---

# Purpose

Dokumen ini berisi kumpulan prompt standar yang digunakan untuk berinteraksi dengan AI Agent di Cursor selama pengembangan aplikasi Easy Exam.

Semua prompt mengacu pada dokumentasi proyek berikut:

* `00_AI_AGENT_RULES.md`
* `02_SOFTWARE_REQUIREMENT_SPECIFICATION.md`
* `03_DATABASE_DESIGN.md`
* `04_UI_UX_SPECIFICATION.md`
* `05_DEVELOPMENT_ROADMAP.md`

AI Agent wajib membaca dan mengikuti dokumen tersebut sebelum melakukan implementasi.

---

# Prompt 1 — Project Initialization

Gunakan prompt ini ketika memulai proyek dari awal.

```
Baca seluruh dokumentasi proyek Easy Exam terlebih dahulu.

Ikuti aturan pada:
- 00_AI_AGENT_RULES.md
- 02_SOFTWARE_REQUIREMENT_SPECIFICATION.md
- 03_DATABASE_DESIGN.md
- 04_UI_UX_SPECIFICATION.md
- 05_DEVELOPMENT_ROADMAP.md

Tugas Anda adalah memulai Phase 1 sesuai Development Roadmap.

Jangan membuat fitur apa pun di luar Phase 1.

Gunakan Clean Architecture.

Gunakan Riverpod.

Gunakan GoRouter.

Gunakan Firebase.

Setelah selesai, tampilkan:

1. Struktur folder.
2. Daftar package.
3. File yang dibuat.
4. Penjelasan singkat setiap folder.
5. Checklist pekerjaan yang telah selesai.
```

---

# Prompt 2 — Continue Current Phase

Gunakan ketika melanjutkan pekerjaan pada fase yang sedang berjalan.

```
Lanjutkan pengembangan Easy Exam.

Jangan mengubah kode yang sudah stabil tanpa alasan yang jelas.

Ikuti seluruh dokumentasi proyek.

Fokus hanya pada phase yang sedang dikerjakan.

Jangan mengerjakan phase berikutnya.

Jika terdapat dependency yang belum selesai, selesaikan terlebih dahulu.

Di akhir pekerjaan tampilkan:

- Progress
- File yang berubah
- File baru
- Checklist pekerjaan
- Sisa pekerjaan pada phase ini
```

---

# Prompt 3 — Build One Feature

Gunakan untuk membangun satu fitur tertentu.

```
Bangun satu fitur sesuai SRS.

Sebelum menulis kode:

- Jelaskan requirement yang sedang dikerjakan.
- Jelaskan dependency.
- Jelaskan file yang akan dibuat.
- Jelaskan dampaknya terhadap project.

Setelah implementasi selesai:

- Berikan ringkasan.
- Berikan checklist.
- Pastikan tidak ada duplicate code.
```

---

# Prompt 4 — Refactor Code

```
Lakukan refactor terhadap kode yang ada.

Jangan mengubah perilaku aplikasi.

Fokus pada:

- Clean Architecture
- SOLID
- DRY
- Readability
- Maintainability

Jika ada kode yang dapat dipisahkan menjadi reusable component atau service, lakukan pemisahan tersebut.

Berikan laporan perubahan setelah selesai.
```

---

# Prompt 5 — Bug Fix

```
Analisis bug yang terjadi.

Jangan langsung memperbaiki.

Lakukan langkah berikut:

1. Identifikasi penyebab.
2. Jelaskan akar masalah.
3. Berikan solusi terbaik.
4. Baru lakukan perbaikan.

Pastikan solusi tidak menimbulkan bug baru.
```

---

# Prompt 6 — Code Review

```
Lakukan code review terhadap project Easy Exam.

Periksa:

- Clean Architecture
- SOLID
- DRY
- Naming Convention
- Error Handling
- Security
- Performance
- Readability

Berikan hasil dalam bentuk:

Critical Issue

Major Issue

Minor Issue

Recommendation
```

---

# Prompt 7 — Firebase Review

```
Periksa seluruh implementasi Firebase.

Pastikan:

- Firestore Query efisien.
- Security Rules aman.
- Authentication benar.
- Tidak ada query yang berlebihan.
- Struktur database sesuai Database Design.

Berikan rekomendasi optimasi jika diperlukan.
```

---

# Prompt 8 — UI Review

```
Periksa seluruh UI aplikasi.

Bandingkan dengan:

04_UI_UX_SPECIFICATION.md

Pastikan:

- Konsisten
- Responsive
- Material 3
- Mudah digunakan siswa SD
- Tidak ada inkonsistensi spacing
- Tidak ada inkonsistensi typography
- Loading, Empty, dan Error State tersedia
```

---

# Prompt 9 — Performance Optimization

```
Analisis performa project.

Cari:

- Widget yang rebuild berlebihan.
- Query Firestore yang tidak efisien.
- Memory leak.
- Kode yang tidak digunakan.
- Asset yang terlalu besar.

Lakukan optimasi tanpa mengubah perilaku aplikasi.
```

---

# Prompt 10 — Security Audit

```
Lakukan audit keamanan.

Periksa:

- Authentication
- Authorization
- Firestore Security Rules
- Session Management
- Token Storage
- Anti Cheat
- Data Validation

Berikan daftar risiko beserta tingkat prioritasnya.
```

---

# Prompt 11 — Testing

```
Periksa kesiapan aplikasi untuk testing.

Pastikan seluruh fitur utama dapat diuji.

Identifikasi:

- Test Case yang diperlukan.
- Area berisiko tinggi.
- Kemungkinan bug.
- Skenario pengujian.

Berikan checklist pengujian.
```

---

# Prompt 12 — Release Preparation

```
Persiapkan project untuk production release.

Periksa:

- Error
- Warning
- TODO
- Debug Code
- Logging
- Environment
- Security
- Performance

Berikan checklist sebelum release.
```

---

# General Rules

Setiap kali AI Agent menerima tugas:

1. Baca dokumentasi proyek terlebih dahulu.
2. Jangan mengubah requirement tanpa persetujuan.
3. Jangan mengubah arsitektur tanpa alasan yang kuat.
4. Hindari duplicate code.
5. Gunakan reusable component.
6. Ikuti Clean Architecture.
7. Ikuti Development Roadmap.
8. Berikan ringkasan pekerjaan di akhir setiap tugas.
9. Laporkan dependency yang belum tersedia.
10. Jangan membuat asumsi jika requirement belum jelas—ajukan pertanyaan atau tandai sebagai kebutuhan klarifikasi.

---

# Expected Response Format

Setiap respons AI Agent sebaiknya mengikuti format berikut:

1. Requirement yang sedang dikerjakan.
2. Analisis singkat.
3. Rencana implementasi.
4. File yang akan dibuat atau diubah.
5. Implementasi.
6. Ringkasan hasil.
7. Checklist pekerjaan.
8. Rekomendasi langkah berikutnya.
