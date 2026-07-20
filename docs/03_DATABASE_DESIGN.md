# PART 7 — DATABASE DESIGN & FIRESTORE SCHEMA

Version: 1.0

Project: Easy Exam

---

# 7.1 Purpose

Dokumen ini mendefinisikan struktur database Cloud Firestore yang digunakan oleh aplikasi **Easy Exam**.

Tujuan utama dokumen ini adalah:

* Menjamin konsistensi struktur data.
* Memudahkan pengembangan frontend dan backend.
* Menjadi acuan AI Agent dan developer dalam implementasi database.
* Mendukung skalabilitas dan keamanan data.

Cloud Firestore digunakan sebagai database utama dengan pendekatan **NoSQL**.

---

# 7.2 Database Principles

Seluruh desain database harus mengikuti prinsip berikut:

* Setiap koleksi memiliki tujuan yang jelas.
* Hindari duplikasi data yang tidak diperlukan.
* Gunakan Document ID yang unik.
* Gunakan Server Timestamp untuk data waktu.
* Simpan referensi antar dokumen menggunakan ID, bukan objek lengkap.
* Optimalkan struktur agar sesuai dengan pola query Firestore.

---

# 7.3 Firestore Collections

Database terdiri dari koleksi utama berikut:

```text
teachers/
students/
classes/
subjects/
exams/
questions/
exam_sessions/
exam_answers/
exam_results/
notifications/
app_settings/
```

---

# 7.4 Collection: teachers

Menyimpan data guru (Admin).

### Fields

| Field     | Type      | Description      |
| --------- | --------- | ---------------- |
| id        | String    | Document ID      |
| fullName  | String    | Nama lengkap     |
| email     | String    | Email Google     |
| photoUrl  | String    | Foto profil      |
| role      | String    | Admin            |
| createdAt | Timestamp | Waktu dibuat     |
| updatedAt | Timestamp | Waktu diperbarui |
| isActive  | Boolean   | Status akun      |

---

# 7.5 Collection: students

Menyimpan data siswa.

### Fields

| Field         | Type      | Description       |
| ------------- | --------- | ----------------- |
| id            | String    | Document ID       |
| fullName      | String    | Nama lengkap      |
| email         | String    | Email Google      |
| studentNumber | String    | Nomor induk siswa |
| classId       | String    | Referensi kelas   |
| photoUrl      | String    | Foto profil       |
| createdAt     | Timestamp | Waktu dibuat      |
| updatedAt     | Timestamp | Waktu diperbarui  |
| isActive      | Boolean   | Status akun       |

---

# 7.6 Collection: classes

Menyimpan data kelas.

### Fields

| Field             | Type      | Description      |
| ----------------- | --------- | ---------------- |
| id                | String    | Document ID      |
| className         | String    | Contoh: Kelas 5A |
| grade             | Integer   | Tingkat kelas    |
| homeroomTeacherId | String    | Wali kelas       |
| createdAt         | Timestamp | Waktu dibuat     |

---

# 7.7 Collection: subjects

Menyimpan data mata pelajaran.

### Fields

| Field       | Type      | Description         |
| ----------- | --------- | ------------------- |
| id          | String    | Document ID         |
| subjectName | String    | Nama mata pelajaran |
| description | String    | Deskripsi           |
| createdAt   | Timestamp | Waktu dibuat        |

---

# 7.8 Collection: exams

Menyimpan informasi ujian.

### Fields

| Field          | Type      | Description              |
| -------------- | --------- | ------------------------ |
| id             | String    | Document ID              |
| title          | String    | Judul ujian              |
| subjectId      | String    | Referensi mata pelajaran |
| duration       | Integer   | Durasi (menit)           |
| isPublished    | Boolean   | Status aktif             |
| randomQuestion | Boolean   | Acak soal                |
| randomOption   | Boolean   | Acak pilihan jawaban     |
| showResult     | Boolean   | Tampilkan hasil          |
| createdBy      | String    | ID guru                  |
| createdAt      | Timestamp | Waktu dibuat             |
| updatedAt      | Timestamp | Waktu diperbarui         |

---

# 7.9 Collection: questions

Menyimpan bank soal.

### Fields

| Field         | Type    | Description            |
| ------------- | ------- | ---------------------- |
| id            | String  | Document ID            |
| examId        | String  | Referensi ujian        |
| questionText  | String  | Isi soal               |
| questionImage | String  | URL gambar (opsional)  |
| options       | Array   | Daftar pilihan jawaban |
| correctAnswer | String  | Kunci jawaban          |
| explanation   | String  | Pembahasan (opsional)  |
| score         | Integer | Bobot nilai            |
| order         | Integer | Urutan default         |

---

# 7.10 Collection: exam_sessions

Menyimpan sesi ujian setiap siswa.

### Fields

| Field          | Type      | Description               |
| -------------- | --------- | ------------------------- |
| id             | String    | Session ID                |
| examId         | String    | Referensi ujian           |
| studentId      | String    | Referensi siswa           |
| status         | String    | Ready, Running, Completed |
| startTime      | Timestamp | Mulai ujian               |
| endTime        | Timestamp | Selesai ujian             |
| remainingTime  | Integer   | Sisa waktu                |
| violationCount | Integer   | Jumlah pelanggaran        |
| deviceId       | String    | ID perangkat              |
| createdAt      | Timestamp | Waktu dibuat              |

---

# 7.11 Collection: exam_answers

Menyimpan jawaban siswa.

### Fields

| Field          | Type      | Description    |
| -------------- | --------- | -------------- |
| id             | String    | Document ID    |
| sessionId      | String    | Referensi sesi |
| questionId     | String    | Referensi soal |
| selectedAnswer | String    | Jawaban siswa  |
| isCorrect      | Boolean   | Hasil evaluasi |
| answeredAt     | Timestamp | Waktu menjawab |

---

# 7.12 Collection: exam_results

Menyimpan hasil akhir ujian.

### Fields

| Field        | Type      | Description     |
| ------------ | --------- | --------------- |
| id           | String    | Document ID     |
| sessionId    | String    | Referensi sesi  |
| studentId    | String    | Referensi siswa |
| examId       | String    | Referensi ujian |
| totalScore   | Number    | Nilai akhir     |
| totalCorrect | Integer   | Jawaban benar   |
| totalWrong   | Integer   | Jawaban salah   |
| submittedAt  | Timestamp | Waktu submit    |

---

# 7.13 Collection: notifications

Menyimpan notifikasi sistem.

### Fields

| Field     | Type      | Description  |
| --------- | --------- | ------------ |
| id        | String    | Document ID  |
| userId    | String    | Penerima     |
| title     | String    | Judul        |
| message   | String    | Isi          |
| isRead    | Boolean   | Status baca  |
| createdAt | Timestamp | Waktu dibuat |

---

# 7.14 Collection: app_settings

Menyimpan konfigurasi aplikasi.

### Fields

| Field           | Type      | Description       |
| --------------- | --------- | ----------------- |
| id              | String    | Document ID       |
| appVersion      | String    | Versi aplikasi    |
| maintenanceMode | Boolean   | Mode pemeliharaan |
| updatedAt       | Timestamp | Waktu diperbarui  |

---

# 7.15 Database Relationships

Relasi utama:

* Satu **Teacher** dapat membuat banyak **Exam**.
* Satu **Subject** memiliki banyak **Exam**.
* Satu **Exam** memiliki banyak **Question**.
* Satu **Student** memiliki banyak **Exam Session**.
* Satu **Exam Session** memiliki banyak **Exam Answer**.
* Satu **Exam Session** menghasilkan satu **Exam Result**.

---

# 7.16 Naming Conventions

* Collection: huruf kecil, bentuk jamak (`students`, `exams`).
* Field: camelCase (`fullName`, `createdAt`).
* Document ID: UUID atau Auto-ID Firestore.
* Timestamp: gunakan `serverTimestamp()`.

---

# 7.17 Security Guidelines

* Akses data dibatasi menggunakan Firestore Security Rules.
* Siswa hanya dapat membaca data miliknya sendiri.
* Guru hanya dapat mengelola data sesuai hak aksesnya.
* Seluruh operasi penting divalidasi melalui Firebase Authentication.

---

# Module Completion Criteria

Desain database dianggap selesai apabila:

* Seluruh koleksi utama telah didefinisikan.
* Setiap koleksi memiliki struktur field yang jelas.
* Relasi antar data terdokumentasi.
* Aturan penamaan konsisten.
* Struktur siap diimplementasikan pada Cloud Firestore.
