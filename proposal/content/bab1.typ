#import "../lib/theme.typ": *
#import "../lib/ui.typ": *
#bab("BAB I", "PENDAHULUAN")
#show: isi

== 1.1 Latar Belakang
Hampir tiap hari warga ketemu masalah kecil di lingkungannya: jalan berlubang, lampu jalan padam, pohon miring, TPS meluap. Masalah sebenarnya sering bukan di _melapor_-nya, tapi di *setelahnya*. Laporan lewat grup WhatsApp, media sosial, atau datang ke kantor biasanya tidak punya nomor, tidak jelas siapa yang menangani, dan warga tidak tahu apakah laporannya sudah dibaca.

Dari sisi pengelola, aduan masuk lewat banyak jalur sekaligus, jadi susah direkap. Lokasi tidak pasti, foto tercecer, dan dana perbaikan jarang tercatat per kasus. Akibatnya prioritas sulit ditentukan dan laporan lama gampang terlupa.

Secara aturan, penyelenggara layanan publik wajib menyediakan sarana pengaduan (UU No. 25 Tahun 2009 [1]). Pengelolaannya diatur Perpres No. 76 Tahun 2013 [2], yang melahirkan SP4N-LAPOR! sebagai kanal nasional [3]. TANGGAP tidak dimaksudkan menggantikan kanal itu, tapi melengkapinya di level lokal: masalah lingkungan yang butuh titik peta, petugas lapangan, dan bukti perbaikan yang bisa dilihat warga.

== 1.2 Ide
TANGGAP punya satu prinsip: *setiap laporan punya nomor, petugas, dan riwayat.* Dari prinsip itu lahir lima ide utama:
- *Nomor laporan unik* (contoh `TGP-261024-0001`) yang bisa dipakai siapa saja untuk melacak laporan dari beranda, tanpa login.
- *Progres 6 tahap* yang divisualkan sebagai bar bersegmen, jadi status terbaca sekilas.
- *Tiga peran* (warga, petugas, administrator) dengan tampilan dan hak akses yang berbeda.
- *Bukti kerja*: titik peta, foto kejadian, foto sesudah ditangani, serta catatan dana dan sumber dananya.
- *Dashboard* untuk admin: antrean terlama, rata-rata hari penyelesaian, sebaran per jenis dan kecamatan.

#figure(
  tbl((60pt, 1fr, 1fr),
    [], [*Cara yang biasa*], [*Dengan TANGGAP*],
    [Nomor], [Sering tidak ada], [Otomatis, format `TGP-YYMMDD-NNNN`],
    [Status], [Tanya manual ke petugas], [6 tahap + riwayat, bisa dibuka siapa saja],
    [Lokasi], [Dijelaskan lewat chat], [Titik peta dan alamat dalam satu form],
    [Bukti], [Foto tercecer di chat], [Foto sebelum dan sesudah menempel di laporan],
    [Dana], [Tidak tercatat per kasus], [Nominal dan sumber dana tercatat],
    [Penilaian], [Tidak ada], [Warga menilai 1–5 setelah selesai],
  ),
  kind: "tabel", supplement: [Tabel], caption: [Perbandingan cara biasa dan TANGGAP],
)

== 1.3 Rumusan Masalah
+ Bagaimana warga bisa melapor dengan cepat dan tetap tahu perkembangan laporannya?
+ Bagaimana petugas dan admin mengelola laporan dari satu tempat, lengkap dengan lokasi dan bukti?
+ Bagaimana proses penanganan dan dana perbaikan bisa ditunjukkan secara terbuka ke warga?

== 1.4 Tujuan
Membuat prototipe web app TANGGAP yang bisa dijalankan, berisi: (1) form lapor dengan peta dan foto, (2) pelacakan publik berbasis nomor, (3) alur status dan penugasan petugas, (4) dashboard dan ekspor CSV, serta (5) dokumentasi desain berupa sitemap, wireframe, dan mockup.

== 1.5 Manfaat
- *Warga*: lapor sekali, lalu bisa memantau sendiri; tidak perlu bolak-balik bertanya.
- *Petugas*: daftar tugas dan peta kerja sendiri, dengan lokasi dan foto langsung tersedia.
- *Admin/pengelola*: semua aduan di satu tempat, mudah memilah prioritas, dan data siap diekspor untuk laporan.
