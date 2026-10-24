#import "../lib/theme.typ": *
#import "../lib/ui.typ": *
#bab("BAB III", "HASIL DAN PEMBAHASAN")
#show: isi
#v(-8pt)
Hasil akhir berupa web app TANGGAP yang sudah berjalan dengan data contoh wilayah Kota Bima. Bagian ini menguraikan analisis desain, struktur informasi, wireframe, mockup, fitur, dan tangkapan layar.

== 3.1 Analisis Desain Karya
#sub[a. Target Pengguna.] Ada tiga kelompok: *warga* sebagai pelapor, *petugas lapangan* yang menangani, dan *administrator* yang memantau dan membagi tugas. Kebutuhan disusun dari pengamatan dan studi aturan; survei langsung ke pengguna belum dilakukan dan masuk rencana lanjutan (Bab IV).

#sub[b. Batasan Aplikasi.]
- Belum ada notifikasi otomatis (email/WhatsApp); warga memantau lewat nomor laporan atau akunnya.
- Satu laporan ditangani satu petugas. Akun petugas dan admin hanya dibuat oleh admin; pendaftaran mandiri khusus warga.
- Foto maksimal 5 MB (JPG, PNG, WebP). Peta butuh internet.
- Belum terhubung langsung ke SP4N-LAPOR!, dan baru berbahasa Indonesia.

#sub[c. Platform.] _Web app responsive_. Tanpa install, jalan di HP murah maupun laptop, dan satu kode untuk semua perangkat. Tampilan menyesuaikan lebar layar (menu samping berubah di layar kecil).

#sub[d. User Persona.] Ketiganya fiktif, memakai nama akun contoh di aplikasi.
#figure(
  tbl((48pt, 1fr, 1fr, 1fr),
    [], [*Siti Rahmawati* (warga)], [*Ahmad Subagja* (petugas)], [*Admin TANGGAP*],
    [Profil], [34 tahun, pedagang, sehari-hari pakai HP], [41 tahun, staf lapangan dinas, sering di luar kantor], [Staf dinas, kerja di depan komputer],
    [Tujuan], [Masalah di depan rumah/pasar cepat ditangani dan ia tahu progresnya], [Tahu tugas hari ini dan lokasinya, lalu melapor hasil], [Melihat semua aduan, memilah prioritas, menyusun laporan],
    [Hambatan], [Lapor lewat grup chat sering tenggelam, tidak ada kabar], [Info lokasi dari telepon sering kurang jelas], [Aduan tersebar di banyak jalur, dana sulit direkap],
  ),
  kind: "tabel", supplement: [Tabel], caption: [Persona pengguna],
)

#sub[e. Analisis SWOT.]
#figure(
  tbl((1fr, 1fr),
    [*Strengths:* nomor + riwayat publik, peta, tiga peran, ekspor CSV, bisa jalan di server sederhana], [*Weaknesses:* belum ada notifikasi, belum diuji ke pengguna nyata, data contoh masih sedikit],
    [*Opportunities:* pemda/kelurahan butuh kanal lokal, bisa dihubungkan ke SP4N-LAPOR!, tren layanan digital], [*Threats:* kebiasaan lapor lewat chat, laporan tidak ditindaklanjuti jika petugas tidak aktif, laporan palsu/ganda],
    head: false,
  ),
  kind: "tabel", supplement: [Tabel], caption: [SWOT],
)

== 3.2 _User Flow_ dan _Information Architecture_
#sub[Sitemap.] Halaman dibagi empat zona sesuai peran. Navigasi samping hanya menampilkan menu milik peran itu (3 sampai 5 menu), dan semua halaman `/app` wajib login.

#let kol(judul, c, items) = stack(spacing: 5pt,
  rect(width: 100%, inset: 3pt, radius: 2pt, fill: c, stroke: 0.6pt + ink, align(center, text(size: 7.5pt, weight: "bold", judul))),
  block(stroke: (left: 0.7pt + ink), inset: (left: 6pt, y: 1pt), width: 100%,
    stack(spacing: 4pt, ..items.map(i => node(i.at(0), sub: i.at(1))))),
)
#figure(
  {
    align(center, node([*TANGGAP*], w: 90pt, fill: kuning.lighten(55%)))
    v(-1pt)
    align(center, line(angle: 90deg, length: 8pt, stroke: 0.7pt + ink))
    line(length: 100%, stroke: 0.7pt + ink)
    v(5pt)
    grid(columns: (1fr,) * 4, column-gutter: 8pt,
      kol("Publik", white, (("Beranda", "/"), ("Lacak laporan", "/lacak/[kode]"), ("Daftar", "/daftar"), ("Masuk", "/masuk"))),
      kol("Warga", g1, (("Ringkasan", "/app"), ("Laporan saya", "/app/laporan"), ("Buat laporan", "/app/laporan/baru"), ("Detail + penilaian", "/app/laporan/[id]"))),
      kol("Petugas", g1, (("Ringkasan", "/app"), ("Tugas saya", "/app/laporan"), ("Peta tugas", "/app/peta"), ("Detail + ubah status", "/app/laporan/[id]"), ("Unduh CSV", "/app/laporan/ekspor"))),
      kol("Administrator", g1, (("Ringkasan (dashboard)", "/app"), ("Semua laporan", "/app/laporan"), ("Peta sebaran", "/app/peta"), ("Pengguna", "/app/pengguna"), ("Data master", "/app/master"), ("Detail + penugasan", "/app/laporan/[id]"))),
    )
  },
  kind: image, supplement: [Gambar], caption: [Sitemap TANGGAP (garis tegak = halaman di bawah zona)],
)

#sub[Tahapan status.] Laporan baru otomatis berstatus _Diterima_. Admin bisa mengubah ke status mana pun, termasuk _Ditolak_ (alasan wajib diisi). Petugas hanya boleh mengisi empat tahap terakhir.
#figure(
  {
    grid(columns: (1fr, 6pt, 1fr, 6pt, 1fr, 6pt, 1fr, 6pt, 1fr, 6pt, 1fr),
      ..tahap.map(((t, c)) => (chip(t, c),)).intersperse((align(center + horizon, text(size: 7pt)[›]),)).flatten())
    v(3pt)
    grid(columns: (1fr, 6pt, 1fr, 6pt, 1fr, 6pt, 1fr, 6pt, 1fr, 6pt, 1fr),
      grid.cell(colspan: 3, align(center, text(size: 6.5pt)[← hanya admin →])), [],
      grid.cell(colspan: 7, align(center, text(size: 6.5pt)[← petugas atau admin →])))
    v(1pt)
    align(center, box(width: 150pt, chip([Ditolak (admin, wajib alasan)], st.tolak)))
  },
  kind: image, supplement: [Gambar], caption: [Tahapan status laporan],
)

#sub[_User flow_ lintas peran.] Angka menunjukkan urutan; kolom = langkah, baris = pelaku.
#let sel(n, t) = rect(width: 100%, height: 100%, inset: 3pt, radius: 2pt, stroke: 0.6pt + ink, fill: white)[
  #set text(size: 6pt)
  #set par(justify: false, leading: 0.36em)
  #box(circle(radius: 4pt, fill: kuning, stroke: 0.5pt + ink, align(center + horizon, text(size: 5.5pt, weight: "bold", str(n))))) #t
]
#let lane(n) = rect(width: 100%, height: 100%, fill: g1, radius: 2pt, align(center + horizon, text(size: 7pt, weight: "bold", n)))
#let kosong = []
#figure(
  grid(columns: (40pt, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), rows: (40pt, 36pt, 48pt, 56pt), column-gutter: 3pt, row-gutter: 3pt,
    lane("Warga"), sel(1, [Daftar, lalu masuk]), sel(2, [Isi form: foto + titik peta]), kosong, kosong, kosong, kosong, sel(7, [Lacak/pantau, beri nilai 1–5]),
    lane("Sistem"), kosong, kosong, sel(3, [Buat nomor TGP, status _Diterima_]), kosong, kosong, kosong, kosong,
    lane("Admin"), kosong, kosong, kosong, sel(4, [Verifikasi (atau tolak), tugaskan petugas]), kosong, kosong, kosong,
    lane("Petugas"), kosong, kosong, kosong, kosong, sel(5, [Tangani, survei, perbaikan; catat dana + foto sesudah]), sel(6, [Tandai _Selesai_]), kosong,
  ),
  kind: image, supplement: [Gambar], caption: [User flow dari lapor sampai penilaian],
)

== 3.3 Wireframe
Wireframe dibuat _low-fidelity_ (abu-abu, tanpa warna) supaya fokus ke tata letak dan fungsi. Tiap kotak mewakili satu halaman; blok abu = gambar/peta, garis = teks, tombol gelap = aksi utama.

#let w1 = wf(nav: [Masuk | Daftar])[
  #lines(3, w: 85%) #v(3pt)
  #grid(columns: (1fr, auto), column-gutter: 3pt, fld([Nomor laporan]), align(bottom, btn([Lacak])))
  #v(3pt)
  #grid(columns: (1fr,) * 4, column-gutter: 2pt, ..range(4).map(i => blk([angka], h: 12pt)))
  #v(3pt)
  #for i in range(3) [#grid(columns: (1fr, auto), lines(2, w: 70%), segs(i + 1)) #v(2pt)]
]
#let w2 = wf(nav: [Masuk])[
  #t5[TGP-261024-0001] #v(1pt) #lines(2, w: 70%) #v(2pt) #segs(2, w: 90pt) #v(3pt)
  #for i in range(3) [#grid(columns: (22pt, 1fr), t5[Kategori], bar(w: 70%)) #v(2pt)]
  #lines(1) #v(3pt)
  #t5("Riwayat", b: true) #v(1pt)
  #for i in range(2) [#grid(columns: (8pt, 1fr), circle(radius: 2pt, fill: g3), bar(w: 70%)) #v(2pt)]
]
#let w3 = wf(nav: [Daftar])[
  #grid(columns: (1fr, 1.3fr), column-gutter: 6pt, rows: 86pt,
    rect(width: 100%, height: 100%, fill: g1, inset: 3pt, align(bottom + left, lines(3, w: 90%))),
    [#t6[Masuk] #v(2pt) #fld([Email]) #v(2pt) #fld([Kata sandi]) #v(3pt) #btn([Masuk]) #v(3pt) #lines(1, w: 70%) #v(2pt) #blk([akun contoh], h: 14pt)],
  )
]
#let w4 = wf(side: ("Ringkasan", "Laporan saya", "*Buat laporan"), nav: [Siti])[
  #t6[Buat laporan]
  #v(2pt)
  #grid(columns: (1fr, 1fr), column-gutter: 5pt,
    [#fld([Judul]) #v(2pt) #fld([Jenis masalah ▾]) #v(2pt) #blk([Uraian], h: 18pt) #v(2pt) #fld([Foto])],
    [#blk([Peta: ketuk untuk tandai], h: 30pt) #v(2pt) #btn([Pakai lokasi saya]) #v(2pt) #fld([Alamat]) #v(2pt) #fld([Kecamatan ▾])],
  )
  #v(2pt) #btn([Kirim laporan])
]
#let w5 = wf(side: ("*Ringkasan", "Laporan saya", "Buat laporan"), nav: [Siti])[
  #lines(2, w: 85%) #v(3pt) #btn([Buat laporan baru]) #v(4pt)
  #t5("Laporan Anda", b: true) #v(2pt)
  #for i in range(4) [#grid(columns: (1fr, auto), lines(2, w: 70%), segs(i + 1, w: 26pt)) #v(2pt)]
]
#let w6 = wf(side: ("*Ringkasan", "Semua laporan", "Peta sebaran", "Pengguna", "Data master"), nav: [Admin])[
  #lines(1, w: 80%) #v(2pt)
  #grid(columns: (1fr,) * 5, column-gutter: 1.5pt, ..range(5).map(i => blk([angka], h: 11pt)))
  #v(3pt)
  #grid(columns: (1.5fr, 1fr), column-gutter: 4pt,
    [#t5("Antrean terlama", b: true) #v(1pt) #for i in range(3) [#grid(columns: (1fr, auto), lines(2, w: 70%), segs(i + 1, w: 20pt)) #v(1.5pt)]],
    [#blk([posisi saat ini], h: 8pt) #v(2pt) #blk([6 bulan], h: 14pt) #v(2pt) #blk([jenis / kecamatan], h: 16pt)],
  )
]
#let w7 = wf(side: ("Ringkasan", "*Semua laporan", "Peta sebaran", "Pengguna", "Data master"), nav: [Admin])[
  #grid(columns: (1fr, auto), t6[Semua laporan], btn([Unduh CSV])) #v(2pt)
  #grid(columns: (1.4fr, 1fr, 1fr, 1fr, auto), column-gutter: 2pt, fld([Cari]), fld([Status]), fld([Jenis]), fld([Kec.]), align(bottom, btn([Terapkan])))
  #v(3pt)
  #for i in range(4) [#grid(columns: (1.6fr, 34pt, 1fr, 1fr), column-gutter: 2pt, lines(2, w: 80%), segs(i + 2, w: 30pt), bar(w: 60%), bar(w: 50%)) #v(2pt)]
]
#let w8 = wf(side: ("Ringkasan", "*Semua laporan", "Peta sebaran", "Pengguna", "Data master"), nav: [Admin])[
  #t5[TGP-261024-0001] #v(1pt) #lines(1, w: 70%) #v(2pt) #segs(2, w: 80pt) #v(3pt)
  #grid(columns: (1.5fr, 1fr), column-gutter: 5pt,
    [#for i in range(3) [#bar(w: 90%) #v(2pt)] #blk([Peta lokasi], h: 18pt) #v(2pt) #t5("Riwayat", b: true) #v(1pt) #bar(w: 70%)],
    [#t5("Perbarui laporan", b: true) #v(1pt) #fld([Status ▾]) #v(1.5pt) #fld([Petugas ▾]) #v(1.5pt) #fld([Catatan]) #v(1.5pt) #fld([Dana & sumber]) #v(2pt) #btn([Simpan])],
  )
]
#let w9 = wf(side: ("Ringkasan", "Semua laporan", "*Peta sebaran", "Pengguna", "Data master"), nav: [Admin])[
  #t6[Peta sebaran] #v(2pt)
  #rect(width: 100%, height: 52pt, fill: g1, stroke: 0.4pt + g2, radius: 1pt)[
    #place(top + left, dx: 18pt, dy: 12pt, circle(radius: 2.5pt, fill: g3))
    #place(top + left, dx: 50pt, dy: 28pt, circle(radius: 2.5pt, fill: g3))
    #place(top + left, dx: 80pt, dy: 18pt, circle(radius: 2.5pt, fill: g3))
    #place(center + horizon, text(size: 6pt, fill: g3)[peta (Leaflet)])
  ]
  #v(3pt)
  #grid(columns: (auto,) * 4, column-gutter: 5pt, ..range(4).map(i => [#box(circle(radius: 2pt, fill: g3)) #t5[status]]))
]
#let w10 = wf(side: ("Ringkasan", "Semua laporan", "Peta sebaran", "*Pengguna", "Data master"), nav: [Admin])[
  #t6[Pengguna] #v(2pt)
  #for i in range(3) [#grid(columns: (1.3fr, 1fr, auto, auto), column-gutter: 3pt, lines(2, w: 75%), fld([Peran ▾]), t5[☑ Aktif], btn([Simpan])) #v(2pt)]
  #t5("Tambah akun", b: true) #v(1pt)
  #grid(columns: (1fr,) * 3, column-gutter: 3pt, fld([Nama]), fld([Email]), fld([Peran]))
]
#let w11 = wf(side: ("Ringkasan", "Semua laporan", "Peta sebaran", "Pengguna", "*Data master"), nav: [Admin])[
  #t6[Data master] #v(2pt)
  #grid(columns: (1fr, 1fr), column-gutter: 6pt,
    [#t5("Jenis masalah", b: true) #v(1pt) #for i in range(3) [#grid(columns: (6pt, 1fr, auto), circle(radius: 2pt, fill: g3), bar(w: 80%), t5[Hapus]) #v(2pt)] #fld([Nama / warna])],
    [#t5("Wilayah", b: true) #v(1pt) #for i in range(3) [#grid(columns: (1fr, auto), bar(w: 80%), t5[Hapus]) #v(2pt)] #fld([Tambah kecamatan])],
  )
]
#let w12 = wf(side: ("*Ringkasan", "Laporan saya", "Buat laporan"), nav: [Siti])[
  #t5[TGP-261022-0001] #v(1pt) #lines(1, w: 70%) #v(2pt) #segs(6, w: 80pt) #v(3pt)
  #grid(columns: (1.5fr, 1fr), column-gutter: 5pt,
    [#for i in range(2) [#bar(w: 90%) #v(2pt)] #blk([Peta lokasi], h: 16pt) #v(2pt) #t5("Riwayat", b: true) #v(1pt) #bar(w: 70%)],
    [#t5("Beri penilaian", b: true) #v(1pt) #t6[★ ★ ★ ★ ☆] #v(1.5pt) #fld([Komentar]) #v(2pt) #btn([Kirim])],
  )
]
#let W(f, j, d) = figure(f, kind: "wireframe", supplement: [Wireframe], caption: [*#j* — #d])
#grid(columns: (1fr, 1fr, 1fr), column-gutter: 8pt, row-gutter: 2pt,
  W(w1, [Beranda], [lacak nomor, statistik, laporan terbaru]),
  W(w2, [Lacak laporan], [status, rincian, riwayat]),
  W(w3, [Masuk / daftar], [form dan akun contoh]),
  W(w4, [Buat laporan], [form + peta + foto]),
  W(w5, [Ringkasan warga], [daftar laporan sendiri]),
  W(w12, [Detail (warga)], [riwayat dan penilaian]),
  W(w6, [Dashboard admin], [angka, antrean, grafik]),
  W(w7, [Semua laporan], [filter dan tabel]),
  W(w8, [Detail (admin)], [rincian + panel ubah status]),
  W(w9, [Peta sebaran], [titik berwarna per status]),
  W(w10, [Pengguna], [peran, aktif, tambah akun]),
  W(w11, [Data master], [jenis masalah dan wilayah]),
)
Halaman petugas memakai layout yang sama dengan admin, tapi dengan menu lebih sedikit (_Ringkasan_, _Tugas saya_, _Peta tugas_) dan panel ubah status yang hanya memuat empat tahap terakhir.

== 3.4 Mockup
Konsep visualnya *papan rambu jalan*: kuning rambu, hitam pekat, garis putus-putus seperti marka jalan, dan bar bersegmen untuk status. Mockup dibuat langsung sebagai halaman web, jadi tampilannya sama dengan hasil akhir. Warna status dipakai konsisten di bar, titik peta, dan grafik.

#let sw(c, n, h) = stack(spacing: 2pt, rect(width: 100%, height: 16pt, fill: c, stroke: 0.4pt + g2, radius: 1pt), text(size: 6.3pt)[#n \ #text(fill: g3, font: "DejaVu Sans Mono", size: 5.5pt)[#h]])
#figure(
  {
    grid(columns: (1fr,) * 9, column-gutter: 4pt,
      sw(kuning, [Rambu], [\#F5C400]), sw(hitam, [Hitam], [\#1B1F23]), sw(krem, [Krem], [\#EDEEE8]),
      sw(st.diterima, [Diterima], [\#6B7178]), sw(st.verifikasi, [Proses], [\#1F6F9C]), sw(st.survei, [Survei], [\#6B4C9A]),
      sw(st.perbaikan, [Perbaikan], [\#C8851E]), sw(st.selesai, [Selesai], [\#2F6B4F]), sw(st.tolak, [Ditolak], [\#D2432B]))
    v(5pt)
    grid(columns: (1fr, 1fr, 1fr), column-gutter: 8pt,
      [#set text(size: 7.5pt)
       #text(weight: "bold")[Tipografi] \ Judul: Bricolage Grotesque \ Isi: Public Sans],
      [#set text(size: 7.5pt)
       #text(weight: "bold")[Tombol utama] \ #v(2pt) #rect(inset: (x: 6pt, y: 3pt), fill: kuning, stroke: 0.8pt + hitam, radius: 1pt, text(size: 7pt, weight: "bold")[Kirim laporan])],
      [#set text(size: 7.5pt)
       #text(weight: "bold")[Bar status (Perbaikan)] \ #v(2pt)
       #box(width: 90pt, grid(columns: (1fr,) * 6, column-gutter: 1.5pt, ..range(6).map(i => rect(width: 100%, height: 4pt, fill: if i < 5 { st.perbaikan } else { white }, stroke: 0.4pt + st.perbaikan))))],
    )
  },
  kind: image, supplement: [Gambar], caption: [Palet warna, tipografi, dan komponen utama],
)
#grid(columns: (1fr, 1fr, 1fr), column-gutter: 8pt,
  fig("/media/ss-beranda.jpg", [Mockup beranda publik]),
  fig("/media/ss-lacak.jpg", [Mockup halaman lacak laporan]),
  fig("/media/ss-masuk.jpg", [Mockup halaman masuk]),
)

== 3.5 Fitur
#figure(
  tbl((40pt, 100pt, 1fr),
    [*Peran*], [*Fitur*], [*Keterangan*],
    [Publik], [Lacak laporan], [Masukkan nomor `TGP-…`, lihat status, petugas, dan riwayat tanpa login. Data pelapor tidak ditampilkan],
    [], [Statistik beranda], [Jumlah laporan masuk dan selesai, rata-rata hari penyelesaian, total dana, dan laporan terbaru],
    [], [Daftar dan masuk], [Daftar sebagai warga (sandi minimal 8 karakter); akun contoh untuk mencoba],
    [Warga], [Buat laporan], [Judul, jenis, uraian, foto, titik peta atau tombol "Pakai lokasi saya", alamat, kecamatan/desa. Ada validasi isian],
    [], [Laporan saya], [Daftar dan detail laporan milik sendiri, lengkap dengan riwayat],
    [], [Penilaian], [Bintang 1–5 dan komentar, hanya setelah _Selesai_, satu kali per laporan],
    [Petugas], [Tugas saya + peta], [Daftar laporan yang ditugaskan, bisa dicari dan difilter, plus peta titik tugas],
    [], [Ubah status], [Pilih _Ditangani_ sampai _Selesai_, tulis catatan, isi dana dan sumber dana, unggah foto sesudah],
    [], [Unduh CSV], [Ekspor daftar sesuai filter],
    [Admin], [Dashboard], [Antrean terlama, posisi status, tren 6 bulan, jenis masalah, kecamatan, dana per sumber, kepuasan],
    [], [Kelola laporan], [Verifikasi atau tolak (alasan wajib), tugaskan petugas, hapus laporan, ekspor CSV],
    [], [Peta sebaran], [Semua titik laporan, warna mengikuti status],
    [], [Pengguna dan data master], [Ubah peran, aktif/nonaktif, tambah akun; kelola jenis masalah (berwarna), kecamatan, dan desa],
    [Sistem], [Riwayat otomatis], [Tiap perubahan tercatat: status, catatan, siapa, dan kapan],
    [], [Hak akses], [Dicek di server: warga hanya melihat laporannya, petugas hanya yang ditugaskan, selebihnya ditolak (403)],
    [], [Keamanan dasar], [Sandi di-_hash_, foto dicek isinya dan dibatasi 5 MB, CSV aman dari injeksi rumus],
  ),
  kind: "tabel", supplement: [Tabel], caption: [Daftar fitur per peran],
)

== 3.6 Screenshot
Tangkapan layar berikut diambil dari aplikasi yang berjalan dengan data contoh (7 laporan di wilayah Kota Bima).
#grid(columns: (1fr, 1fr), column-gutter: 10pt, row-gutter: 0pt,
  fig("/media/ss-dashboard.jpg", [Dashboard admin: ringkasan angka, antrean terlama, dan grafik]),
  fig("/media/ss-semua.jpg", [Semua laporan: pencarian, filter, dan tombol Unduh CSV]),
  fig("/media/ss-detail.jpg", [Detail laporan (admin): rincian, peta, riwayat, dan panel ubah status]),
  fig("/media/ss-peta.jpg", [Peta sebaran: titik berwarna per status]),
  fig("/media/ss-pengguna.jpg", [Pengguna: ubah peran, status aktif, dan tambah akun]),
  fig("/media/ss-master.jpg", [Data master: jenis masalah dan wilayah]),
  fig("/media/ss-petugas.jpg", [Tugas saya (petugas): hanya laporan yang ditugaskan]),
  fig("/media/ss-baru.jpg", [Buat laporan (warga): form, peta, dan foto]),
  fig("/media/ss-warga.jpg", [Ringkasan warga: laporan sendiri dan statusnya]),
  fig("/media/ss-detailwarga.jpg", [Detail laporan (warga): riwayat dan penjelasan langkah berikutnya]),
)
