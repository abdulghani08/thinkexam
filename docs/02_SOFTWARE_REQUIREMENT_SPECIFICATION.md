# SOFTWARE REQUIREMENT SPECIFICATION (SRS)

**Project Name:** Easy Exam
**Document Version:** 1.0.0
**Document Type:** Software Requirement Specification (SRS)
**Project Owner:** ThinkData Project
**Target Platform:** Flutter Mobile & Flutter Web
**Backend:** Firebase Platform
**Status:** Draft
**Last Updated:** July 2026

---

# PART 1 — INTRODUCTION

## 1. Purpose

Dokumen Software Requirement Specification (SRS) ini menjadi acuan utama dalam proses analisis, perancangan, pengembangan, pengujian, hingga pemeliharaan aplikasi **Easy Exam**.

Dokumen ini mendefinisikan seluruh kebutuhan bisnis (Business Requirements), kebutuhan fungsional (Functional Requirements), kebutuhan non-fungsional (Non-Functional Requirements), aturan bisnis (Business Rules), serta spesifikasi teknis yang harus dipenuhi oleh sistem.

Seluruh implementasi aplikasi wajib mengacu pada dokumen ini. Apabila terdapat perubahan kebutuhan di masa mendatang, perubahan harus dilakukan melalui proses pembaruan dokumen SRS agar seluruh anggota tim dan AI Agent memiliki referensi yang sama.

---

# 2. Document Objectives

Dokumen ini memiliki tujuan sebagai berikut:

* Menjadi sumber referensi utama selama pengembangan aplikasi.
* Menjelaskan seluruh kebutuhan sistem secara terstruktur.
* Mengurangi ambiguitas dalam proses implementasi.
* Menjadi acuan AI Agent dalam menghasilkan kode yang konsisten.
* Menjadi dasar desain database, UI/UX, dan arsitektur sistem.
* Menjadi dasar penyusunan skenario pengujian.
* Menjadi dasar pengembangan fitur di masa mendatang.

---

# 3. Intended Audience

Dokumen ini ditujukan untuk:

* Product Owner
* Software Architect
* Flutter Developer
* Firebase Engineer
* UI/UX Designer
* QA Engineer
* AI Agent
* Technical Writer
* Project Maintainer

---

# 4. Project Background

Sebagian besar sekolah dasar masih melaksanakan ulangan harian maupun ujian menggunakan media kertas atau menggunakan platform umum seperti Google Forms.

Google Forms memberikan kemudahan dalam pembuatan soal dan pengumpulan jawaban, namun memiliki beberapa keterbatasan apabila digunakan sebagai media ujian formal, di antaranya:

* Tidak dirancang sebagai sistem Computer Based Test (CBT).
* Tidak memiliki mekanisme pengawasan terhadap perpindahan aplikasi.
* Tidak memiliki fitur anti-cheat bawaan.
* Tidak memiliki kontrol penuh terhadap sesi ujian.
* Sulit dikustomisasi sesuai kebutuhan sekolah.
* Tidak memiliki dashboard administrasi yang terintegrasi khusus untuk kebutuhan sekolah.

Easy Exam dikembangkan untuk mengatasi keterbatasan tersebut dengan tetap mempertahankan pengalaman penggunaan yang sederhana bagi guru maupun siswa.

---

# 5. Vision

Easy Exam bertujuan menjadi platform ujian digital yang:

* Mudah digunakan oleh guru.
* Mudah digunakan oleh siswa.
* Aman digunakan selama ujian berlangsung.
* Dapat dikembangkan menjadi sistem CBT berskala besar.
* Memiliki arsitektur modern dan mudah dipelihara.

---

# 6. Mission

Misi utama Easy Exam adalah:

* Mengurangi penggunaan kertas.
* Mempermudah proses pembuatan ujian.
* Mempermudah proses penilaian.
* Menyediakan nilai otomatis.
* Mengurangi potensi kecurangan.
* Menyediakan statistik hasil ujian.
* Menjadi platform ujian standar di lingkungan sekolah.

---

# 7. Product Overview

Easy Exam merupakan aplikasi ujian digital yang menggabungkan konsep:

* Google Forms
* Computer Based Test (CBT)
* Mobile Examination System
* School Management Support

Aplikasi dibangun menggunakan satu ekosistem teknologi Flutter dan Firebase agar memiliki codebase yang konsisten antara platform mobile dan web.

Sistem terdiri dari dua platform utama:

## Student Application

Platform:

Flutter Mobile

Digunakan oleh:

Siswa

Fungsi utama:

* Login
* Melihat daftar ujian
* Mengikuti ujian
* Melihat riwayat
* Melihat profil

---

## Admin Dashboard

Platform:

Flutter Web

Digunakan oleh:

Guru

Fungsi utama:

* Membuat ujian
* Mengelola soal
* Mengelola kelas
* Mengelola siswa
* Melihat hasil ujian
* Melihat statistik
* Mengatur sesi ujian

---

## Backend Platform

Menggunakan Firebase sebagai Backend-as-a-Service (BaaS) yang menyediakan:

* Authentication
* Cloud Firestore
* Firebase Storage
* Cloud Functions
* Firebase Cloud Messaging
* Firebase Analytics
* Firebase Crashlytics

---

# 8. Project Scope

## Included Scope

Versi pertama Easy Exam mencakup:

### Authentication

* Login menggunakan Google.
* Manajemen sesi pengguna.
* Role Based Access Control (RBAC).

---

### User Management

* Guru.
* Siswa.
* Kelas.
* Mata pelajaran.

---

### Exam Management

Guru dapat:

* Membuat ujian.
* Mengedit ujian.
* Menghapus ujian.
* Mengaktifkan ujian.
* Menonaktifkan ujian.
* Menentukan durasi.
* Menentukan jadwal.
* Menentukan kelas tujuan.
* Mengatur randomisasi soal.
* Mengatur randomisasi pilihan jawaban.

---

### Question Builder

Mendukung:

* Pilihan Ganda.
* Benar / Salah.
* Checkbox (opsional).
* Isian Singkat (opsional pada fase berikutnya).
* Gambar pada soal.
* Bobot nilai.

---

### Student Examination

Siswa dapat:

* Memulai ujian.
* Menjawab soal.
* Berpindah antar soal.
* Menyimpan jawaban otomatis.
* Submit ujian.
* Melihat status ujian.

---

### Automatic Scoring

Sistem melakukan:

* Koreksi otomatis.
* Perhitungan nilai otomatis.
* Penyimpanan hasil.
* Rekap nilai.

---

### Analytics

Guru dapat melihat:

* Jumlah peserta.
* Nilai rata-rata.
* Nilai tertinggi.
* Nilai terendah.
* Persentase jawaban benar.
* Detail jawaban.

---

### Security

Implementasi keamanan meliputi:

* Google Authentication.
* Firestore Security Rules.
* Session Validation.
* Anti-Cheat Mechanism.
* Secure Storage.
* Input Validation.

---

# 9. Out of Scope

Fitur berikut tidak termasuk dalam versi pertama, tetapi telah dipertimbangkan dalam desain arsitektur agar mudah ditambahkan di masa depan:

* Multi School.
* Multi Tenant.
* Parent Portal.
* Principal Dashboard.
* Essay AI Scoring.
* Offline Synchronization.
* Learning Management System (LMS).
* AI Question Generator.
* AI Learning Analytics.
* Payment System.
* Attendance System.
* Video Proctoring.

---

# 10. Product Goals

Easy Exam memiliki target sebagai berikut:

### Goal 1

Mengurangi penggunaan media kertas.

---

### Goal 2

Mengurangi waktu guru dalam proses koreksi.

---

### Goal 3

Mengurangi potensi kecurangan.

---

### Goal 4

Menyediakan sistem ujian yang mudah digunakan.

---

### Goal 5

Menyediakan sistem yang stabil meskipun digunakan secara bersamaan oleh banyak siswa.

---

### Goal 6

Menyediakan arsitektur yang mudah dikembangkan.

---

# 11. Assumptions

Dokumen ini dibuat dengan asumsi:

* Seluruh siswa memiliki akun Google yang valid.
* Sekolah menyediakan koneksi internet saat ujian.
* Guru memiliki akses ke laptop atau komputer untuk menggunakan dashboard web.
* Siswa menggunakan perangkat Android yang memenuhi spesifikasi minimum aplikasi.
* Firebase digunakan sebagai backend utama.

Apabila salah satu asumsi berubah, maka requirement terkait perlu dievaluasi kembali.

---

# 12. Constraints

Batasan utama proyek meliputi:

* Student hanya dapat menggunakan aplikasi mobile.
* Admin hanya menggunakan aplikasi web.
* Backend menggunakan Firebase.
* Bahasa pemrograman utama adalah Dart.
* Framework utama adalah Flutter.
* Arsitektur menggunakan Clean Architecture.
* State management menggunakan Riverpod.
* Sistem harus mendukung pengembangan fitur di masa depan tanpa perubahan besar pada arsitektur.

---

# 13. Success Criteria

Versi pertama Easy Exam dianggap berhasil apabila:

* Guru dapat membuat ujian secara mandiri.
* Guru dapat mengelola soal dengan mudah.
* Guru dapat melihat hasil ujian secara otomatis.
* Siswa dapat mengikuti ujian tanpa kendala.
* Nilai dihitung secara otomatis.
* Sistem mampu meminimalkan peluang kecurangan sesuai kemampuan platform.
* Struktur kode tetap mudah dipelihara dan dikembangkan.

---

# 14. Terminology

| Istilah       | Definisi                                                                               |
| ------------- | -------------------------------------------------------------------------------------- |
| Admin         | Guru yang memiliki hak akses penuh terhadap sistem.                                    |
| Student       | Pengguna yang mengerjakan ujian melalui aplikasi mobile.                               |
| Exam          | Satu sesi ujian yang terdiri atas kumpulan soal dengan aturan tertentu.                |
| Question      | Satu butir soal dalam suatu ujian.                                                     |
| Submission    | Seluruh jawaban yang dikirimkan oleh seorang siswa untuk satu sesi ujian.              |
| Score         | Nilai akhir hasil perhitungan sistem.                                                  |
| Session       | Periode aktif sejak siswa memulai hingga menyelesaikan ujian.                          |
| Question Bank | Kumpulan soal yang dapat digunakan kembali pada berbagai ujian.                        |
| Randomization | Mekanisme pengacakan urutan soal atau pilihan jawaban.                                 |
| Anti-Cheat    | Mekanisme untuk mengurangi peluang kecurangan selama ujian.                            |
| Auto Save     | Penyimpanan jawaban secara otomatis selama ujian berlangsung.                          |
| Auto Submit   | Pengiriman jawaban secara otomatis ketika waktu habis atau kondisi tertentu terpenuhi. |
| RBAC          | Role-Based Access Control, yaitu pembatasan hak akses berdasarkan peran pengguna.      |

---

# 15. Document Structure

Dokumen SRS ini dibagi menjadi beberapa bagian:

* Part 1 — Introduction, Product Overview, Scope & Definitions.
* Part 2 — User Roles & Permissions.
* Part 3 — Functional Requirements (Admin).
* Part 4 — Functional Requirements (Student).
* Part 5 — Functional Requirements (Exam Engine).
* Part 6 — Non-Functional Requirements.
* Part 7 — Business Rules.
* Part 8 — User Stories.
* Part 9 — Use Cases.
* Part 10 — Screen Specifications.
* Part 11 — Database Requirements.
* Part 12 — Security Requirements.
* Part 13 — Anti-Cheat Specification.
* Part 14 — Notification Requirements.
* Part 15 — Analytics & Reporting.
* Part 16 — Edge Cases.
* Part 17 — Future Roadmap.
* Part 18 — Acceptance Criteria & Glossary.

Dokumen ini akan terus diperbarui seiring bertambahnya kebutuhan bisnis dan pengembangan fitur.

# PART 2 — USER ROLES & PERMISSIONS

---

# 2.1 Introduction

Dokumen ini mendefinisikan seluruh jenis pengguna (User Roles) yang dapat menggunakan aplikasi Easy Exam beserta hak akses, batasan akses, serta tanggung jawab masing-masing.

Easy Exam menggunakan mekanisme **Role-Based Access Control (RBAC)**.

Setiap pengguna hanya dapat mengakses fitur yang sesuai dengan perannya.

Role pengguna disimpan di dalam Firebase Firestore dan divalidasi setiap kali pengguna melakukan autentikasi.

---

# 2.2 User Roles

Versi pertama Easy Exam memiliki dua role utama.

| Role                 | Kode    | Platform       |
| -------------------- | ------- | -------------- |
| Administrator (Guru) | ADMIN   | Flutter Web    |
| Student (Siswa)      | STUDENT | Flutter Mobile |

Arsitektur sistem harus mendukung penambahan role baru di masa depan tanpa perubahan besar.

Contoh role yang dapat ditambahkan di masa depan:

* Super Admin
* Kepala Sekolah
* Operator Sekolah
* Orang Tua
* Pengawas Ujian

---

# 2.3 Administrator (Teacher)

Administrator adalah guru yang bertugas mengelola seluruh proses ujian.

Administrator menggunakan Flutter Web.

Administrator memiliki akses terhadap seluruh data akademik sesuai kewenangannya.

---

## Administrator Responsibilities

Administrator bertanggung jawab untuk:

* Membuat ujian.
* Mengelola soal.
* Mengelola bank soal.
* Mengelola kelas.
* Mengelola siswa.
* Mengelola mata pelajaran.
* Mengelola jadwal ujian.
* Mengelola durasi ujian.
* Mengaktifkan ujian.
* Menonaktifkan ujian.
* Melihat jawaban siswa.
* Melihat nilai.
* Mengekspor hasil ujian.

---

# 2.4 Student

Student merupakan peserta ujian.

Student hanya dapat menggunakan Flutter Mobile.

Student tidak memiliki akses terhadap dashboard admin.

Student hanya dapat mengakses ujian yang diberikan kepadanya.

---

## Student Responsibilities

Student bertanggung jawab untuk:

* Login menggunakan akun Google.
* Mengikuti ujian.
* Menjawab soal.
* Menyelesaikan ujian.
* Menjaga integritas selama sesi ujian berlangsung.

---

# 2.5 Authentication Rules

Semua pengguna wajib melakukan autentikasi menggunakan Google Sign-In.

Setelah autentikasi berhasil, sistem harus memverifikasi role pengguna melalui database.

Apabila role tidak ditemukan, pengguna tidak boleh memperoleh akses ke aplikasi.

---

# 2.6 Authorization Rules

Setelah login berhasil, sistem harus menentukan halaman utama berdasarkan role.

ADMIN

↓

Dashboard Admin

STUDENT

↓

Dashboard Student

Pengguna tidak boleh mengakses halaman milik role lain.

---

# 2.7 Functional Requirements — Authentication

---

## FR-AUTH-001

### Title

User Login using Google

### Priority

Critical

### Description

Sistem harus menyediakan autentikasi menggunakan akun Google.

### Acceptance Criteria

* Pengguna dapat memilih akun Google.
* Login berhasil.
* Session tersimpan.
* User diarahkan ke dashboard sesuai role.

---

## FR-AUTH-002

### Title

Role Validation

### Priority

Critical

### Description

Setelah login berhasil, sistem wajib memverifikasi role pengguna.

### Acceptance Criteria

* Role ditemukan.
* Dashboard sesuai role ditampilkan.
* Tidak ada akses lintas role.

---

## FR-AUTH-003

### Title

Unauthorized User

### Priority

Critical

### Description

Apabila akun Google belum terdaftar pada sistem, maka login tidak boleh dilanjutkan.

### Acceptance Criteria

* Muncul pesan bahwa akun belum terdaftar.
* Pengguna tidak masuk ke dashboard.
* Tidak dibuat akun baru secara otomatis.

---

## FR-AUTH-004

### Title

Session Persistence

### Priority

High

### Description

Sistem harus mempertahankan sesi login sehingga pengguna tidak perlu login ulang setiap kali aplikasi dibuka.

### Acceptance Criteria

* Session tersimpan.
* Session dipulihkan saat aplikasi dibuka kembali.
* Logout menghapus seluruh session.

---

## FR-AUTH-005

### Title

Logout

### Priority

High

### Description

Pengguna dapat keluar dari aplikasi.

### Acceptance Criteria

* Session dihapus.
* Firebase Sign Out berhasil.
* Pengguna kembali ke halaman login.

---

# 2.8 Functional Requirements — Administrator

---

## FR-ADM-001

Administrator dapat melihat Dashboard.

Priority:

Critical

Acceptance Criteria

* Statistik utama ditampilkan.
* Informasi akun tampil.
* Ringkasan ujian tampil.

---

## FR-ADM-002

Administrator dapat membuat ujian baru.

Priority:

Critical

Acceptance Criteria

* Form valid.
* Data tersimpan.
* Ujian muncul pada daftar ujian.

---

## FR-ADM-003

Administrator dapat mengedit ujian.

Priority:

Critical

Acceptance Criteria

* Data lama ditampilkan.
* Perubahan berhasil disimpan.
* Riwayat data tetap konsisten.

---

## FR-ADM-004

Administrator dapat menghapus ujian.

Priority:

High

Acceptance Criteria

* Konfirmasi ditampilkan.
* Data dihapus dengan aman.
* Data terkait ditangani sesuai kebijakan sistem.

---

## FR-ADM-005

Administrator dapat mengaktifkan ujian.

Priority:

Critical

Acceptance Criteria

* Status berubah menjadi Active.
* Ujian muncul pada dashboard siswa sesuai aturan kelas dan jadwal.

---

## FR-ADM-006

Administrator dapat menonaktifkan ujian.

Priority:

Critical

Acceptance Criteria

* Status berubah menjadi Inactive.
* Ujian tidak lagi dapat dimulai oleh siswa.

---

## FR-ADM-007

Administrator dapat mengatur durasi ujian.

Priority:

Critical

Acceptance Criteria

* Durasi tersimpan.
* Timer mengikuti durasi tersebut saat ujian dimulai.

---

## FR-ADM-008

Administrator dapat menentukan tanggal mulai ujian.

Priority:

Critical

Acceptance Criteria

* Waktu mulai tersimpan.
* Ujian hanya dapat dimulai setelah waktu tersebut.

---

## FR-ADM-009

Administrator dapat menentukan tanggal berakhir ujian.

Priority:

Critical

Acceptance Criteria

* Waktu selesai tersimpan.
* Setelah waktu berakhir, siswa tidak dapat memulai ujian baru.

---

## FR-ADM-010

Administrator dapat menentukan kelas tujuan.

Priority:

Critical

Acceptance Criteria

* Ujian hanya tampil kepada siswa pada kelas yang ditentukan.

---

## FR-ADM-011

Administrator dapat melihat daftar seluruh ujian.

Priority:

Critical

Acceptance Criteria

* Seluruh ujian ditampilkan.
* Mendukung pencarian.
* Mendukung filter.

---

## FR-ADM-012

Administrator dapat melihat detail ujian.

Priority:

Critical

Acceptance Criteria

* Informasi ujian lengkap ditampilkan.
* Statistik peserta ditampilkan.
* Ringkasan hasil tersedia.

---

# 2.9 Functional Requirements — Student

---

## FR-STD-001

Student dapat melihat dashboard.

Priority:

Critical

Acceptance Criteria

* Profil ditampilkan.
* Daftar ujian ditampilkan.
* Status ujian ditampilkan.

---

## FR-STD-002

Student hanya dapat melihat ujian yang ditujukan untuk kelasnya.

Priority:

Critical

Acceptance Criteria

* Tidak ada ujian dari kelas lain yang muncul.
* Filter dilakukan di sisi backend melalui query dan security rules.

---

## FR-STD-003

Student dapat melihat profil pribadi.

Priority:

Medium

Acceptance Criteria

* Nama.
* Email.
* Kelas.
* Foto profil.

---

## FR-STD-004

Student dapat melihat riwayat ujian.

Priority:

Medium

Acceptance Criteria

* Daftar ujian selesai ditampilkan.
* Nilai ditampilkan jika kebijakan sekolah mengizinkan.

---

# 2.10 Role Permission Matrix

| Fitur                     | Admin | Student |
| ------------------------- | :---: | :-----: |
| Login                     |   ✅   |    ✅    |
| Logout                    |   ✅   |    ✅    |
| Dashboard                 |   ✅   |    ✅    |
| Membuat Ujian             |   ✅   |    ❌    |
| Mengedit Ujian            |   ✅   |    ❌    |
| Menghapus Ujian           |   ✅   |    ❌    |
| Mengelola Soal            |   ✅   |    ❌    |
| Mengelola Bank Soal       |   ✅   |    ❌    |
| Mengelola Kelas           |   ✅   |    ❌    |
| Mengelola Mata Pelajaran  |   ✅   |    ❌    |
| Melihat Statistik         |   ✅   |    ❌    |
| Melihat Nilai Semua Siswa |   ✅   |    ❌    |
| Melihat Jawaban Siswa     |   ✅   |    ❌    |
| Mengikuti Ujian           |   ❌   |    ✅    |
| Menjawab Soal             |   ❌   |    ✅    |
| Submit Ujian              |   ❌   |    ✅    |
| Melihat Riwayat Sendiri   |   ❌   |    ✅    |

---

# 2.11 Security Notes

Hak akses tidak boleh hanya dikendalikan oleh antarmuka pengguna (UI).

Seluruh validasi akses harus dilakukan juga pada backend melalui Firebase Security Rules.

Menyembunyikan tombol pada UI tidak dianggap sebagai mekanisme keamanan.

Setiap operasi baca, tulis, ubah, dan hapus data wajib divalidasi terhadap role pengguna.

---

# 2.12 Future Expansion

Struktur Role-Based Access Control (RBAC) harus dirancang agar mendukung penambahan role baru tanpa mengubah arsitektur inti.

Role baru yang direncanakan antara lain:

* Super Administrator
* Kepala Sekolah
* Operator Sekolah
* Pengawas Ujian
* Orang Tua
* Auditor

Setiap role baru harus memiliki matriks hak akses tersendiri dan tidak mengubah perilaku role yang sudah ada.

# PART 3A — FUNCTIONAL REQUIREMENTS (ADMIN)

# MODULE: ADMIN DASHBOARD & EXAM MANAGEMENT

---

# 3A.1 Module Overview

Modul **Admin Dashboard & Exam Management** merupakan pusat pengelolaan seluruh aktivitas ujian pada Easy Exam.

Modul ini hanya dapat diakses oleh pengguna dengan role **ADMIN**.

Dashboard harus memberikan informasi penting mengenai seluruh aktivitas ujian secara real-time.

Seluruh operasi CRUD harus mengikuti aturan keamanan Firebase Security Rules.

---

# 3A.2 Objectives

Modul ini bertujuan agar Administrator dapat:

* Melihat ringkasan seluruh aktivitas.
* Membuat ujian baru.
* Mengubah ujian.
* Menghapus ujian.
* Mengatur jadwal ujian.
* Mengatur durasi.
* Mengatur status ujian.
* Mengatur kelas tujuan.
* Mengatur mata pelajaran.
* Mengatur randomisasi.
* Mengelola lifecycle ujian.

---

# 3A.3 Functional Requirements

---

## FR-ADM-013

### Title

View Dashboard Summary

### Priority

Critical

### Description

Administrator dapat melihat dashboard utama setelah berhasil login.

### Business Rules

Dashboard harus memuat informasi secara real-time.

### Acceptance Criteria

Dashboard menampilkan:

* Total ujian
* Total siswa
* Total kelas
* Ujian aktif
* Ujian selesai
* Ujian akan datang

### Dependencies

FR-AUTH-002

---

## FR-ADM-014

### Title

Recent Activity

### Priority

High

### Description

Dashboard menampilkan aktivitas terbaru.

### Acceptance Criteria

Menampilkan:

* Ujian terakhir dibuat
* Ujian terakhir diedit
* Submission terbaru
* Nilai terbaru

---

## FR-ADM-015

### Title

Upcoming Exams

### Priority

Medium

### Description

Dashboard menampilkan daftar ujian yang akan dimulai.

### Acceptance Criteria

Minimal menampilkan:

* Nama ujian
* Mata pelajaran
* Kelas
* Waktu mulai

---

## FR-ADM-016

### Title

Quick Statistics

### Priority

High

### Description

Dashboard menyediakan statistik cepat.

### Acceptance Criteria

Minimal:

* Total peserta
* Total submission
* Nilai rata-rata
* Nilai tertinggi
* Nilai terendah

---

# EXAM MANAGEMENT

---

## FR-ADM-017

### Title

Create New Exam

### Priority

Critical

### Description

Administrator dapat membuat ujian baru.

### Business Rules

Data wajib:

* Judul
* Mata pelajaran
* Kelas
* Durasi

### Acceptance Criteria

Jika valid

↓

Data tersimpan

↓

Exam ID dibuat

↓

Status Draft

---

## FR-ADM-018

### Title

Edit Exam

### Priority

Critical

### Description

Administrator dapat mengubah informasi ujian.

### Business Rules

Perubahan hanya boleh dilakukan apabila belum ada peserta yang memulai ujian.

Jika sudah ada peserta, perubahan dibatasi sesuai kebijakan sistem (misalnya tidak dapat mengubah jumlah soal atau kunci jawaban).

### Acceptance Criteria

Perubahan berhasil disimpan.

Audit informasi perubahan dicatat.

---

## FR-ADM-019

### Title

Delete Exam

### Priority

Critical

### Description

Administrator dapat menghapus ujian.

### Business Rules

Harus muncul dialog konfirmasi.

Apabila ujian sudah memiliki submission, penghapusan mengikuti kebijakan retensi data (misalnya dinonaktifkan atau diarsipkan).

### Acceptance Criteria

Data tidak dapat diakses lagi oleh siswa.

---

## FR-ADM-020

### Title

Duplicate Exam

### Priority

High

### Description

Administrator dapat menduplikasi ujian.

### Acceptance Criteria

Salinan memiliki:

* ID baru
* Status Draft
* Seluruh soal tersalin
* Pengaturan ujian tersalin sesuai kebijakan

---

## FR-ADM-021

### Title

Archive Exam

### Priority

Medium

### Description

Administrator dapat mengarsipkan ujian lama.

### Acceptance Criteria

Ujian tidak muncul pada daftar aktif.

Data tetap tersedia untuk laporan.

---

## FR-ADM-022

### Title

Restore Archived Exam

### Priority

Medium

### Description

Administrator dapat mengembalikan ujian dari arsip.

### Acceptance Criteria

Status berubah menjadi Draft.

---

# EXAM CONFIGURATION

---

## FR-ADM-023

### Title

Set Exam Duration

### Priority

Critical

### Description

Administrator menentukan durasi ujian.

### Business Rules

Durasi minimal:

5 menit

Durasi maksimal ditentukan oleh kebijakan sekolah.

### Acceptance Criteria

Timer mengikuti durasi tersebut.

---

## FR-ADM-024

### Title

Set Exam Start Time

### Priority

Critical

### Description

Administrator menentukan waktu mulai ujian.

### Acceptance Criteria

Siswa tidak dapat memulai sebelum waktu dimulai.

---

## FR-ADM-025

### Title

Set Exam End Time

### Priority

Critical

### Description

Administrator menentukan waktu berakhir ujian.

### Acceptance Criteria

Setelah waktu selesai

↓

Exam Closed

↓

Tidak menerima peserta baru.

---

## FR-ADM-026

### Title

Assign Subject

### Priority

Critical

### Description

Administrator memilih mata pelajaran.

### Acceptance Criteria

Subject wajib dipilih.

---

## FR-ADM-027

### Title

Assign Class

### Priority

Critical

### Description

Administrator memilih kelas tujuan.

### Business Rules

Satu ujian dapat ditujukan ke satu atau beberapa kelas sesuai desain sistem.

### Acceptance Criteria

Hanya siswa pada kelas yang ditentukan yang dapat melihat ujian.

---

## FR-ADM-028

### Title

Exam Description

### Priority

Medium

### Description

Administrator dapat menambahkan deskripsi ujian.

### Acceptance Criteria

Deskripsi tampil pada halaman informasi ujian.

---

# EXAM STATUS

---

## FR-ADM-029

### Title

Draft Status

### Priority

Critical

### Description

Ujian baru dibuat dalam status Draft.

### Acceptance Criteria

Tidak tampil kepada siswa.

---

## FR-ADM-030

### Title

Publish Exam

### Priority

Critical

### Description

Administrator mempublikasikan ujian.

### Business Rules

Sebelum dipublikasikan, sistem harus memvalidasi bahwa:

* Informasi wajib telah lengkap.
* Minimal terdapat satu soal.
* Durasi telah ditentukan.
* Kelas tujuan telah dipilih.

### Acceptance Criteria

Status berubah menjadi Published.

---

## FR-ADM-031

### Title

Activate Exam

### Priority

Critical

### Description

Administrator mengaktifkan ujian.

### Acceptance Criteria

Status Active.

Siswa yang memenuhi syarat dapat melihat ujian.

---

## FR-ADM-032

### Title

Deactivate Exam

### Priority

Critical

### Description

Administrator menonaktifkan ujian.

### Acceptance Criteria

Ujian tidak dapat dimulai oleh siswa.

Peserta yang sedang mengerjakan mengikuti kebijakan sistem yang ditentukan pada modul Exam Engine.

---

## FR-ADM-033

### Title

Close Exam

### Priority

High

### Description

Administrator menutup ujian sebelum jadwal berakhir.

### Acceptance Criteria

Tidak ada peserta baru yang dapat memulai ujian.

Perlakuan terhadap peserta yang sedang aktif mengikuti aturan pada Exam Engine.

---

# RANDOMIZATION

---

## FR-ADM-034

### Title

Shuffle Questions

### Priority

Critical

### Description

Administrator dapat mengaktifkan pengacakan urutan soal.

### Business Rules

Pengacakan dilakukan sekali ketika sesi ujian dimulai.

Urutan soal setiap siswa dapat berbeda.

### Acceptance Criteria

Setiap submission memiliki urutan soal sendiri.

---

## FR-ADM-035

### Title

Shuffle Answer Options

### Priority

Critical

### Description

Administrator dapat mengacak urutan pilihan jawaban.

### Business Rules

Kunci jawaban harus tetap benar setelah pengacakan.

### Acceptance Criteria

Pilihan jawaban berbeda antar siswa jika fitur diaktifkan.

---

# SEARCH & FILTER

---

## FR-ADM-036

### Title

Search Exams

### Priority

Medium

### Description

Administrator dapat mencari ujian.

### Acceptance Criteria

Pencarian berdasarkan:

* Judul
* Mata pelajaran
* Kelas

---

## FR-ADM-037

### Title

Filter Exams

### Priority

Medium

### Description

Administrator dapat memfilter daftar ujian.

### Filter

* Draft
* Active
* Published
* Closed
* Archived

---

## FR-ADM-038

### Title

Sort Exams

### Priority

Low

### Description

Administrator dapat mengurutkan daftar ujian.

### Sort By

* Tanggal dibuat
* Nama
* Mata pelajaran
* Status

---

# VALIDATION

---

## FR-ADM-039

### Title

Mandatory Validation

### Priority

Critical

### Description

Sistem wajib memvalidasi seluruh field wajib sebelum ujian dapat disimpan atau dipublikasikan.

### Acceptance Criteria

Field wajib yang kosong ditandai dengan jelas dan pengguna tidak dapat melanjutkan sampai diperbaiki.

---

## FR-ADM-040

### Title

Prevent Duplicate Active Exams

### Priority

High

### Description

Sistem harus mencegah konfigurasi ujian yang bertentangan, misalnya dua ujian aktif dengan identitas yang sama untuk kelas, mata pelajaran, dan jadwal yang saling bertumpang tindih apabila kebijakan sekolah melarangnya.

### Acceptance Criteria

Administrator menerima peringatan dan dapat menyesuaikan konfigurasi sebelum publikasi.

---

# BUSINESS RULES

BR-ADM-001

Semua ujian baru harus dibuat dalam status **Draft**.

---

BR-ADM-002

Ujian tidak boleh dipublikasikan apabila belum memiliki soal.

---

BR-ADM-003

Ujian tidak boleh diaktifkan apabila tanggal mulai dan durasi belum ditentukan.

---

BR-ADM-004

Siswa hanya dapat melihat ujian yang:

* Berstatus Active.
* Sudah dipublikasikan.
* Sesuai kelasnya.
* Berada dalam rentang waktu yang diizinkan.

---

BR-ADM-005

Setiap perubahan konfigurasi ujian harus tercatat pada audit log.

---

# Module Completion Criteria

Modul dianggap selesai apabila Administrator dapat:

* Melihat Dashboard.
* Membuat ujian.
* Mengedit ujian.
* Menghapus atau mengarsipkan ujian sesuai kebijakan.
* Mengatur jadwal.
* Mengatur durasi.
* Mengatur kelas.
* Mengatur mata pelajaran.
* Mengatur status ujian.
* Mengaktifkan randomisasi soal.
* Mengaktifkan randomisasi pilihan jawaban.
* Mencari dan memfilter ujian.
* Mempublikasikan ujian dengan validasi yang benar.

# PART 3B — FUNCTIONAL REQUIREMENTS (ADMIN)

# MODULE: QUESTION BUILDER & QUESTION BANK

---

# 3B.1 Module Overview

Question Builder merupakan modul utama yang digunakan Administrator untuk membuat, mengedit, mengelola, dan menyusun soal ujian.

Modul ini dirancang dengan pengalaman penggunaan yang menyerupai Google Forms agar mudah dipelajari oleh guru, namun memiliki fitur tambahan yang mendukung sistem Computer Based Test (CBT).

Question Builder harus mendukung penyusunan soal secara efisien, konsisten, dan mudah digunakan, baik untuk ujian sederhana maupun ujian berskala besar.

---

# 3B.2 Objectives

Administrator harus dapat:

* Membuat soal dengan cepat.
* Menyusun urutan soal.
* Menggunakan kembali soal dari Bank Soal.
* Mengelompokkan soal berdasarkan kategori.
* Menentukan bobot nilai.
* Menambahkan gambar.
* Melakukan preview sebelum publikasi.
* Mengurangi kesalahan input melalui validasi otomatis.

---

# 3B.3 Supported Question Types

Versi pertama Easy Exam mendukung jenis soal berikut:

| Jenis Soal                    | Status             |
| ----------------------------- | ------------------ |
| Pilihan Ganda (Single Choice) | ✅ Wajib            |
| Benar / Salah                 | ✅ Wajib            |
| Checkbox (Multiple Choice)    | ✅ Opsional         |
| Isian Singkat                 | 🔜 Fase Berikutnya |
| Essay                         | 🔜 Fase Berikutnya |
| Upload File                   | 🔜 Future Version  |

Arsitektur harus memungkinkan penambahan tipe soal baru tanpa mengubah struktur inti.

---

# QUESTION BUILDER

---

## FR-QB-001

### Title

Create Question

### Priority

Critical

### Description

Administrator dapat membuat soal baru.

### Acceptance Criteria

* Soal berhasil dibuat.
* Memiliki Question ID unik.
* Tersimpan sebagai Draft.

---

## FR-QB-002

### Title

Edit Question

### Priority

Critical

### Description

Administrator dapat mengubah isi soal.

### Business Rules

Perubahan soal pada ujian yang sudah memiliki submission mengikuti kebijakan sistem (misalnya membuat versi baru atau membatasi perubahan yang memengaruhi penilaian).

### Acceptance Criteria

Perubahan tersimpan dan riwayat perubahan tersedia bila fitur versioning diaktifkan.

---

## FR-QB-003

### Title

Delete Question

### Priority

High

### Description

Administrator dapat menghapus soal.

### Acceptance Criteria

Muncul dialog konfirmasi sebelum penghapusan.

---

## FR-QB-004

### Title

Duplicate Question

### Priority

Medium

### Description

Administrator dapat menggandakan soal.

### Acceptance Criteria

Question ID baru dibuat.

Seluruh data soal disalin.

---

## FR-QB-005

### Title

Reorder Questions

### Priority

High

### Description

Administrator dapat mengubah urutan soal.

### Acceptance Criteria

Urutan dapat diubah melalui drag and drop atau kontrol naik/turun.

---

## FR-QB-006

### Title

Auto Save

### Priority

High

### Description

Sistem menyimpan perubahan soal secara otomatis.

### Acceptance Criteria

Perubahan tersimpan berkala tanpa menekan tombol Save.

---

# QUESTION CONTENT

---

## FR-QB-007

### Title

Question Title

### Priority

Critical

### Description

Administrator dapat menuliskan pertanyaan.

### Acceptance Criteria

Minimal satu karakter.

---

## FR-QB-008

### Title

Question Description

### Priority

Low

### Description

Administrator dapat menambahkan penjelasan.

---

## FR-QB-009

### Title

Rich Text Editor

### Priority

Medium

### Description

Editor mendukung format dasar.

### Supported

* Bold
* Italic
* Underline
* Bullet List
* Number List
* Superscript (opsional)
* Subscript (opsional)

---

## FR-QB-010

### Title

Upload Question Image

### Priority

High

### Description

Administrator dapat mengunggah gambar pada soal.

### Acceptance Criteria

Mendukung format gambar umum (PNG, JPG, WEBP) dengan batas ukuran sesuai konfigurasi sistem.

---

## FR-QB-011

### Title

Image Preview

### Priority

Medium

### Description

Gambar dapat dipreview sebelum disimpan.

---

# ANSWER OPTIONS

---

## FR-QB-012

Administrator dapat menambahkan pilihan jawaban.

Priority

Critical

Acceptance Criteria

Minimal dua pilihan jawaban.

---

## FR-QB-013

Administrator dapat menghapus pilihan jawaban.

Priority

Medium

Acceptance Criteria

Minimal dua pilihan tetap tersedia untuk soal pilihan ganda.

---

## FR-QB-014

Administrator dapat mengubah urutan pilihan jawaban.

Priority

Medium

Acceptance Criteria

Urutan dapat diubah tanpa memengaruhi penandaan jawaban benar.

---

## FR-QB-015

Administrator dapat menentukan jawaban benar.

Priority

Critical

Acceptance Criteria

Pilihan yang ditandai sebagai benar disimpan sebagai acuan penilaian.

---

## FR-QB-016

Administrator dapat menentukan lebih dari satu jawaban benar untuk tipe Checkbox.

Priority

Medium

Acceptance Criteria

Hanya berlaku pada tipe soal yang mendukung banyak jawaban benar.

---

# QUESTION SETTINGS

---

## FR-QB-017

Title

Question Score

Priority

Critical

Description

Administrator menentukan bobot nilai.

Acceptance Criteria

Bobot harus berupa angka positif.

---

## FR-QB-018

Title

Required Question

Priority

Medium

Description

Administrator dapat menandai soal sebagai wajib dijawab.

Acceptance Criteria

Jika soal wajib belum dijawab, sistem memberikan peringatan sebelum submit sesuai kebijakan ujian.

---

## FR-QB-019

Title

Question Explanation

Priority

Low

Description

Administrator dapat menambahkan pembahasan soal.

Catatan:
Pembahasan dapat ditampilkan setelah ujian jika kebijakan sekolah mengizinkan.

---

## FR-QB-020

Title

Question Tag

Priority

Medium

Description

Administrator dapat memberi tag.

Contoh:

* HOTS
* Mudah
* Sedang
* Sulit

---

## FR-QB-021

Title

Question Category

Priority

Medium

Description

Administrator dapat mengelompokkan soal.

Contoh:

Bab 1

Bab 2

UTS

UAS

Latihan

---

# QUESTION BANK

---

## FR-QB-022

Administrator dapat menyimpan soal ke Bank Soal.

Priority

Critical

Acceptance Criteria

Soal dapat digunakan kembali pada ujian lain.

---

## FR-QB-023

Administrator dapat mengambil soal dari Bank Soal.

Priority

Critical

Acceptance Criteria

Soal dapat dipilih dan ditambahkan ke ujian.

---

## FR-QB-024

Administrator dapat mencari soal.

Priority

High

Search By

* Judul
* Tag
* Mata Pelajaran
* Bab
* Tingkat Kesulitan

---

## FR-QB-025

Administrator dapat memfilter soal.

Priority

Medium

Filter

* Subject
* Class
* Difficulty
* Tag
* Creator

---

## FR-QB-026

Administrator dapat menduplikasi soal dari Bank Soal.

Priority

Medium

Acceptance Criteria

Soal baru memiliki Question ID yang berbeda.

---

# PREVIEW

---

## FR-QB-027

Title

Preview Question

Priority

Critical

Description

Administrator dapat melihat tampilan soal sebelum dipublikasikan.

Acceptance Criteria

Preview menyerupai tampilan yang akan dilihat siswa.

---

## FR-QB-028

Title

Preview Full Exam

Priority

Critical

Description

Administrator dapat melakukan simulasi ujian secara keseluruhan.

Acceptance Criteria

Menampilkan urutan soal, navigasi, timer simulasi (opsional), dan validasi dasar.

---

# VALIDATION

---

## FR-QB-029

Title

Question Validation

Priority

Critical

Description

Sistem harus memvalidasi soal sebelum ujian dipublikasikan.

Validation

* Pertanyaan wajib diisi.
* Minimal dua pilihan untuk pilihan ganda.
* Jawaban benar harus dipilih.
* Bobot nilai valid.
* Tipe soal valid.

---

## FR-QB-030

Title

Prevent Invalid Question

Priority

Critical

Description

Soal yang tidak valid tidak boleh dipublikasikan.

Acceptance Criteria

Daftar kesalahan ditampilkan agar administrator dapat memperbaikinya.

---

# BUSINESS RULES

BR-QB-001

Setiap soal harus memiliki Question ID yang unik.

---

BR-QB-002

Minimal terdapat satu jawaban benar untuk setiap soal yang membutuhkan kunci jawaban.

---

BR-QB-003

Soal yang digunakan pada ujian yang telah memiliki submission tidak boleh diubah secara langsung apabila perubahan dapat memengaruhi hasil penilaian; sistem harus mengikuti kebijakan versioning.

---

BR-QB-004

Administrator dapat menggunakan satu soal pada banyak ujian melalui Bank Soal.

---

BR-QB-005

Urutan soal yang telah disusun administrator dapat diacak saat ujian apabila fitur Shuffle Questions diaktifkan.

---

BR-QB-006

Preview harus menampilkan pengalaman yang semirip mungkin dengan aplikasi siswa agar administrator dapat memverifikasi soal sebelum publikasi.

---

# Module Completion Criteria

Modul dianggap selesai apabila Administrator dapat:

* Membuat soal.
* Mengedit soal.
* Menghapus soal.
* Menggandakan soal.
* Mengubah urutan soal.
* Menggunakan Auto Save.
* Menambahkan gambar.
* Menentukan jawaban benar.
* Mengatur bobot nilai.
* Mengelola tag dan kategori.
* Menyimpan soal ke Bank Soal.
* Mengambil soal dari Bank Soal.
* Mencari dan memfilter soal.
* Melakukan preview soal dan preview ujian.
* Memublikasikan ujian hanya setelah seluruh soal lolos validasi.

# PART 3C — FUNCTIONAL REQUIREMENTS (ADMIN)

# MODULE: STUDENT, CLASS & SUBJECT MANAGEMENT

---

# 3C.1 Module Overview

Modul Student, Class & Subject Management digunakan oleh Administrator untuk mengelola seluruh data akademik yang menjadi dasar pelaksanaan ujian.

Modul ini bertanggung jawab terhadap:

* Manajemen siswa.
* Manajemen kelas.
* Manajemen mata pelajaran.
* Penempatan siswa ke kelas.
* Aktivasi dan nonaktifasi data akademik.
* Import data massal.
* Validasi data akademik.

Seluruh ujian, penugasan kelas, dan hasil ujian bergantung pada validitas data yang dikelola dalam modul ini.

---

# 3C.2 Objectives

Administrator harus dapat:

* Mengelola data siswa.
* Mengelola data kelas.
* Mengelola data mata pelajaran.
* Menempatkan siswa ke kelas.
* Mengimpor data siswa secara massal.
* Menjaga konsistensi data akademik.
* Menghindari duplikasi data.

---

# CLASS MANAGEMENT

---

## FR-CLS-001

### Title

Create Class

### Priority

Critical

### Description

Administrator dapat membuat kelas baru.

### Required Fields

* Nama Kelas
* Tingkat Kelas
* Tahun Ajaran

### Acceptance Criteria

Kelas berhasil dibuat dan memiliki Class ID unik.

---

## FR-CLS-002

### Title

Edit Class

### Priority

Critical

### Description

Administrator dapat mengubah informasi kelas.

### Acceptance Criteria

Perubahan tersimpan dan digunakan oleh seluruh modul terkait.

---

## FR-CLS-003

### Title

Archive Class

### Priority

Medium

### Description

Administrator dapat mengarsipkan kelas.

### Business Rules

Kelas yang diarsipkan tidak muncul pada daftar aktif.

### Acceptance Criteria

Data historis tetap tersedia.

---

## FR-CLS-004

### Title

View Class List

### Priority

Critical

### Description

Administrator dapat melihat seluruh daftar kelas.

### Acceptance Criteria

Menampilkan:

* Nama kelas
* Tingkat
* Jumlah siswa
* Status

---

## FR-CLS-005

### Title

Search Class

### Priority

Medium

### Description

Administrator dapat mencari kelas.

### Search By

* Nama kelas
* Tingkat kelas

---

## FR-CLS-006

### Title

Class Capacity Information

### Priority

Low

### Description

Sistem menampilkan jumlah siswa pada setiap kelas.

### Acceptance Criteria

Jumlah siswa diperbarui secara otomatis.

---

# SUBJECT MANAGEMENT

---

## FR-SUB-001

### Title

Create Subject

### Priority

Critical

### Description

Administrator dapat membuat mata pelajaran baru.

### Required Fields

* Nama Mata Pelajaran
* Kode Mata Pelajaran

### Acceptance Criteria

Subject berhasil dibuat.

---

## FR-SUB-002

### Title

Edit Subject

### Priority

Critical

### Description

Administrator dapat mengubah informasi mata pelajaran.

### Acceptance Criteria

Perubahan tersimpan.

---

## FR-SUB-003

### Title

Archive Subject

### Priority

Medium

### Description

Administrator dapat mengarsipkan mata pelajaran.

### Acceptance Criteria

Mata pelajaran tidak muncul pada daftar aktif.

---

## FR-SUB-004

### Title

View Subject List

### Priority

Critical

### Description

Administrator dapat melihat seluruh daftar mata pelajaran.

### Acceptance Criteria

Menampilkan:

* Nama
* Kode
* Status

---

## FR-SUB-005

### Title

Search Subject

### Priority

Medium

### Description

Administrator dapat mencari mata pelajaran.

---

# STUDENT MANAGEMENT

---

## FR-STDM-001

### Title

Create Student

### Priority

Critical

### Description

Administrator dapat menambahkan siswa baru.

### Required Fields

* Nama Lengkap
* Email Google
* NIS/NISN (opsional sesuai kebijakan sekolah)
* Kelas

### Acceptance Criteria

Data siswa berhasil dibuat.

---

## FR-STDM-002

### Title

Edit Student

### Priority

Critical

### Description

Administrator dapat mengubah data siswa.

### Acceptance Criteria

Perubahan tersimpan.

---

## FR-STDM-003

### Title

Deactivate Student

### Priority

High

### Description

Administrator dapat menonaktifkan akun siswa.

### Business Rules

Siswa tidak dapat login selama status nonaktif.

### Acceptance Criteria

Akses siswa ditolak setelah dinonaktifkan.

---

## FR-STDM-004

### Title

Reactivate Student

### Priority

High

### Description

Administrator dapat mengaktifkan kembali akun siswa.

### Acceptance Criteria

Siswa dapat login kembali.

---

## FR-STDM-005

### Title

View Student List

### Priority

Critical

### Description

Administrator dapat melihat daftar seluruh siswa.

### Acceptance Criteria

Menampilkan:

* Nama
* Email
* Kelas
* Status

---

## FR-STDM-006

### Title

Student Detail View

### Priority

Critical

### Description

Administrator dapat melihat detail siswa.

### Acceptance Criteria

Menampilkan:

* Informasi profil
* Kelas
* Riwayat ujian
* Nilai

---

## FR-STDM-007

### Title

Search Student

### Priority

Critical

### Description

Administrator dapat mencari siswa.

### Search By

* Nama
* Email
* NIS/NISN

---

## FR-STDM-008

### Title

Filter Student

### Priority

High

### Description

Administrator dapat memfilter siswa.

### Filter By

* Kelas
* Status
* Tingkat

---

# STUDENT CLASS ASSIGNMENT

---

## FR-STDM-009

### Title

Assign Student To Class

### Priority

Critical

### Description

Administrator dapat menempatkan siswa ke kelas tertentu.

### Acceptance Criteria

Siswa muncul pada daftar anggota kelas.

---

## FR-STDM-010

### Title

Move Student Between Classes

### Priority

High

### Description

Administrator dapat memindahkan siswa ke kelas lain.

### Acceptance Criteria

Data kelas diperbarui secara otomatis.

---

## FR-STDM-011

### Title

Bulk Class Assignment

### Priority

Medium

### Description

Administrator dapat memindahkan banyak siswa sekaligus.

### Acceptance Criteria

Perubahan massal berhasil dilakukan.

---

# IMPORT & EXPORT

---

## FR-STDM-012

### Title

Import Students From Excel

### Priority

Critical

### Description

Administrator dapat mengimpor data siswa secara massal.

### Supported Formats

* XLSX
* CSV

### Acceptance Criteria

Data valid berhasil masuk ke sistem.

---

## FR-STDM-013

### Title

Download Import Template

### Priority

High

### Description

Administrator dapat mengunduh template import.

### Acceptance Criteria

Template sesuai format yang diterima sistem.

---

## FR-STDM-014

### Title

Import Validation

### Priority

Critical

### Description

Sistem memvalidasi data sebelum import.

### Validation

* Email wajib valid.
* Nama wajib diisi.
* Kelas harus tersedia.
* Tidak boleh ada duplikasi yang melanggar aturan sistem.

### Acceptance Criteria

Baris yang gagal divalidasi ditampilkan dalam laporan kesalahan.

---

## FR-STDM-015

### Title

Export Student Data

### Priority

Medium

### Description

Administrator dapat mengekspor data siswa.

### Supported Formats

* Excel
* CSV

---

# ACCOUNT MANAGEMENT

---

## FR-STDM-016

### Title

Student Google Account Verification

### Priority

Critical

### Description

Sistem memverifikasi bahwa email siswa sesuai dengan akun Google yang digunakan saat login.

### Acceptance Criteria

Hanya akun yang terdaftar yang dapat mengakses aplikasi.

---

## FR-STDM-017

### Title

Prevent Duplicate Student Account

### Priority

Critical

### Description

Sistem mencegah pembuatan akun siswa ganda.

### Validation

* Email harus unik.
* Student ID harus unik.

---

## FR-STDM-018

### Title

Student Status Tracking

### Priority

Medium

### Description

Sistem menyimpan status siswa.

### Status

* Active
* Inactive
* Graduated (Future)
* Archived

---

# AUDIT & HISTORY

---

## FR-STDM-019

### Title

Audit Student Changes

### Priority

High

### Description

Sistem mencatat perubahan data siswa.

### Acceptance Criteria

Tersimpan:

* Waktu perubahan
* Admin yang melakukan perubahan
* Data sebelum dan sesudah perubahan

---

## FR-STDM-020

### Title

Class Membership History

### Priority

Medium

### Description

Sistem menyimpan riwayat perpindahan kelas siswa.

### Acceptance Criteria

Riwayat dapat ditampilkan saat dibutuhkan.

---

# BUSINESS RULES

BR-CLS-001

Setiap kelas harus memiliki Class ID unik.

---

BR-CLS-002

Nama kelas tidak boleh kosong.

---

BR-SUB-001

Setiap mata pelajaran harus memiliki Subject ID unik.

---

BR-STDM-001

Setiap siswa harus memiliki email Google yang unik.

---

BR-STDM-002

Siswa hanya boleh berada pada satu kelas aktif pada waktu yang sama (untuk versi pertama sistem).

---

BR-STDM-003

Siswa yang berstatus Inactive tidak dapat login.

---

BR-STDM-004

Perubahan kelas siswa harus tercatat dalam riwayat.

---

BR-STDM-005

Import data tidak boleh mengubah data yang sudah ada tanpa konfirmasi administrator.

---

BR-STDM-006

Data siswa yang pernah memiliki submission ujian tidak boleh dihapus permanen untuk menjaga integritas data historis.

---

# Module Completion Criteria

Modul dianggap selesai apabila Administrator dapat:

* Membuat kelas.
* Mengelola kelas.
* Membuat mata pelajaran.
* Mengelola mata pelajaran.
* Menambahkan siswa.
* Mengubah data siswa.
* Menonaktifkan siswa.
* Menempatkan siswa ke kelas.
* Memindahkan siswa antar kelas.
* Mengimpor siswa dari Excel.
* Mengekspor data siswa.
* Melakukan pencarian dan filter.
* Memastikan tidak ada akun siswa ganda.
* Menyimpan riwayat perubahan data akademik.

# PART 3D — FUNCTIONAL REQUIREMENTS (ADMIN)

# MODULE: RESPONSES, SCORING & ANALYTICS

---

# 3D.1 Module Overview

Modul Responses, Scoring & Analytics digunakan oleh Administrator untuk memantau pelaksanaan ujian, melihat jawaban siswa, melakukan penilaian otomatis, dan menghasilkan laporan statistik.

Modul ini mengambil data dari seluruh sesi ujian siswa (Submission) dan menyajikannya dalam bentuk informasi yang mudah dipahami.

---

# 3D.2 Objectives

Administrator harus dapat:

* Memantau peserta ujian secara real-time.
* Melihat jawaban setiap siswa.
* Mengetahui status pengerjaan ujian.
* Melihat nilai otomatis.
* Menganalisis hasil ujian.
* Mengekspor hasil ujian.
* Menghasilkan laporan.

---

# LIVE EXAM MONITORING

---

## FR-RSP-001

### Title

Live Exam Dashboard

### Priority

Critical

### Description

Administrator dapat melihat dashboard monitoring ujian secara real-time.

### Acceptance Criteria

Dashboard menampilkan:

* Jumlah peserta
* Sedang mengerjakan
* Sudah selesai
* Belum mulai
* Timeout (jika ada)

---

## FR-RSP-002

### Title

Participant Status

### Priority

Critical

### Description

Status setiap peserta harus ditampilkan.

### Status

* Not Started
* In Progress
* Submitted
* Auto Submitted
* Expired

---

## FR-RSP-003

### Title

Live Timer

### Priority

High

### Description

Administrator dapat melihat sisa waktu setiap peserta yang sedang mengerjakan.

---

## FR-RSP-004

### Title

Submission Timestamp

### Priority

High

### Description

Sistem menyimpan waktu:

* Mulai ujian
* Submit
* Auto submit

---

# RESPONSES

---

## FR-RSP-005

### Title

View All Responses

### Priority

Critical

### Description

Administrator dapat melihat seluruh jawaban siswa.

### Acceptance Criteria

Menampilkan:

* Nama
* Kelas
* Nilai
* Status

---

## FR-RSP-006

### Title

View Student Response Detail

### Priority

Critical

### Description

Administrator dapat membuka detail jawaban seorang siswa.

### Acceptance Criteria

Menampilkan:

* Semua soal
* Jawaban siswa
* Jawaban benar
* Status benar/salah
* Skor per soal

---

## FR-RSP-007

### Title

Question Review

### Priority

High

### Description

Administrator dapat melihat statistik pada setiap soal.

### Acceptance Criteria

Menampilkan:

* Jumlah benar
* Jumlah salah
* Persentase benar
* Persentase salah

---

## FR-RSP-008

### Title

Search Responses

### Priority

Medium

### Description

Administrator dapat mencari submission berdasarkan:

* Nama siswa
* Kelas
* Email

---

## FR-RSP-009

### Title

Filter Responses

### Priority

Medium

### Description

Administrator dapat memfilter data berdasarkan:

* Kelas
* Status
* Nilai
* Mata pelajaran

---

# AUTO SCORING

---

## FR-SCR-001

### Title

Automatic Scoring

### Priority

Critical

### Description

Sistem menghitung nilai secara otomatis setelah submission selesai.

### Acceptance Criteria

Nilai muncul tanpa proses manual.

---

## FR-SCR-002

### Title

Score Calculation

### Priority

Critical

### Description

Perhitungan nilai menggunakan bobot setiap soal.

### Acceptance Criteria

Nilai akhir sesuai konfigurasi bobot soal.

---

## FR-SCR-003

### Title

Passing Grade Evaluation

### Priority

High

### Description

Sistem menentukan status Lulus/Tidak Lulus berdasarkan nilai minimum (passing grade) yang dikonfigurasi pada ujian.

### Acceptance Criteria

Status ditampilkan bersama nilai akhir.

---

## FR-SCR-004

### Title

Per Question Score

### Priority

Medium

### Description

Administrator dapat melihat skor setiap soal.

---

## FR-SCR-005

### Title

Score Summary

### Priority

High

### Description

Sistem menghasilkan ringkasan nilai.

### Ringkasan

* Nilai
* Jumlah benar
* Jumlah salah
* Tidak dijawab

---

# ANALYTICS

---

## FR-ANL-001

### Title

Exam Statistics

### Priority

Critical

### Description

Sistem menghasilkan statistik ujian.

### Menampilkan

* Nilai rata-rata
* Nilai tertinggi
* Nilai terendah
* Median (opsional)
* Jumlah peserta

---

## FR-ANL-002

### Title

Question Difficulty Analysis

### Priority

Medium

### Description

Sistem menghitung tingkat kesulitan soal berdasarkan persentase jawaban benar.

---

## FR-ANL-003

### Title

Correct Answer Distribution

### Priority

Medium

### Description

Sistem menampilkan distribusi jawaban pada setiap opsi.

### Contoh

A = 10

B = 15

C = 2

D = 5

---

## FR-ANL-004

### Title

Student Ranking

### Priority

Low

### Description

Sistem dapat menghasilkan ranking siswa apabila fitur diaktifkan oleh sekolah.

---

## FR-ANL-005

### Title

Class Comparison

### Priority

Medium

### Description

Administrator dapat membandingkan hasil antar kelas.

---

# REPORT

---

## FR-RPT-001

### Title

Export Excel

### Priority

Critical

### Description

Administrator dapat mengekspor hasil ujian ke Excel.

---

## FR-RPT-002

### Title

Export CSV

### Priority

High

### Description

Administrator dapat mengekspor data ke CSV.

---

## FR-RPT-003

### Title

Export PDF

### Priority

Medium

### Description

Administrator dapat menghasilkan laporan PDF.

---

## FR-RPT-004

### Title

Print Report

### Priority

Medium

### Description

Administrator dapat mencetak laporan hasil ujian.

---

# AUDIT

---

## FR-AUD-001

### Title

Submission Audit

### Priority

High

### Description

Sistem mencatat aktivitas submission.

### Menyimpan

* Waktu mulai
* Waktu selesai
* Auto submit
* Device ID (jika digunakan)
* Versi aplikasi (opsional)

---

## FR-AUD-002

### Title

Exam Activity Log

### Priority

Medium

### Description

Administrator dapat melihat log aktivitas terkait ujian.

---

# BUSINESS RULES

BR-RSP-001

Setiap submission hanya dimiliki oleh satu siswa.

---

BR-RSP-002

Submission yang telah selesai tidak dapat diubah oleh siswa.

---

BR-SCR-001

Nilai dihitung secara otomatis segera setelah submission selesai atau auto submit.

---

BR-SCR-002

Bobot soal harus diperhitungkan dalam nilai akhir.

---

BR-ANL-001

Statistik hanya menggunakan submission yang telah selesai.

---

BR-RPT-001

Data laporan harus sesuai dengan data yang tersimpan di Firestore.

---

BR-AUD-001

Seluruh aktivitas penting harus dicatat untuk keperluan audit dan investigasi.

---

# Module Completion Criteria

Modul dianggap selesai apabila Administrator dapat:

* Memantau ujian secara real-time.
* Melihat status seluruh peserta.
* Melihat jawaban setiap siswa.
* Melihat detail jawaban per soal.
* Melakukan penilaian otomatis.
* Menghasilkan nilai akhir.
* Menampilkan statistik ujian.
* Menganalisis tingkat kesulitan soal.
* Membandingkan hasil antar kelas.
* Mengekspor laporan ke Excel, CSV, dan PDF.
* Mencetak laporan.
* Mengakses audit log aktivitas ujian.

# PART 3E — FUNCTIONAL REQUIREMENTS (ADMIN)

# MODULE: SETTINGS, IMPORT/EXPORT & ADVANCED FEATURES

---

# 3E.1 Module Overview

Modul **Settings, Import/Export & Advanced Features** digunakan untuk mengelola konfigurasi sistem Easy Exam secara keseluruhan.

Modul ini hanya dapat diakses oleh Administrator dan berfungsi sebagai pusat konfigurasi aplikasi, termasuk pengaturan akademik, ekspor/impor data, keamanan, notifikasi, serta pemeliharaan sistem.

---

# 3E.2 Objectives

Administrator harus dapat:

* Mengelola pengaturan aplikasi.
* Mengatur tahun ajaran.
* Mengatur identitas sekolah.
* Mengelola konfigurasi ujian.
* Mengimpor dan mengekspor data.
* Melihat audit log.
* Melakukan backup konfigurasi.
* Mengaktifkan mode pemeliharaan.

---

# ACADEMIC SETTINGS

---

## FR-SET-001

### Title

Academic Year Management

### Priority

Critical

### Description

Administrator dapat membuat dan mengelola Tahun Ajaran.

### Required Fields

* Nama Tahun Ajaran
* Tanggal Mulai
* Tanggal Berakhir
* Status (Active / Inactive)

### Acceptance Criteria

Hanya satu Tahun Ajaran yang dapat berstatus **Active** pada satu waktu.

---

## FR-SET-002

### Title

Semester Management

### Priority

High

### Description

Administrator dapat menentukan Semester Aktif.

### Supported Values

* Semester Ganjil
* Semester Genap

---

## FR-SET-003

### Title

School Profile

### Priority

Medium

### Description

Administrator dapat mengelola informasi sekolah.

### Fields

* Nama Sekolah
* Logo Sekolah
* Alamat
* Email
* Nomor Telepon

---

# EXAM DEFAULT SETTINGS

---

## FR-SET-004

### Title

Default Exam Duration

### Priority

Medium

### Description

Administrator dapat menentukan durasi default saat membuat ujian baru.

---

## FR-SET-005

### Title

Default Passing Grade

### Priority

Medium

### Description

Administrator dapat menentukan nilai kelulusan default.

---

## FR-SET-006

### Title

Default Shuffle Setting

### Priority

Medium

### Description

Administrator dapat menentukan apakah fitur pengacakan soal dan pilihan jawaban aktif secara default ketika membuat ujian baru.

---

## FR-SET-007

### Title

Default Auto Submit

### Priority

High

### Description

Administrator dapat menentukan apakah Auto Submit aktif secara default saat waktu habis.

---

# IMPORT & EXPORT

---

## FR-IMP-001

### Title

Import Classes

### Priority

Medium

### Description

Administrator dapat mengimpor data kelas.

### Supported Formats

* XLSX
* CSV

---

## FR-IMP-002

### Title

Import Subjects

### Priority

Medium

### Description

Administrator dapat mengimpor data mata pelajaran.

---

## FR-IMP-003

### Title

Import Question Bank

### Priority

High

### Description

Administrator dapat mengimpor soal ke Bank Soal.

### Acceptance Criteria

Seluruh soal yang valid masuk ke Bank Soal tanpa mengganggu data yang sudah ada.

---

## FR-EXP-001

### Title

Export Question Bank

### Priority

High

### Description

Administrator dapat mengekspor Bank Soal.

---

## FR-EXP-002

### Title

Export Master Data

### Priority

Medium

### Description

Administrator dapat mengekspor data:

* Siswa
* Kelas
* Mata Pelajaran

---

# SYSTEM CONFIGURATION

---

## FR-SYS-001

### Title

Application Configuration

### Priority

High

### Description

Administrator dapat mengubah konfigurasi umum aplikasi.

### Configurations

* Nama Aplikasi
* Logo
* Warna Tema
* Bahasa (Future)
* Zona Waktu

---

## FR-SYS-002

### Title

Maintenance Mode

### Priority

Critical

### Description

Administrator dapat mengaktifkan mode pemeliharaan.

### Business Rules

Saat aktif:

* Siswa tidak dapat login.
* Siswa yang belum memulai ujian tidak dapat memulai sesi baru.
* Admin tetap dapat mengakses dashboard.
* Siswa yang sedang mengerjakan ujian mengikuti kebijakan yang ditentukan (misalnya tetap diizinkan menyelesaikan ujian).

---

## FR-SYS-003

### Title

Application Version

### Priority

Low

### Description

Dashboard menampilkan versi aplikasi yang sedang digunakan.

---

# NOTIFICATION SETTINGS

---

## FR-NTF-001

### Title

Push Notification Configuration

### Priority

Medium

### Description

Administrator dapat mengaktifkan atau menonaktifkan notifikasi push.

---

## FR-NTF-002

### Title

Exam Reminder

### Priority

Medium

### Description

Sistem dapat mengirim pengingat ujian kepada siswa.

---

## FR-NTF-003

### Title

Result Notification

### Priority

Low

### Description

Sistem dapat mengirim notifikasi ketika hasil ujian dipublikasikan.

---

# BACKUP & RESTORE

---

## FR-BKP-001

### Title

Backup Configuration

### Priority

Medium

### Description

Administrator dapat mencadangkan konfigurasi aplikasi.

---

## FR-BKP-002

### Title

Restore Configuration

### Priority

Medium

### Description

Administrator dapat mengembalikan konfigurasi dari hasil backup.

### Business Rules

Restore hanya berlaku untuk konfigurasi sistem dan tidak menghapus data hasil ujian tanpa konfirmasi khusus.

---

# AUDIT LOG

---

## FR-LOG-001

### Title

System Activity Log

### Priority

High

### Description

Sistem mencatat seluruh aktivitas penting Administrator.

### Logged Activities

* Login
* Logout
* Membuat Ujian
* Mengedit Ujian
* Menghapus Ujian
* Import
* Export
* Perubahan Konfigurasi

---

## FR-LOG-002

### Title

Audit Log Viewer

### Priority

Medium

### Description

Administrator dapat melihat riwayat aktivitas.

### Acceptance Criteria

Menyediakan:

* Waktu
* Pengguna
* Jenis Aktivitas
* Detail Aktivitas

---

# SECURITY SETTINGS

---

## FR-SEC-001

### Title

Session Timeout Configuration

### Priority

Medium

### Description

Administrator dapat menentukan batas waktu sesi admin yang tidak aktif sebelum sistem meminta login ulang.

---

## FR-SEC-002

### Title

Force Logout

### Priority

Medium

### Description

Administrator dapat mengakhiri seluruh sesi login aktif apabila diperlukan, misalnya setelah perubahan kebijakan keamanan.

---

## FR-SEC-003

### Title

Allowed Email Domain

### Priority

High

### Description

Administrator dapat membatasi login hanya untuk domain email tertentu (misalnya akun Google sekolah).

### Acceptance Criteria

Pengguna dengan domain yang tidak diizinkan tidak dapat login.

---

# FUTURE CONFIGURATION

---

## FR-FUT-001

### Title

Feature Flags

### Priority

Low

### Description

Sistem mendukung aktivasi atau penonaktifan fitur tertentu tanpa mengubah kode aplikasi.

---

## FR-FUT-002

### Title

AI Integration Configuration

### Priority

Future

### Description

Menyediakan konfigurasi untuk integrasi AI pada versi mendatang, seperti generator soal atau analisis hasil belajar.

---

# BUSINESS RULES

BR-SET-001

Hanya Administrator yang dapat mengubah konfigurasi sistem.

---

BR-SET-002

Hanya satu Tahun Ajaran yang boleh aktif.

---

BR-SYS-001

Mode pemeliharaan harus memberikan pemberitahuan yang jelas kepada pengguna.

---

BR-LOG-001

Seluruh perubahan konfigurasi harus tercatat pada Audit Log.

---

BR-SEC-001

Perubahan pengaturan keamanan berlaku untuk seluruh sesi baru setelah disimpan, kecuali dinyatakan lain.

---

# Module Completion Criteria

Modul dianggap selesai apabila Administrator dapat:

* Mengelola Tahun Ajaran dan Semester.
* Mengelola profil sekolah.
* Menentukan konfigurasi default ujian.
* Mengimpor dan mengekspor data akademik serta Bank Soal.
* Mengelola konfigurasi aplikasi.
* Mengaktifkan atau menonaktifkan mode pemeliharaan.
* Mengelola pengaturan notifikasi.
* Melakukan backup dan restore konfigurasi.
* Melihat Audit Log.
* Mengelola pengaturan keamanan dasar sistem.

# PART 4A — FUNCTIONAL REQUIREMENTS (STUDENT)

# MODULE: AUTHENTICATION & STUDENT DASHBOARD

---

# 4A.1 Module Overview

Modul **Authentication & Student Dashboard** merupakan pintu masuk utama bagi seluruh siswa yang menggunakan aplikasi Easy Exam.

Setelah berhasil melakukan autentikasi menggunakan akun Google yang telah terdaftar, siswa akan diarahkan ke Dashboard yang menampilkan informasi pribadi, daftar ujian, dan status akademik yang berkaitan dengan ujian.

Seluruh akses siswa harus divalidasi menggunakan Firebase Authentication dan Firebase Firestore Security Rules.

---

# 4A.2 Objectives

Siswa harus dapat:

* Login menggunakan akun Google.
* Tetap login hingga logout.
* Melihat informasi profil.
* Melihat daftar ujian.
* Melihat status ujian.
* Mengakses ujian yang tersedia.
* Logout dengan aman.

---

# SPLASH SCREEN

---

## FR-STD-001

### Title

Splash Screen

### Priority

Critical

### Description

Saat aplikasi dibuka, sistem menampilkan Splash Screen sebagai halaman awal.

### Acceptance Criteria

Menampilkan:

* Logo Easy Exam
* Nama aplikasi
* Versi aplikasi (opsional)
* Loading Indicator

---

## FR-STD-002

### Title

Session Checking

### Priority

Critical

### Description

Sistem memeriksa apakah pengguna masih memiliki sesi login yang valid.

### Acceptance Criteria

Jika session masih aktif

↓

Langsung menuju Dashboard.

Jika tidak ada session

↓

Menuju Login Screen.

---

# AUTHENTICATION

---

## FR-STD-003

### Title

Google Sign In

### Priority

Critical

### Description

Siswa login menggunakan akun Google.

### Acceptance Criteria

* Login berhasil.
* Firebase Authentication berhasil.
* Session dibuat.
* Firestore melakukan validasi role.

---

## FR-STD-004

### Title

Unauthorized Account

### Priority

Critical

### Description

Akun Google yang tidak terdaftar tidak boleh masuk ke sistem.

### Acceptance Criteria

Menampilkan pesan:

> "Akun Anda belum terdaftar. Silakan hubungi guru atau administrator."

---

## FR-STD-005

### Title

Session Persistence

### Priority

Critical

### Description

Sistem mempertahankan sesi login.

### Acceptance Criteria

Siswa tidak perlu login ulang selama session masih valid.

---

## FR-STD-006

### Title

Logout

### Priority

High

### Description

Siswa dapat logout dari aplikasi.

### Acceptance Criteria

* Session dihapus.
* Firebase Sign Out berhasil.
* Kembali ke Login Screen.

---

# STUDENT DASHBOARD

---

## FR-STD-007

### Title

Dashboard Home

### Priority

Critical

### Description

Setelah login berhasil, siswa diarahkan ke Dashboard.

### Dashboard Components

* Header Profil
* Informasi Kelas
* Daftar Ujian
* Ringkasan Status
* Menu Profil

---

## FR-STD-008

### Title

Student Profile Card

### Priority

Critical

### Description

Dashboard menampilkan identitas siswa.

### Menampilkan

* Foto Profil
* Nama
* Email
* Kelas
* Tahun Ajaran Aktif

---

## FR-STD-009

### Title

Greeting Message

### Priority

Low

### Description

Dashboard menampilkan ucapan sesuai waktu.

### Contoh

Selamat Pagi

Selamat Siang

Selamat Sore

---

# AVAILABLE EXAMS

---

## FR-STD-010

### Title

Available Exam List

### Priority

Critical

### Description

Dashboard menampilkan daftar ujian yang tersedia.

### Acceptance Criteria

Hanya ujian yang:

* Active
* Published
* Sesuai kelas
* Berada dalam jadwal

---

## FR-STD-011

### Title

Exam Card

### Priority

Critical

### Description

Setiap ujian ditampilkan dalam bentuk kartu.

### Informasi

* Nama Ujian
* Mata Pelajaran
* Guru
* Durasi
* Jadwal
* Status

---

## FR-STD-012

### Title

Exam Status

### Priority

Critical

### Description

Setiap ujian memiliki status.

### Status

* Belum Dimulai
* Tersedia
* Sedang Dikerjakan
* Selesai
* Ditutup
* Terlambat

---

## FR-STD-013

### Title

Upcoming Exams

### Priority

Medium

### Description

Dashboard menampilkan ujian yang akan datang.

---

## FR-STD-014

### Title

Completed Exams

### Priority

Medium

### Description

Dashboard menampilkan riwayat ujian yang telah diselesaikan.

---

# DASHBOARD FEATURES

---

## FR-STD-015

### Title

Pull To Refresh

### Priority

Medium

### Description

Siswa dapat memperbarui data dashboard dengan menarik layar ke bawah.

---

## FR-STD-016

### Title

Realtime Dashboard Update

### Priority

High

### Description

Dashboard memperbarui informasi ketika terdapat perubahan data dari server.

---

## FR-STD-017

### Title

Offline Information

### Priority

Medium

### Description

Jika koneksi internet terputus, dashboard menampilkan indikator offline.

### Acceptance Criteria

Data terakhir yang berhasil dimuat dapat tetap ditampilkan jika tersedia dalam cache.

---

# PROFILE

---

## FR-STD-018

### Title

View Profile

### Priority

Medium

### Description

Siswa dapat melihat informasi profil lengkap.

### Menampilkan

* Nama
* Email
* Kelas
* Foto
* Tahun Ajaran

---

## FR-STD-019

### Title

Profile Picture

### Priority

Low

### Description

Foto profil diambil dari akun Google.

---

## FR-STD-020

### Title

Student Information

### Priority

Medium

### Description

Dashboard menampilkan informasi tambahan.

### Contoh

* Jumlah ujian selesai
* Jumlah ujian aktif
* Jumlah ujian akan datang

---

# NOTIFICATION

---

## FR-STD-021

### Title

Exam Reminder

### Priority

Medium

### Description

Siswa menerima pengingat apabila terdapat ujian yang akan dimulai.

---

## FR-STD-022

### Title

General Notification

### Priority

Low

### Description

Sistem dapat menampilkan pengumuman dari Administrator.

---

# ERROR HANDLING

---

## FR-STD-023

### Title

Network Error

### Priority

Critical

### Description

Apabila jaringan bermasalah, sistem menampilkan pesan yang jelas dan menyediakan opsi untuk mencoba kembali.

---

## FR-STD-024

### Title

Server Error

### Priority

Critical

### Description

Apabila server tidak dapat diakses, sistem menampilkan halaman kesalahan yang ramah pengguna tanpa menyebabkan aplikasi berhenti.

---

## FR-STD-025

### Title

Force Update

### Priority

Medium

### Description

Sistem dapat meminta pengguna memperbarui aplikasi apabila versi yang digunakan sudah tidak didukung.

### Acceptance Criteria

Pengguna tidak dapat melanjutkan menggunakan aplikasi sampai melakukan pembaruan jika pembaruan bersifat wajib.

---

# BUSINESS RULES

BR-STD-001

Siswa hanya dapat login menggunakan akun Google yang telah terdaftar pada sistem.

---

BR-STD-002

Siswa hanya dapat melihat ujian yang ditujukan kepada kelasnya.

---

BR-STD-003

Siswa tidak dapat mengakses Dashboard Administrator.

---

BR-STD-004

Dashboard harus menampilkan data yang konsisten dengan status ujian terbaru.

---

BR-STD-005

Logout harus menghapus seluruh data sesi yang bersifat sensitif dari perangkat.

---

# Module Completion Criteria

Modul dianggap selesai apabila siswa dapat:

* Membuka aplikasi dan melihat Splash Screen.
* Login menggunakan akun Google.
* Mempertahankan sesi login.
* Melihat Dashboard.
* Melihat informasi profil.
* Melihat daftar ujian yang tersedia.
* Melihat status setiap ujian.
* Melihat riwayat ujian.
* Menerima pengingat ujian.
* Logout dengan aman.

# PART 4B — FUNCTIONAL REQUIREMENTS (STUDENT)

# MODULE: EXAM SESSION

---

# 4B.1 Module Overview

Modul **Exam Session** mengatur seluruh siklus pelaksanaan ujian sejak siswa memilih ujian hingga sesi ujian berhasil dimulai.

Modul ini bertanggung jawab untuk memvalidasi kelayakan siswa mengikuti ujian, menginisialisasi sesi ujian, mengaktifkan timer, serta memastikan hanya satu sesi ujian aktif yang dapat dijalankan oleh setiap siswa pada satu waktu.

Seluruh status sesi harus disimpan di backend sehingga dapat dipulihkan apabila terjadi gangguan yang masih sesuai dengan kebijakan sistem.

---

# 4B.2 Objectives

Siswa harus dapat:

* Memulai ujian.
* Membaca petunjuk ujian.
* Mengonfirmasi kesiapan.
* Memulai sesi ujian.
* Melanjutkan sesi yang masih aktif (sesuai kebijakan).
* Melihat timer.
* Menyelesaikan ujian dengan aman.

---

# EXAM ACCESS

---

## FR-EXS-001

### Title

Open Exam Detail

### Priority

Critical

### Description

Siswa dapat membuka halaman detail ujian sebelum memulai.

### Acceptance Criteria

Menampilkan:

* Nama ujian
* Mata pelajaran
* Guru
* Durasi
* Jumlah soal
* Jadwal
* Aturan ujian

---

## FR-EXS-002

### Title

Exam Eligibility Validation

### Priority

Critical

### Description

Sistem memvalidasi apakah siswa berhak mengikuti ujian.

### Validation

* Akun aktif
* Kelas sesuai
* Ujian aktif
* Belum melewati jadwal
* Belum pernah menyelesaikan ujian (jika hanya boleh satu kali)

### Acceptance Criteria

Jika salah satu syarat tidak terpenuhi, ujian tidak dapat dimulai dan alasan ditampilkan kepada siswa.

---

## FR-EXS-003

### Title

Exam Instruction Page

### Priority

Critical

### Description

Sebelum ujian dimulai, siswa harus membaca halaman petunjuk.

### Menampilkan

* Durasi
* Jumlah soal
* Aturan ujian
* Informasi auto submit
* Informasi anti-cheat
* Informasi bahwa ujian tidak dapat diulang (jika berlaku)

---

## FR-EXS-004

### Title

Exam Confirmation

### Priority

Critical

### Description

Siswa harus memberikan konfirmasi sebelum sesi dimulai.

### Acceptance Criteria

Dialog konfirmasi menjelaskan bahwa waktu akan langsung berjalan setelah tombol **Mulai Ujian** ditekan.

---

# SESSION INITIALIZATION

---

## FR-EXS-005

### Title

Create Exam Session

### Priority

Critical

### Description

Sistem membuat sesi ujian baru ketika siswa memulai ujian.

### Acceptance Criteria

Sistem membuat:

* Session ID
* Start Time
* Status = In Progress
* Urutan soal (jika diacak)
* Urutan pilihan jawaban (jika diacak)

---

## FR-EXS-006

### Title

Start Countdown Timer

### Priority

Critical

### Description

Timer dimulai segera setelah sesi berhasil dibuat.

### Acceptance Criteria

Waktu terus berjalan hingga:

* Siswa submit.
* Auto submit.
* Sesi dibatalkan oleh kebijakan sistem.

---

## FR-EXS-007

### Title

Single Active Session

### Priority

Critical

### Description

Setiap siswa hanya boleh memiliki satu sesi ujian aktif untuk satu ujian.

### Acceptance Criteria

Tidak boleh ada duplikasi sesi aktif.

---

# SESSION RECOVERY

---

## FR-EXS-008

### Title

Resume Exam Session

### Priority

High

### Description

Jika aplikasi tertutup karena gangguan teknis atau perangkat dimulai ulang, sistem dapat menawarkan untuk melanjutkan sesi apabila kebijakan sekolah mengizinkan.

### Acceptance Criteria

* Timer mengikuti waktu server.
* Jawaban yang sudah tersimpan tetap tersedia.
* Tidak membuat sesi baru.

---

## FR-EXS-009

### Title

Session Expiration

### Priority

Critical

### Description

Sesi otomatis berakhir ketika waktu habis.

### Acceptance Criteria

Status berubah menjadi **Auto Submitted**.

---

## FR-EXS-010

### Title

Session Validation

### Priority

Critical

### Description

Setiap kali aplikasi dibuka kembali, sistem memverifikasi status sesi ke server.

### Acceptance Criteria

Siswa diarahkan ke halaman yang sesuai berdasarkan status sesi.

---

# CONNECTIVITY

---

## FR-EXS-011

### Title

Connection Monitoring

### Priority

High

### Description

Sistem memantau status koneksi internet selama sesi ujian.

---

## FR-EXS-012

### Title

Temporary Connection Loss

### Priority

Critical

### Description

Apabila koneksi internet terputus sementara, aplikasi memberikan pemberitahuan kepada siswa dan tetap mempertahankan jawaban yang sudah tersimpan secara lokal jika mekanisme cache diaktifkan.

### Acceptance Criteria

Sinkronisasi dilakukan kembali ketika koneksi pulih.

---

## FR-EXS-013

### Title

Reconnect Synchronization

### Priority

High

### Description

Saat koneksi kembali normal, sistem menyinkronkan data yang belum terkirim.

---

# TIMER

---

## FR-EXS-014

### Title

Visible Countdown Timer

### Priority

Critical

### Description

Timer harus selalu terlihat selama ujian.

---

## FR-EXS-015

### Title

Low Time Warning

### Priority

Medium

### Description

Sistem memberikan peringatan ketika sisa waktu berada di bawah batas tertentu (misalnya 10 menit atau sesuai konfigurasi).

---

## FR-EXS-016

### Title

Auto Submit

### Priority

Critical

### Description

Ketika waktu habis, sistem mengirim jawaban secara otomatis.

### Acceptance Criteria

Status berubah menjadi **Completed** atau **Auto Submitted** sesuai kebijakan sistem.

---

# USER EXPERIENCE

---

## FR-EXS-017

### Title

Loading Protection

### Priority

High

### Description

Selama proses memulai ujian, tombol **Mulai Ujian** dinonaktifkan untuk mencegah pembuatan sesi ganda.

---

## FR-EXS-018

### Title

Loading Indicator

### Priority

Medium

### Description

Sistem menampilkan indikator proses saat mempersiapkan sesi ujian.

---

# ERROR HANDLING

---

## FR-EXS-019

### Title

Exam Not Available

### Priority

Critical

### Description

Apabila ujian tidak lagi tersedia, sistem menampilkan informasi yang jelas.

---

## FR-EXS-020

### Title

Unexpected Session Error

### Priority

Critical

### Description

Apabila terjadi kesalahan saat membuat sesi, sistem tidak boleh membuat data sesi yang tidak lengkap dan harus memberikan opsi untuk mencoba kembali.

---

# BUSINESS RULES

BR-EXS-001

Satu siswa hanya dapat memiliki satu sesi aktif untuk setiap ujian.

---

BR-EXS-002

Timer menggunakan waktu acuan dari server untuk mengurangi manipulasi waktu pada perangkat.

---

BR-EXS-003

Sesi dimulai segera setelah siswa menekan tombol **Mulai Ujian** dan konfirmasi diterima.

---

BR-EXS-004

Sesi yang telah selesai tidak dapat dimulai kembali.

---

BR-EXS-005

Auto Submit dilakukan ketika waktu habis meskipun siswa tidak menekan tombol **Selesai**.

---

BR-EXS-006

Resume Session hanya diperbolehkan apabila diizinkan oleh kebijakan sistem dan tidak melanggar aturan anti-cheat.

---

# Module Completion Criteria

Modul dianggap selesai apabila siswa dapat:

* Membuka detail ujian.
* Melihat petunjuk ujian.
* Memulai ujian.
* Membuat sesi ujian.
* Melihat timer.
* Melanjutkan sesi yang valid.
* Mendapatkan Auto Submit saat waktu habis.
* Menangani gangguan koneksi dengan aman.
* Menyelesaikan sesi tanpa membuat duplikasi data.

# PART 4C — FUNCTIONAL REQUIREMENTS (STUDENT)

# MODULE: QUESTION NAVIGATION & ANSWERING

---

# 4C.1 Module Overview

Modul **Question Navigation & Answering** mengatur pengalaman siswa selama mengerjakan ujian.

Sistem harus menampilkan satu soal pada satu waktu (One Question Per Page), menyediakan navigasi antar soal, menyimpan jawaban secara otomatis, serta memberikan informasi progres pengerjaan tanpa mengganggu konsentrasi siswa.

Modul ini menjadi inti dari pengalaman Computer Based Test (CBT) pada aplikasi Easy Exam.

---

# 4C.2 Objectives

Siswa harus dapat:

* Melihat satu soal pada satu waktu.
* Menjawab soal.
* Berpindah antar soal.
* Melihat progres pengerjaan.
* Menandai soal untuk ditinjau kembali.
* Menyimpan jawaban secara otomatis.

---

# QUESTION DISPLAY

---

## FR-QNA-001

### Title

One Question Per Page

### Priority

Critical

### Description

Sistem hanya menampilkan satu soal pada satu waktu.

### Acceptance Criteria

Pergantian soal dilakukan melalui tombol navigasi atau panel nomor soal.

---

## FR-QNA-002

### Title

Display Question Information

### Priority

Critical

### Description

Halaman soal menampilkan informasi berikut:

* Nomor soal
* Total soal
* Isi soal
* Gambar (jika ada)
* Pilihan jawaban
* Timer
* Indikator progres

---

## FR-QNA-003

### Title

Display Question Image

### Priority

High

### Description

Sistem menampilkan gambar yang dilampirkan pada soal dengan kualitas yang baik dan tetap menjaga proporsi gambar.

---

## FR-QNA-004

### Title

Responsive Layout

### Priority

High

### Description

Tampilan soal harus menyesuaikan berbagai ukuran layar ponsel tanpa memotong konten.

---

# ANSWERING

---

## FR-QNA-005

### Title

Select Answer

### Priority

Critical

### Description

Siswa dapat memilih satu jawaban pada soal pilihan ganda.

### Acceptance Criteria

Pilihan yang dipilih langsung ditampilkan sebagai jawaban aktif.

---

## FR-QNA-006

### Title

Change Answer

### Priority

Critical

### Description

Siswa dapat mengubah jawaban kapan saja sebelum ujian disubmit.

---

## FR-QNA-007

### Title

Clear Answer

### Priority

Medium

### Description

Apabila kebijakan sekolah mengizinkan, siswa dapat mengosongkan kembali jawaban pada suatu soal sebelum submit.

---

# AUTO SAVE

---

## FR-QNA-008

### Title

Auto Save Answer

### Priority

Critical

### Description

Setiap perubahan jawaban harus disimpan secara otomatis.

### Acceptance Criteria

Tidak diperlukan tombol **Simpan**.

---

## FR-QNA-009

### Title

Save Confirmation

### Priority

Medium

### Description

Sistem menampilkan indikator bahwa jawaban telah berhasil disimpan.

### Contoh

* Tersimpan
* Menyimpan...
* Gagal menyimpan (akan dicoba kembali)

---

# QUESTION NAVIGATION

---

## FR-QNA-010

### Title

Next Question

### Priority

Critical

### Description

Siswa dapat berpindah ke soal berikutnya.

---

## FR-QNA-011

### Title

Previous Question

### Priority

Critical

### Description

Siswa dapat kembali ke soal sebelumnya.

---

## FR-QNA-012

### Title

Question Number Sidebar

### Priority

Critical

### Description

Siswa dapat membuka panel daftar nomor soal melalui tombol menu (ikon tiga garis) di sisi kanan atas.

### Acceptance Criteria

Panel hanya menampilkan nomor soal dan statusnya. Ketika nomor dipilih, sistem langsung membuka soal terkait.

---

## FR-QNA-013

### Title

Jump To Question

### Priority

Critical

### Description

Siswa dapat langsung berpindah ke nomor soal tertentu melalui sidebar.

---

# QUESTION STATUS

---

## FR-QNA-014

### Title

Question Status Indicator

### Priority

Critical

### Description

Setiap soal memiliki status visual.

### Status

* Belum Dijawab
* Sudah Dijawab
* Ditandai untuk Ditinjau
* Soal Aktif

---

## FR-QNA-015

### Title

Flag For Review

### Priority

High

### Description

Siswa dapat menandai soal yang ingin ditinjau kembali sebelum submit.

---

## FR-QNA-016

### Title

Progress Indicator

### Priority

High

### Description

Sistem menampilkan progres pengerjaan.

### Contoh

* 15 dari 40 soal
* 20 soal telah dijawab
* 5 soal ditandai

---

# RANDOMIZATION

---

## FR-QNA-017

### Title

Random Question Order

### Priority

Critical

### Description

Apabila fitur pengacakan soal diaktifkan oleh administrator, urutan soal berbeda untuk setiap siswa.

### Acceptance Criteria

Urutan soal tetap konsisten selama sesi berlangsung.

---

## FR-QNA-018

### Title

Random Answer Options

### Priority

High

### Description

Apabila diaktifkan, urutan pilihan jawaban diacak untuk setiap siswa.

### Acceptance Criteria

Urutan pilihan tidak berubah selama sesi aktif.

---

# ACCESSIBILITY

---

## FR-QNA-019

### Title

Readable Text

### Priority

High

### Description

Ukuran teks dan jarak antar elemen harus mudah dibaca oleh siswa sekolah dasar.

---

## FR-QNA-020

### Title

Large Touch Area

### Priority

High

### Description

Seluruh tombol dan pilihan jawaban memiliki area sentuh yang cukup besar untuk meminimalkan kesalahan saat memilih jawaban.

---

# ERROR HANDLING

---

## FR-QNA-021

### Title

Recover Last State

### Priority

High

### Description

Apabila aplikasi kembali ke halaman ujian setelah gangguan yang diizinkan, sistem menampilkan soal terakhir yang sedang dikerjakan beserta jawaban yang telah tersimpan.

---

## FR-QNA-022

### Title

Failed Save Retry

### Priority

High

### Description

Apabila penyimpanan jawaban gagal karena gangguan jaringan, sistem mencoba mengirim ulang secara otomatis ketika koneksi tersedia.

---

# BUSINESS RULES

BR-QNA-001

Satu soal hanya ditampilkan satu per halaman.

---

BR-QNA-002

Jawaban dapat diubah selama ujian belum disubmit.

---

BR-QNA-003

Auto Save harus dijalankan setiap kali jawaban berubah.

---

BR-QNA-004

Nomor soal pada sidebar harus selalu mencerminkan status terbaru setiap soal.

---

BR-QNA-005

Urutan soal dan pilihan jawaban yang telah diacak tidak boleh berubah selama sesi ujian berlangsung.

---

BR-QNA-006

Status "Ditandai untuk Ditinjau" tidak memengaruhi penilaian dan hanya berfungsi sebagai pengingat bagi siswa.

---

# Module Completion Criteria

Modul dianggap selesai apabila siswa dapat:

* Melihat satu soal per halaman.
* Melihat soal bergambar dengan benar.
* Memilih, mengubah, dan (jika diizinkan) mengosongkan jawaban.
* Mendapatkan Auto Save setiap kali jawaban berubah.
* Berpindah ke soal berikutnya atau sebelumnya.
* Membuka sidebar nomor soal.
* Melompat ke soal tertentu.
* Melihat status setiap soal.
* Menandai soal untuk ditinjau.
* Melihat progres pengerjaan.
* Mengerjakan ujian dengan urutan soal dan pilihan jawaban yang konsisten selama sesi berlangsung.

# PART 4D — FUNCTIONAL REQUIREMENTS (STUDENT)

# MODULE: SUBMISSION, RESULTS, HISTORY & PROFILE

---

# 4D.1 Module Overview

Modul **Submission, Results, History & Profile** mengelola tahap akhir pelaksanaan ujian, mulai dari proses submit, penyimpanan hasil, penampilan hasil (sesuai kebijakan sekolah), riwayat ujian, hingga pengelolaan profil siswa.

Modul ini memastikan bahwa setiap sesi ujian ditutup dengan aman dan seluruh data tersimpan secara konsisten.

---

# 4D.2 Objectives

Siswa harus dapat:

* Meninjau jawaban sebelum submit.
* Mengirim hasil ujian.
* Mengetahui status submit.
* Melihat hasil (jika diizinkan).
* Melihat riwayat ujian.
* Melihat profil.
* Logout.

---

# REVIEW BEFORE SUBMIT

---

## FR-SUB-001

### Title

Review Exam

### Priority

Critical

### Description

Sebelum submit, siswa dapat meninjau kembali seluruh status soal.

### Menampilkan

* Jumlah soal
* Sudah dijawab
* Belum dijawab
* Ditandai untuk ditinjau

---

## FR-SUB-002

### Title

Navigate From Review

### Priority

High

### Description

Dari halaman review, siswa dapat kembali ke soal tertentu untuk memperbaiki jawaban sebelum submit.

---

## FR-SUB-003

### Title

Submit Confirmation

### Priority

Critical

### Description

Sebelum jawaban dikirim, sistem menampilkan dialog konfirmasi.

### Acceptance Criteria

Dialog menjelaskan bahwa setelah submit, jawaban tidak dapat diubah lagi.

---

# SUBMISSION

---

## FR-SUB-004

### Title

Manual Submit

### Priority

Critical

### Description

Siswa dapat mengirim jawaban dengan menekan tombol **Selesai Ujian**.

---

## FR-SUB-005

### Title

Submission Validation

### Priority

Critical

### Description

Sebelum submit, sistem memvalidasi bahwa sesi masih aktif dan data jawaban siap dikirim.

---

## FR-SUB-006

### Title

Submission Processing

### Priority

Critical

### Description

Selama proses submit, sistem menampilkan indikator proses dan mencegah pengiriman ganda.

---

## FR-SUB-007

### Title

Submission Success

### Priority

Critical

### Description

Apabila submit berhasil, status sesi diperbarui menjadi **Completed** dan jawaban dikunci.

---

## FR-SUB-008

### Title

Submission Failure

### Priority

Critical

### Description

Apabila submit gagal karena gangguan jaringan, sistem mencoba mengirim ulang secara otomatis selama sesi masih valid.

---

## FR-SUB-009

### Title

Auto Submit

### Priority

Critical

### Description

Apabila waktu habis, sistem mengirim seluruh jawaban yang telah tersimpan secara otomatis.

---

# RESULTS

---

## FR-RES-001

### Title

Result Visibility

### Priority

Critical

### Description

Penampilan hasil ujian mengikuti pengaturan yang ditetapkan Administrator.

### Supported Modes

* Langsung ditampilkan setelah submit.
* Ditampilkan setelah guru mempublikasikan hasil.
* Tidak ditampilkan kepada siswa.

---

## FR-RES-002

### Title

Result Summary

### Priority

Medium

### Description

Apabila hasil ditampilkan, siswa dapat melihat ringkasan.

### Menampilkan

* Nilai akhir
* Jumlah benar
* Jumlah salah
* Jumlah tidak dijawab
* Status Lulus/Tidak Lulus (jika digunakan)

---

## FR-RES-003

### Title

Answer Review

### Priority

Low

### Description

Apabila diizinkan oleh Administrator, siswa dapat melihat kembali jawaban, kunci jawaban, dan pembahasan setelah ujian selesai.

---

# HISTORY

---

## FR-HIS-001

### Title

Exam History

### Priority

Medium

### Description

Siswa dapat melihat daftar ujian yang pernah diikuti.

---

## FR-HIS-002

### Title

History Detail

### Priority

Medium

### Description

Siswa dapat membuka detail riwayat ujian.

### Menampilkan

* Nama ujian
* Mata pelajaran
* Tanggal
* Durasi
* Status
* Nilai (jika diizinkan)

---

## FR-HIS-003

### Title

History Filter

### Priority

Low

### Description

Siswa dapat memfilter riwayat berdasarkan:

* Mata pelajaran
* Tahun ajaran
* Status

---

# PROFILE

---

## FR-PRO-001

### Title

View Profile

### Priority

Medium

### Description

Siswa dapat melihat profil akun.

### Menampilkan

* Nama
* Email
* Foto
* Kelas
* Tahun Ajaran

---

## FR-PRO-002

### Title

Account Information

### Priority

Low

### Description

Sistem menampilkan informasi akun Google yang digunakan untuk login.

---

## FR-PRO-003

### Title

Privacy Information

### Priority

Low

### Description

Siswa dapat melihat informasi singkat mengenai kebijakan privasi dan penggunaan data.

---

# LOGOUT

---

## FR-LOG-001

### Title

Logout Confirmation

### Priority

Medium

### Description

Sistem meminta konfirmasi sebelum logout apabila tidak ada sesi ujian yang sedang berlangsung.

---

## FR-LOG-002

### Title

Logout Restriction During Exam

### Priority

Critical

### Description

Selama sesi ujian masih aktif, siswa tidak dapat melakukan logout.

### Acceptance Criteria

Sistem menampilkan informasi bahwa logout hanya dapat dilakukan setelah ujian selesai atau sesuai kebijakan Administrator.

---

## FR-LOG-003

### Title

Successful Logout

### Priority

High

### Description

Setelah logout berhasil:

* Session dihapus.
* Token autentikasi dibersihkan.
* Pengguna diarahkan ke halaman Login.

---

# ERROR HANDLING

---

## FR-ERR-001

### Title

Submission Timeout

### Priority

High

### Description

Apabila proses submit melebihi batas waktu yang ditentukan, sistem memberikan informasi kepada siswa dan mencoba menyelesaikan proses secara aman tanpa menyebabkan duplikasi submission.

---

## FR-ERR-002

### Title

Duplicate Submission Prevention

### Priority

Critical

### Description

Sistem mencegah satu sesi ujian dikirim lebih dari satu kali.

---

# BUSINESS RULES

BR-SUB-001

Submission hanya dapat dilakukan satu kali untuk setiap sesi ujian.

---

BR-SUB-002

Jawaban tidak dapat diubah setelah status sesi menjadi **Completed** atau **Auto Submitted**.

---

BR-RES-001

Penampilan nilai mengikuti konfigurasi Administrator.

---

BR-HIS-001

Riwayat ujian hanya dapat diakses oleh pemilik akun yang bersangkutan.

---

BR-LOG-001

Logout tidak diperbolehkan selama sesi ujian aktif, kecuali terdapat kebijakan khusus dari sistem.

---

# Module Completion Criteria

Modul dianggap selesai apabila siswa dapat:

* Meninjau jawaban sebelum submit.
* Kembali ke soal tertentu dari halaman review.
* Melakukan submit secara manual.
* Mendapatkan Auto Submit ketika waktu habis.
* Melihat hasil ujian sesuai kebijakan sekolah.
* Melihat riwayat ujian.
* Melihat detail riwayat.
* Melihat profil akun.
* Logout dengan aman setelah tidak ada sesi ujian aktif.

# PART 5A — SOFTWARE ARCHITECTURE SPECIFICATION (SAS)

# CORE EXAM ENGINE

Version : 1.0

Project : Easy Exam

---

# 5A.1 Overview

Core Exam Engine merupakan inti dari seluruh aplikasi Easy Exam.

Seluruh proses ujian dijalankan, divalidasi, dan dikontrol oleh Engine ini.

UI Flutter tidak diperbolehkan memiliki business logic utama terkait ujian. Seluruh aturan bisnis harus berada di dalam Core Exam Engine sehingga antarmuka hanya bertugas menampilkan data dan meneruskan aksi pengguna.

Core Exam Engine bertanggung jawab terhadap:

* Manajemen sesi ujian.
* Navigasi soal.
* Pengaturan timer.
* Penyimpanan jawaban.
* Sinkronisasi data.
* Pengelolaan status ujian.
* Pemulihan sesi.
* Integrasi dengan Security & Anti-Cheat Engine.

---

# 5A.2 Objectives

Core Exam Engine harus mampu:

* Menginisialisasi sesi ujian.
* Mengelola seluruh state ujian.
* Menjamin konsistensi data jawaban.
* Mengatur alur navigasi soal.
* Menyinkronkan data dengan Firebase.
* Menangani gangguan koneksi.
* Menyediakan API internal yang stabil untuk Presentation Layer.

---

# 5A.3 High-Level Architecture

```text
Flutter Presentation Layer
        │
        ▼
Application Layer
        │
        ▼
Core Exam Engine
 ├── Session Engine
 ├── Navigation Engine
 ├── Timer Engine
 ├── Answer Engine
 ├── Auto Save Engine
 ├── Synchronization Engine
 ├── Recovery Engine
 └── Event Dispatcher
        │
        ▼
Repository Layer
        │
        ▼
Firebase Services
 ├── Authentication
 ├── Firestore
 └── Cloud Storage (Future)
```

---

# 5A.4 Engine Components

## Session Engine

Mengelola:

* Create Session
* Resume Session
* Close Session
* Session Validation
* Session Status
* Session Lifecycle

---

## Navigation Engine

Mengelola:

* Next Question
* Previous Question
* Sidebar Navigation
* Jump To Question
* Question Status
* Progress

---

## Timer Engine

Mengelola:

* Countdown
* Remaining Time
* Auto Submit
* Low Time Warning
* Time Synchronization

---

## Answer Engine

Mengelola:

* Load Question
* Save Answer
* Change Answer
* Clear Answer
* Question Status
* Answer Validation

---

## Auto Save Engine

Mengelola:

* Local Save
* Firestore Save
* Retry Queue
* Pending Queue
* Save Verification

---

## Synchronization Engine

Mengelola:

* Firestore Sync
* Offline Queue
* Retry Failed Request
* Conflict Detection
* Sync Confirmation

---

## Recovery Engine

Mengelola:

* Recover Session
* Recover Answers
* Recover Timer
* Recover Navigation
* Recover Sync Queue

---

## Event Dispatcher

Seluruh komunikasi antar Engine menggunakan Event Dispatcher.

Contoh Event:

* ExamStarted
* QuestionChanged
* AnswerSaved
* TimerUpdated
* SyncCompleted
* SubmissionCompleted
* SessionRecovered

---

# 5A.5 Exam Lifecycle

```text
Dashboard

↓

Open Exam

↓

Validate Student

↓

Validate Exam

↓

Create Session

↓

Generate Session ID

↓

Generate Random Order

↓

Initialize Timer

↓

Initialize Navigation

↓

Load Question

↓

Start Auto Save

↓

Start Synchronization

↓

Exam Running

↓

Submit

↓

Sync Final Answer

↓

Close Session

↓

History
```

---

# 5A.6 State Management

State ujian harus mengikuti urutan berikut:

```text
Idle

↓

Preparing

↓

Loading Questions

↓

Ready

↓

Running

↓

Saving

↓

Synchronizing

↓

Submitting

↓

Completed

↓

Closed
```

Tidak diperbolehkan melakukan transisi state yang melanggar urutan kecuali melalui mekanisme Recovery Engine.

---

# 5A.7 Functional Requirements

## FR-ENG-001

Core Exam Engine harus menjadi satu-satunya komponen yang mengendalikan lifecycle ujian.

---

## FR-ENG-002

Presentation Layer tidak boleh menyimpan business logic terkait ujian.

---

## FR-ENG-003

Session Engine harus menghasilkan Session ID yang unik.

---

## FR-ENG-004

Session Engine harus memastikan hanya terdapat satu sesi aktif untuk satu siswa pada satu ujian.

---

## FR-ENG-005

Navigation Engine harus mempertahankan urutan soal selama sesi aktif.

---

## FR-ENG-006

Timer Engine harus menggunakan waktu server sebagai acuan utama.

---

## FR-ENG-007

Answer Engine harus memperbarui status soal segera setelah jawaban berubah.

---

## FR-ENG-008

Auto Save Engine harus menyimpan setiap perubahan jawaban tanpa memerlukan aksi manual dari siswa.

---

## FR-ENG-009

Synchronization Engine harus mendukung sinkronisasi bertahap (incremental sync) untuk mengurangi penggunaan bandwidth.

---

## FR-ENG-010

Recovery Engine harus dapat memulihkan sesi yang valid sesuai kebijakan sistem tanpa membuat sesi baru.

---

# 5A.8 Business Rules

BR-ENG-001

Seluruh logika ujian berada pada Core Exam Engine.

---

BR-ENG-002

Satu sesi hanya boleh memiliki satu Session ID.

---

BR-ENG-003

Urutan soal tidak boleh berubah selama sesi aktif.

---

BR-ENG-004

Timer tidak boleh dipengaruhi oleh perubahan waktu pada perangkat pengguna.

---

BR-ENG-005

Jawaban yang telah berhasil disimpan tidak boleh hilang ketika terjadi gangguan jaringan sementara.

---

BR-ENG-006

Seluruh Engine harus berkomunikasi melalui Event Dispatcher dan tidak saling mengakses state internal secara langsung.

---

# 5A.9 Technical Constraints

Framework

* Flutter

State Management

* Riverpod (Recommended)

Backend

* Firebase

Database

* Cloud Firestore

Authentication

* Firebase Authentication

Offline Cache

* Firestore Offline Persistence + Local Cache

Architecture Pattern

* Clean Architecture

Repository Pattern

Dependency Injection

Service Layer

---

# 5A.10 Implementation Notes

* Gunakan repository untuk seluruh akses data.
* Hindari pemanggilan Firestore langsung dari UI.
* Pisahkan model domain dari model Firebase.
* Seluruh operasi asinkron harus mendukung pembatalan (cancellation) dan penanganan kesalahan yang konsisten.
* Seluruh perubahan state harus dapat diamati (observable) oleh Presentation Layer.

---

# 5A.11 Module Completion Criteria

Core Exam Engine dianggap selesai apabila:

* Seluruh lifecycle ujian berjalan sesuai urutan.
* Session Engine mengelola sesi secara konsisten.
* Navigation Engine bekerja stabil.
* Timer Engine menggunakan waktu server.
* Auto Save berjalan otomatis.
* Sinkronisasi dengan Firestore berjalan andal.
* Recovery Engine mampu memulihkan sesi yang valid.
* Presentation Layer bebas dari business logic inti.
* Seluruh modul menggunakan arsitektur Clean Architecture dan Repository Pattern.

# PART 5B — SOFTWARE ARCHITECTURE SPECIFICATION (SAS)

# SECURITY, ANTI-CHEAT & RECOVERY ENGINE

Version : 1.0

Project : Easy Exam

---

# 5B.1 Overview

Security, Anti-Cheat & Recovery Engine bertanggung jawab menjaga integritas pelaksanaan ujian.

Engine ini memonitor perilaku aplikasi, mengamankan sesi ujian, mencatat pelanggaran, serta memulihkan sesi apabila terjadi gangguan yang masih sesuai dengan kebijakan sistem.

Engine harus bekerja bersama Core Exam Engine tanpa mengganggu pengalaman pengguna yang sah.

---

# 5B.2 Objectives

Engine harus mampu:

* Mengamankan sesi ujian.
* Memonitor lifecycle aplikasi.
* Mendeteksi indikasi pelanggaran yang dapat diamati oleh platform.
* Mencatat seluruh aktivitas penting (audit log).
* Melakukan tindakan sesuai kebijakan pelanggaran.
* Memulihkan sesi setelah gangguan yang sah.
* Menjamin integritas data jawaban.

---

# 5B.3 High-Level Architecture

```text
Presentation Layer
        │
        ▼
Security & Anti-Cheat Engine
 ├── Lifecycle Monitor
 ├── Violation Manager
 ├── Session Guard
 ├── Audit Logger
 ├── Recovery Manager
 ├── Device Validation
 └── Security Validator
        │
        ▼
Core Exam Engine
        │
        ▼
Repository
        │
        ▼
Firebase
```

---

# 5B.4 Engine Components

## Lifecycle Monitor

Memantau perubahan status aplikasi:

* Resumed
* Inactive
* Paused
* Detached

---

## Violation Manager

Mengelola:

* Warning
* Counter
* Threshold
* Enforcement Action

---

## Session Guard

Memastikan:

* Satu sesi aktif.
* Session Token valid.
* Tidak ada duplikasi sesi.

---

## Audit Logger

Mencatat aktivitas penting:

* Login
* Mulai ujian
* Pergantian soal
* Perubahan jawaban
* Submit
* Pelanggaran
* Pemulihan sesi

---

## Recovery Manager

Mengelola:

* Recovery setelah aplikasi dibuka kembali.
* Sinkronisasi ulang.
* Validasi status sesi.

---

## Device Validation

Memvalidasi identitas perangkat yang digunakan untuk sesi ujian (sesuai kebijakan sekolah).

---

## Security Validator

Memastikan autentikasi, otorisasi, dan validitas akses sebelum setiap operasi penting.

---

# 5B.5 Monitoring Workflow

```text
Exam Running

↓

Lifecycle Changed

↓

Validate Session

↓

Record Event

↓

Check Violation Policy

↓

Warning / Continue / Auto Submit

↓

Update Audit Log
```

---

# 5B.6 Functional Requirements

## FR-SEC-001

Engine harus memonitor perubahan lifecycle aplikasi selama ujian berlangsung.

---

## FR-SEC-002

Setiap perubahan lifecycle harus dicatat sebagai event audit.

---

## FR-SEC-003

Apabila aplikasi masuk ke background selama ujian, sistem harus menjalankan kebijakan yang ditentukan administrator.

---

## FR-SEC-004

Sistem harus dapat menampilkan peringatan kepada siswa apabila terjadi pelanggaran pertama.

---

## FR-SEC-005

Violation Manager harus menghitung jumlah pelanggaran pada setiap sesi.

---

## FR-SEC-006

Administrator dapat mengatur batas maksimum pelanggaran sebelum tindakan otomatis dilakukan.

---

## FR-SEC-007

Apabila batas pelanggaran tercapai, sistem dapat:

* Mengakhiri sesi.
* Melakukan Auto Submit.
* Menandai sesi untuk ditinjau guru.

Konfigurasi mengikuti kebijakan Administrator.

---

## FR-SEC-008

Session Guard harus memastikan hanya satu sesi aktif untuk satu siswa pada satu ujian.

---

## FR-SEC-009

Session Token harus divalidasi sebelum setiap operasi penting seperti sinkronisasi dan submit.

---

## FR-SEC-010

Recovery Manager harus memverifikasi status sesi sebelum mengizinkan siswa melanjutkan ujian.

---

## FR-SEC-011

Audit Logger harus menyimpan waktu (timestamp) setiap aktivitas penting berdasarkan waktu server.

---

## FR-SEC-012

Jawaban yang telah tersimpan tidak boleh dihapus selama proses recovery.

---

## FR-SEC-013

Security Validator harus memverifikasi hak akses pengguna sebelum mengakses data ujian.

---

## FR-SEC-014

Engine harus mendukung Android Lock Task Mode apabila perangkat sekolah dikonfigurasi sebagai perangkat terkelola.

---

## FR-SEC-015

Sistem harus mencatat percobaan membuka aplikasi kembali setelah pelanggaran untuk keperluan audit.

---

# 5B.7 Audit Events

Engine harus dapat mencatat minimal aktivitas berikut:

* Login
* Logout
* Start Exam
* Resume Exam
* Pause Application
* Resume Application
* Answer Changed
* Question Navigation
* Manual Submit
* Auto Submit
* Recovery
* Warning
* Session Closed

---

# 5B.8 Business Rules

BR-SEC-001

Seluruh pelanggaran harus dicatat pada Audit Log.

---

BR-SEC-002

Jumlah pelanggaran dihitung per sesi ujian.

---

BR-SEC-003

Kebijakan terhadap pelanggaran ditentukan oleh Administrator.

---

BR-SEC-004

Recovery hanya diperbolehkan apabila sesi masih valid.

---

BR-SEC-005

Auto Submit hanya dilakukan sesuai aturan yang telah dikonfigurasi.

---

BR-SEC-006

Audit Log tidak boleh dapat diubah oleh siswa.

---

BR-SEC-007

Validasi keamanan harus dilakukan menggunakan waktu server dan data backend sebagai sumber kebenaran utama.

---

# 5B.9 Technical Constraints

Platform

* Flutter

Backend

* Firebase Authentication
* Cloud Firestore

Security

* Firestore Security Rules
* Secure Storage untuk token lokal
* HTTPS/TLS

Lifecycle

* AppLifecycleState

Android

* Lock Task Mode (opsional, perangkat terkelola)
* Disable Back Navigation selama ujian

iOS

* Mengikuti batasan keamanan dan lifecycle yang disediakan sistem operasi.

---

# 5B.10 Implementation Notes

* Jangan mengandalkan waktu perangkat untuk keputusan keamanan.
* Gunakan waktu server sebagai acuan.
* Seluruh event keamanan harus dikirim secara asinkron agar tidak mengganggu pengalaman pengguna.
* Pisahkan modul keamanan dari UI.
* Kebijakan pelanggaran harus dapat dikonfigurasi melalui panel Admin.

---

# 5B.11 Module Completion Criteria

Engine dianggap selesai apabila:

* Lifecycle aplikasi dapat dimonitor.
* Pelanggaran tercatat dalam Audit Log.
* Session Guard mencegah sesi ganda.
* Recovery berjalan sesuai kebijakan.
* Jawaban tetap aman setelah recovery.
* Administrator dapat mengatur kebijakan pelanggaran.
* Auto Submit dapat dijalankan berdasarkan konfigurasi.
* Android Lock Task Mode didukung pada perangkat yang memenuhi syarat.
* Seluruh keputusan keamanan menggunakan validasi backend sebagai sumber kebenaran utama.

# PART 6 — DEVELOPMENT GUIDELINES & TECHNICAL STANDARDS

Version: 1.0

Project: Easy Exam

---

# 6.1 Purpose

Dokumen ini berfungsi sebagai pedoman teknis dalam proses pengembangan aplikasi **Easy Exam**.

Seluruh implementasi yang dilakukan oleh AI Agent maupun developer harus mengikuti standar yang ditetapkan dalam dokumen ini agar menghasilkan kode yang konsisten, mudah dipelihara, aman, dan dapat dikembangkan di masa depan.

Dokumen ini melengkapi Software Requirement Specification (SRS) dan tidak menggantikannya.

---

# 6.2 Technology Stack

Seluruh pengembangan aplikasi harus menggunakan teknologi berikut:

## Mobile Application

* Flutter (Stable Version)
* Dart

## Backend

* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Firebase Cloud Messaging (FCM)

## State Management

* Riverpod (Recommended)

## Routing

* GoRouter

## Dependency Injection

* Riverpod Provider

## Local Storage

* SharedPreferences (pengaturan sederhana)
* Flutter Secure Storage (data sensitif)

## Serialization

* Freezed
* Json Serializable

---

# 6.3 Architecture Standards

Aplikasi wajib menggunakan **Clean Architecture**.

Struktur lapisan aplikasi:

```text
Presentation
↓
Application (Use Case)
↓
Domain
↓
Data
↓
Firebase Services
```

Aturan:

* UI hanya bertanggung jawab menampilkan data.
* Business logic berada di Application Layer.
* Domain Layer tidak boleh bergantung pada Firebase.
* Data Layer bertanggung jawab terhadap komunikasi dengan Firebase.

---

# 6.4 Project Structure

Struktur folder utama yang direkomendasikan:

```text
lib/
│
├── app/
├── core/
├── shared/
├── services/
├── routes/
├── features/
│   ├── authentication/
│   ├── student/
│   ├── admin/
│   ├── exam/
│   └── profile/
│
└── main.dart
```

Setiap feature wajib memiliki struktur:

```text
feature/

data/

domain/

application/

presentation/
```

---

# 6.5 Coding Standards

Seluruh kode harus mengikuti prinsip:

* SOLID
* DRY (Don't Repeat Yourself)
* KISS (Keep It Simple)
* Clean Code
* Separation of Concerns

Aturan tambahan:

* Hindari hardcoded value.
* Gunakan konstanta untuk nilai yang digunakan berulang.
* Gunakan `const` jika memungkinkan.
* Hindari fungsi yang terlalu panjang.
* Setiap class hanya memiliki satu tanggung jawab (Single Responsibility Principle).

---

# 6.6 State Management Rules

State Management menggunakan Riverpod.

Aturan:

* UI hanya mengakses Provider.
* Widget tidak boleh mengakses Repository secara langsung.
* Repository tidak boleh dipanggil dari Widget.
* Business Logic ditempatkan pada Notifier, Controller, atau Use Case.
* State harus immutable.

---

# 6.7 Firebase Standards

Seluruh akses Firebase wajib melalui Repository.

Aturan:

* Jangan melakukan query Firebase langsung dari UI.
* Gunakan Firestore Security Rules.
* Gunakan transaksi untuk operasi yang membutuhkan konsistensi data.
* Gunakan Server Timestamp untuk seluruh pencatatan waktu.
* Validasi data dilakukan di client dan server.

---

# 6.8 UI/UX Standards

Aplikasi menggunakan Material Design 3.

Standar UI:

* Responsive Layout.
* Konsisten pada seluruh halaman.
* Gunakan Loading Indicator saat proses berlangsung.
* Sediakan Empty State jika tidak ada data.
* Sediakan Error State yang informatif.
* Gunakan dialog konfirmasi untuk tindakan penting.
* Gunakan ukuran teks dan tombol yang ramah bagi siswa sekolah dasar.

---

# 6.9 Error Handling Standards

Seluruh error harus ditangani dengan baik.

Aturan:

* Gunakan `try-catch` pada operasi yang berpotensi gagal.
* Jangan biarkan aplikasi crash karena exception yang dapat ditangani.
* Tampilkan pesan yang mudah dipahami pengguna.
* Catat error untuk proses debugging.

---

# 6.10 Performance Standards

Aplikasi harus dioptimalkan untuk perangkat Android dengan spesifikasi menengah.

Standar:

* Hindari rebuild widget yang tidak diperlukan.
* Gunakan lazy loading jika diperlukan.
* Optimalkan ukuran gambar.
* Gunakan cache jika memungkinkan.
* Kurangi query Firestore yang berlebihan.

---

# 6.11 Security Standards

Seluruh data pengguna harus diperlakukan secara aman.

Aturan:

* Gunakan Firebase Authentication.
* Simpan data sensitif menggunakan Flutter Secure Storage.
* Jangan menyimpan token dalam bentuk plain text.
* Seluruh komunikasi menggunakan HTTPS.
* Gunakan Firestore Security Rules untuk membatasi akses data.

---

# 6.12 Logging Standards

Logging hanya digunakan untuk kebutuhan debugging dan audit.

Kategori log:

* Debug
* Info
* Warning
* Error

Log tidak boleh berisi data sensitif seperti token autentikasi atau informasi pribadi yang tidak diperlukan.

---

# 6.13 Testing Standards

Setiap fitur yang selesai dikembangkan harus diuji.

Minimal mencakup:

* Functional Testing
* UI Testing
* Integration Testing untuk alur penting
* Manual Testing pada perangkat Android

---

# 6.14 Documentation Standards

Setiap modul utama harus memiliki dokumentasi singkat.

Minimal menjelaskan:

* Tujuan modul.
* Cara kerja.
* Dependensi utama.
* Catatan implementasi jika diperlukan.

Kode yang kompleks dianjurkan memiliki komentar yang menjelaskan alasan implementasi, bukan sekadar menjelaskan sintaks.

---

# 6.15 Definition of Done (DoD)

Sebuah fitur dinyatakan selesai apabila memenuhi seluruh kriteria berikut:

* Sesuai dengan Software Requirement Specification (SRS).
* Mengikuti Clean Architecture.
* Mengikuti standar coding yang ditetapkan.
* Tidak terdapat error pada `flutter analyze`.
* Kode telah diformat menggunakan `dart format`.
* Tidak terdapat business logic di dalam Widget.
* Seluruh akses Firebase melalui Repository.
* Error handling telah diterapkan.
* UI responsif pada berbagai ukuran layar yang didukung.
* Tidak terdapat duplikasi logika yang tidak diperlukan.
* Dokumentasi diperbarui jika ada perubahan arsitektur atau perilaku sistem.

---

# 6.16 General Development Rules

Seluruh pengembangan Easy Exam harus mematuhi aturan berikut:

1. Selalu ikuti dokumen SRS dan SAS sebelum menulis kode.
2. Jangan membuat fitur di luar requirement tanpa persetujuan.
3. Prioritaskan keterbacaan kode dibandingkan kompleksitas.
4. Gunakan nama class, method, dan variabel yang deskriptif.
5. Hindari duplikasi kode.
6. Setiap perubahan harus mempertimbangkan skalabilitas aplikasi.
7. Seluruh keputusan penting harus terdokumentasi.
8. Jaga konsistensi struktur proyek sepanjang pengembangan.
9. Selalu gunakan server sebagai sumber kebenaran utama untuk data kritis.
10. Fokus pada keamanan, performa, dan kemudahan pemeliharaan aplikasi.

---

# Module Completion Criteria

Dokumen Development Guidelines & Technical Standards dianggap selesai apabila:

* Standar teknologi telah ditetapkan.
* Arsitektur proyek telah didefinisikan.
* Aturan coding telah disepakati.
* Standar penggunaan Firebase telah dijelaskan.
* Standar UI/UX telah ditetapkan.
* Standar keamanan telah didefinisikan.
* Definition of Done menjadi acuan setiap pengembangan fitur.
* Seluruh AI Agent dan developer menggunakan dokumen ini sebagai pedoman utama selama proses implementasi.
