# 05_DEVELOPMENT_ROADMAP.md

Version: 1.0

Project: Easy Exam

---

# 1. Purpose

Dokumen ini menjelaskan urutan pengembangan (Development Roadmap) aplikasi **Easy Exam**.

Roadmap disusun berdasarkan dependency antar modul sehingga setiap tahap menjadi fondasi bagi tahap berikutnya.

AI Agent dan developer wajib mengikuti urutan ini selama proses implementasi.

---

# 2. Development Principles

Seluruh pengembangan harus mengikuti prinsip berikut:

* Membangun fondasi terlebih dahulu.
* Menyelesaikan satu fase sebelum berpindah ke fase berikutnya.
* Tidak mengimplementasikan fitur yang memiliki dependency belum selesai.
* Seluruh fase harus memenuhi Definition of Done sebelum dinyatakan selesai.

---

# 3. Development Phases

## Phase 1 — Project Initialization

### Objective

Mempersiapkan proyek Flutter dan struktur dasar aplikasi.

### Tasks

* Membuat project Flutter.
* Konfigurasi package.
* Konfigurasi linting dan formatting.
* Membuat struktur folder sesuai Clean Architecture.
* Konfigurasi Git.
* Menambahkan konfigurasi environment.

### Deliverables

* Project dapat dijalankan.
* Struktur proyek selesai.

---

## Phase 2 — Firebase Configuration

### Objective

Menghubungkan aplikasi dengan Firebase.

### Tasks

* Firebase Project.
* Android Configuration.
* Web Configuration (Admin).
* Firebase Authentication.
* Cloud Firestore.
* Firebase Storage.
* Firebase Cloud Messaging.
* Firebase Security Rules dasar.

### Deliverables

* Firebase terhubung dengan aplikasi.

---

## Phase 3 — Core Architecture

### Objective

Membangun fondasi arsitektur aplikasi.

### Tasks

* Clean Architecture.
* Repository Pattern.
* Dependency Injection.
* Riverpod Setup.
* Routing (GoRouter).
* Error Handling.
* Logging.
* Theme.

### Deliverables

* Arsitektur siap digunakan seluruh fitur.

---

## Phase 4 — Authentication Module

### Objective

Membangun sistem autentikasi.

### Tasks

* Google Sign-In.
* Login Guru.
* Login Siswa.
* Session Management.
* Logout.
* Secure Storage.

### Deliverables

* Pengguna dapat login dan logout.

---

## Phase 5 — Database Layer

### Objective

Mengimplementasikan seluruh struktur database sesuai `03_DATABASE_DESIGN.md`.

### Tasks

* Collection Firestore.
* Model.
* Repository.
* Data Source.
* Mapping JSON.
* Server Timestamp.

### Deliverables

* Database siap digunakan.

---

## Phase 6 — Admin Module

### Objective

Mengembangkan seluruh fitur Admin.

### Tasks

* Dashboard.
* Manajemen Mata Pelajaran.
* Manajemen Kelas.
* Manajemen Siswa.
* Manajemen Ujian.
* Bank Soal.
* Pengaturan Ujian.
* Hasil Ujian.
* Statistik.

### Deliverables

* Seluruh fitur Admin selesai.

---

## Phase 7 — Student Module

### Objective

Mengembangkan seluruh fitur siswa.

### Tasks

* Dashboard.
* Daftar Ujian.
* Detail Ujian.
* Profile.
* History.

### Deliverables

* Seluruh fitur siswa selesai.

---

## Phase 8 — Exam Engine

### Objective

Mengimplementasikan Core Exam Engine.

### Tasks

* Session Engine.
* Timer Engine.
* Navigation Engine.
* Answer Engine.
* Auto Save.
* Synchronization.
* Recovery.

### Deliverables

* Mesin ujian berfungsi penuh.

---

## Phase 9 — Security & Anti-Cheat

### Objective

Mengimplementasikan mekanisme keamanan.

### Tasks

* Lifecycle Monitoring.
* Session Guard.
* Audit Log.
* Violation Counter.
* Warning System.
* Auto Submit.
* Recovery Validation.
* Android Lock Task Mode (jika didukung).

### Deliverables

* Sistem keamanan aktif.

---

## Phase 10 — UI/UX Refinement

### Objective

Menyempurnakan tampilan aplikasi.

### Tasks

* Konsistensi komponen.
* Animasi.
* Empty State.
* Loading State.
* Error State.
* Responsive Layout.
* Accessibility.

### Deliverables

* UI konsisten dan siap digunakan.

---

## Phase 11 — Testing & Quality Assurance

### Objective

Memastikan seluruh aplikasi berjalan sesuai spesifikasi.

### Tasks

* Functional Testing.
* Integration Testing.
* Manual Testing.
* Performance Testing.
* Bug Fixing.
* Regression Testing.

### Deliverables

* Aplikasi stabil.

---

## Phase 12 — Deployment

### Objective

Menyiapkan aplikasi untuk digunakan.

### Tasks

* Build Android APK/AAB.
* Build Admin Web.
* Deploy Firebase Hosting (jika digunakan).
* Backup Database.
* Dokumentasi Release.

### Deliverables

* Versi produksi siap digunakan.

---

# 4. Definition of Done per Phase

Setiap fase dianggap selesai apabila:

* Seluruh task pada fase telah selesai.
* Tidak terdapat error kritis.
* Seluruh dependency terpenuhi.
* Kode mengikuti Development Guidelines.
* Dokumentasi diperbarui bila diperlukan.
* Fase berikutnya dapat dimulai tanpa hambatan.

---

# 5. Development Rules

* Tidak melompati fase.
* Tidak mengimplementasikan fitur di luar roadmap tanpa persetujuan.
* Setiap fase harus melalui proses review.
* Seluruh implementasi mengacu pada:

  * `00_AI_AGENT_RULES.md`
  * `02_SOFTWARE_REQUIREMENT_SPECIFICATION.md`
  * `03_DATABASE_DESIGN.md`
  * `04_UI_UX_SPECIFICATION.md`

---

# 6. Project Milestones

| Milestone | Target                            |
| --------- | --------------------------------- |
| M1        | Project Setup selesai             |
| M2        | Firebase & Authentication selesai |
| M3        | Database selesai                  |
| M4        | Modul Admin selesai               |
| M5        | Modul Siswa selesai               |
| M6        | Exam Engine selesai               |
| M7        | Security & Anti-Cheat selesai     |
| M8        | UI/UX Final selesai               |
| M9        | Testing selesai                   |
| M10       | Production Release                |

---

# 7. Success Criteria

Proyek Easy Exam dinyatakan siap digunakan apabila:

* Seluruh requirement pada SRS telah diimplementasikan.
* Struktur database sesuai desain.
* UI mengikuti spesifikasi.
* Core Exam Engine berjalan stabil.
* Security & Anti-Cheat berfungsi sesuai batasan platform.
* Seluruh pengujian utama berhasil.
* Aplikasi siap digunakan oleh guru dan siswa di lingkungan sekolah.
