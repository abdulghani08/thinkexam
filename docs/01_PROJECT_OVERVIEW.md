# Easy Exam

## Project Overview

**Version:** 1.0.0
**Project Status:** Planning Phase
**Document Owner:** ThinkData Project
**Last Updated:** July 2026

---

# 1. Introduction

Easy Exam adalah platform ujian berbasis Flutter yang dirancang khusus untuk kebutuhan sekolah dasar. Sistem ini menggabungkan kemudahan penggunaan seperti Google Forms dengan keamanan dan kontrol seperti sistem Computer Based Test (CBT).

Aplikasi terdiri dari dua platform utama:

* **Flutter Mobile** untuk siswa.
* **Flutter Web** untuk guru/admin.

Seluruh data disimpan dan dikelola menggunakan Firebase.

---

# 2. Project Vision

Membangun sistem ujian digital yang:

* Mudah digunakan oleh guru.
* Mudah digunakan oleh siswa.
* Memiliki antarmuka sederhana seperti Google Forms.
* Memiliki keamanan tinggi untuk meminimalkan kecurangan.
* Mudah dikembangkan untuk kebutuhan sekolah di masa depan.
* Memiliki performa tinggi dan mudah dipelihara.

---

# 3. Project Goals

Easy Exam bertujuan untuk:

* Menggantikan ujian berbasis kertas.
* Mempermudah guru dalam membuat soal.
* Mempermudah proses penilaian.
* Memberikan nilai otomatis.
* Menampilkan statistik hasil ujian.
* Mengurangi potensi kecurangan saat ujian berlangsung.
* Menjadi platform ujian digital standar di lingkungan sekolah.

---

# 4. Target Users

## 4.1 Administrator / Guru

Guru memiliki hak akses penuh terhadap sistem.

Hak akses utama:

* Login menggunakan akun Google.
* Membuat ujian.
* Mengedit ujian.
* Menghapus ujian.
* Mengaktifkan atau menonaktifkan ujian.
* Mengatur jadwal ujian.
* Mengatur durasi ujian.
* Mengatur randomisasi soal.
* Mengatur randomisasi pilihan jawaban.
* Melihat jawaban siswa.
* Melihat nilai siswa.
* Mengelola bank soal.
* Mengelola kelas.
* Mengelola mata pelajaran.
* Mengelola data siswa.
* Mengekspor hasil ujian.

---

## 4.2 Student

Siswa hanya memiliki akses terhadap ujian yang diberikan.

Hak akses:

* Login menggunakan akun Google.
* Melihat profil.
* Melihat daftar ujian.
* Mengikuti ujian.
* Melihat riwayat ujian.
* Melihat status ujian.

---

# 5. Core Features

## Authentication

* Google Sign-In.
* Role Based Access.
* Session Management.

---

## Exam Management

Guru dapat:

* Membuat ujian.
* Mengubah ujian.
* Menghapus ujian.
* Menyalin ujian.
* Mengatur jadwal.
* Mengatur durasi.
* Mengatur status aktif.

---

## Question Builder

Mendukung:

* Pilihan Ganda.
* Benar / Salah.
* Checkbox (opsional).
* Isian Singkat (opsional pada fase berikutnya).
* Gambar pada soal.
* Bobot nilai per soal.

---

## Student Examination

Fitur utama:

* Satu soal per halaman.
* Navigasi nomor soal.
* Timer.
* Auto Save.
* Submit.
* Auto Submit saat waktu habis.

---

## Automatic Scoring

* Koreksi otomatis.
* Perhitungan nilai otomatis.
* Rekap hasil ujian.
* Statistik sederhana.

---

## Analytics

Guru dapat melihat:

* Jumlah peserta.
* Nilai rata-rata.
* Nilai tertinggi.
* Nilai terendah.
* Persentase jawaban benar.
* Detail jawaban setiap siswa.

---

# 6. Anti-Cheat Vision

Easy Exam dirancang untuk mengurangi peluang kecurangan.

Target keamanan:

* Mendeteksi perpindahan aplikasi.
* Mengunci orientasi layar.
* Menonaktifkan screenshot (Android).
* Mengaktifkan Secure Flag.
* Menghitung jumlah pelanggaran.
* Memberikan peringatan.
* Submit otomatis jika batas pelanggaran terlampaui.

Catatan:
Implementasi akan disesuaikan dengan kemampuan sistem operasi Android dan iOS. Beberapa pembatasan (misalnya kiosk mode penuh di perangkat pribadi) mungkin memiliki keterbatasan teknis yang akan dijelaskan pada dokumen Anti-Cheat Engine.

---

# 7. Platform

## Student

Platform:

Flutter Mobile

Target:

Android

Catatan:
Dukungan iOS dapat dipertimbangkan pada fase pengembangan berikutnya.

---

## Admin

Platform:

Flutter Web

Target:

Desktop Browser

Browser yang didukung:

* Chrome
* Edge
* Firefox

---

# 8. Technology Stack

Frontend:

* Flutter

State Management:

* Riverpod

Backend:

* Firebase

Authentication:

* Google Authentication

Database:

* Cloud Firestore

Storage:

* Firebase Storage

Notification:

* Firebase Cloud Messaging

Analytics:

* Firebase Analytics

Crash Reporting:

* Firebase Crashlytics

---

# 9. Design Principles

Seluruh aplikasi harus mengikuti prinsip berikut:

* Clean Architecture.
* SOLID Principle.
* Modular.
* Reusable Component.
* Maintainable Code.
* Readable Code.
* Responsive Layout.
* Material Design 3.
* Accessibility.
* Performance First.

---

# 10. Future Roadmap

Easy Exam dirancang agar dapat berkembang tanpa mengubah arsitektur utama.

Rencana pengembangan jangka panjang meliputi:

* Bank Soal Terpusat.
* Import Soal dari Excel.
* Export Nilai ke Excel.
* Statistik Lanjutan.
* Dashboard Kepala Sekolah.
* Multi Sekolah.
* Multi Tenant.
* Essay Scoring.
* CBT Offline Mode.
* Sinkronisasi Offline.
* AI Question Generator.
* AI Learning Analytics.
* Integrasi LMS.

---

# 11. Success Criteria

Proyek dianggap berhasil apabila:

* Guru dapat membuat ujian dengan mudah.
* Siswa dapat mengerjakan ujian tanpa kendala.
* Nilai dihitung secara otomatis.
* Hasil ujian dapat dianalisis oleh guru.
* Sistem stabil saat digunakan oleh banyak siswa.
* Struktur kode mudah dipelihara dan dikembangkan.
* Arsitektur mendukung penambahan fitur di masa depan tanpa perubahan besar.

---

# 12. Project Philosophy

Easy Exam dibangun dengan filosofi:

> "Simple for Teachers, Comfortable for Students, Reliable for Schools."

Seluruh keputusan desain, implementasi, dan pengembangan harus mengutamakan kemudahan penggunaan, keamanan, performa, serta skalabilitas jangka panjang.
