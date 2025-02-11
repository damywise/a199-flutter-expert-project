[![CI](https://github.com/damywise/a199-flutter-expert-project/actions/workflows/ci.yml/badge.svg)](https://github.com/damywise/a199-flutter-expert-project/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/damywise/a199-flutter-expert-project/branch/main/graph/badge.svg?token=V2AP85A964)](https://codecov.io/gh/damywise/a199-flutter-expert-project)

# a199-flutter-expert-project

Repository ini merupakan starter project submission kelas Flutter Expert Dicoding Indonesia.

---

## Firebase Screenshots
<img width="1546" alt="image" src="https://user-images.githubusercontent.com/25608913/234176014-1255c283-dc5c-40de-9722-719102dc11dc.png">
<img width="1546" alt="image" src="https://user-images.githubusercontent.com/25608913/234176048-791d8995-daa7-4bf7-a6b5-6a122e7e9473.png">

## CI Build Screenshot
<img width="1546" alt="image" src="https://user-images.githubusercontent.com/25608913/234231051-c51abd10-2af6-4518-b657-7be31ea1f6a8.png">

## Tips Submission Awal

Pastikan untuk memeriksa kembali seluruh hasil testing pada submissionmu sebelum dikirimkan. Karena kriteria pada submission ini akan diperiksa setelah seluruh berkas testing berhasil dijalankan.


## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository ini. Berkas tersebut dapat mempermudah proses testing melalui *terminal* atau *command prompt*. Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:
1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.
    - Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.
        ```
        sudo apt-get update -qq -y
        sudo apt-get install lcov -y
        ```
    
    - Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.
        ```
        brew install lcov
        ```
    - Bagi pengguna **Windows**, ikuti langkah berikut.
        - Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
        - Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan menjalankan perintah berikut.
            ```
            choco install lcov
            ```
        - Kemudian cek **Environtment Variabel** pada kolom **System variabels** terdapat variabel GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan nilai seperti berikut.
            | Variable | Value|
            | ----------- | ----------- |
            | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
            | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |
        
~~2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.
    ```
    git init
    ```
3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada *terminal* atau *powershell*.
    ```
    test.sh
    ```
    atau
    ```
    ./test.sh
    ```
    Proses ini akan men-*generate* berkas `lcov.info` dan folder `coverage` terkait dengan laporan coverage.
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.~~

*JANGAN JALANKAN `test.sh`!! TERDAPAT BUG YANG MEMBUAT `lcov.info` MEMENUHI DISK*
