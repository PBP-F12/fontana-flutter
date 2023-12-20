### How to start the app:

# Anggota Kelompok PBP F12:

1. Muhammad Ilham Zikri - 2206083533
2. Ratu Nadya Anjania - 2206029752
3. Mikhail Haritz - 2206082764
4. Raisa Hannaliya Zahra - 2206820503
5. Raisyam Muhammad Fauzan Burhani - 2206027772

# Cerita aplikasi yang diajukan serta manfaatnya

Fontana merupakan sebuah website yang berperan sebagai online book catalogue bagi para penggemar buku. Pada aplikasi ini, kami mewadahi para pembaca untuk bergabung dalam suatu komunitas yang dapat saling berbagi mengenai review, diskusi, dan rekomendasi buku, sekaligus menjadi media publikasi bagi penulis untuk menyebarluaskan karyanya. Fontana juga menyediakan informasi Event yang sedang berlangsung untuk pembaca dan penulis, seperti festival buku dan sebagainya.

Dikarenakan aplikasi yang kami kembangkan ditujukan pada beberapa jenis pengguna, maka Fontana juga menyediakan autentikasi pengguna yang akan log in agar memiliki hak akses yang berbeda. Fitur-fitur yang kami kembangkan berguna untuk membantu pengguna menjelajahi buku, berpartisipasi dalam komunitas literatur, dan memperkaya pengalaman membaca mereka.

# Daftar modul yang akan diimplementasikan

1. Auth (`auth`)
2. Landing Page (`main`)
3. Bookmark (`bookmark`)
4. Review (`review`)
5. Event (`event`)
6. Publish (`publish`)
7. Forum (`forum`)

# Persona

## Akses admin:

1. Membuat dan mempublikasikan event
2. Mengatur database dari website
3. Mengakses landing page
4. Bisa liat buku

## Akses penulis:

1. Bisa publish buku
2. Me-review buku
3. Berinteraksi dengan pengguna lainnya dalam forum diskusi
4. Melihat event yang sedang berlangsung
5. Mengakses landing page

## Akses pembaca:

1. Me-review buku
2. Mengakses page bookmark untuk menyimpan buku yang diinginkan
3. Berinteraksi dengan pengguna lainnya dalam forum diskusi
4. Melihat event yang sedang berlangsung
5. Mengakses landing page

# Alur pengintegrasian dengan `web service`

1. Mendefinisikan model yang akan dipakai saat pemanggilan layanan web, method `toJson()`, dan `fromJson()`.
2. Menambahkan dependensi http dan potongan kode sehingga memungkinkan akses internet pada aplikasi Flutter dalam berkas `android/app/src/main/AndroidManifest.xml`.
3. Melakukan _fetch data_ dengan hit endpoint API menggunakan method POST, GET, DELETE, PUT, dan lain-lain yang disediakan dependensi http.
4. _Decode_ data yang sudah di-_fetch_ ke bentuk `JSON`.
5. Konversi data dalam bentuk `JSON` menjadi data dalam bentuk sebuah model.
6. Kemudian, tampilkan data dalam bentuk model tersebut pada aplikasi Flutter.

# Tautan berita acara

## [Berita Acara](https://ristek.link/BeritaAcaraF12)

# Link App Center

[![Build status](https://build.appcenter.ms/v0.1/apps/0f5e14c8-351b-4a0e-b8b0-0d7e8f0a3053/branches/main/badge)](https://appcenter.ms)

# Application Link

https://install.appcenter.ms/orgs/Fontana/apps/Fontana/releases/2
