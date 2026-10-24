#import "../lib/theme.typ": *
#import "../lib/ui.typ": *
#bab("BAB II", "RANCANGAN SISTEM")
#show: isi

== 2.1 Tema
Tema yang dipilih adalah *pelayanan publik digital dan partisipasi warga* (_civic tech_). Masalah di 1.1 pada dasarnya soal komunikasi dua arah antara warga dan pengelola. Web app dipilih sebagai solusinya karena bisa langsung dipakai lewat browser tanpa install.

== 2.2 Alat dan Bahan
#figure(
  tbl((70pt, 1fr),
    [*Kebutuhan*], [*Yang dipakai*],
    [Desain], [Sketsa kertas, lalu wireframe digambar dengan Typst; mockup dibuat langsung sebagai halaman HTML/CSS],
    [Aplikasi], [SvelteKit (Svelte 5) + TypeScript, satu proyek untuk halaman dan server],
    [Database], [PostgreSQL, 8 tabel: `users`, `sessions`, `kategori`, `kecamatan`, `desa`, `laporan`, `riwayat`, `penilaian`],
    [Peta], [Leaflet dengan _tile_ OpenStreetMap],
    [Keamanan], [Sandi di-_hash_ (bcrypt), sesi lewat cookie, foto divalidasi dari isi berkas (bukan sekadar ekstensi)],
    [Deploy], [Docker Compose (app + database); ada skrip Termux supaya bisa jalan di HP Android],
    [Tipografi], [Bricolage Grotesque (judul) dan Public Sans (isi)],
    [Perangkat], [Laptop, browser modern, dan koneksi internet (untuk memuat peta)],
  ),
  kind: "tabel", supplement: [Tabel], caption: [Alat dan bahan],
)

== 2.3 Alur Pembuatan
Pengerjaan dibagi delapan langkah berurutan, dari riset sampai dokumentasi.
#let langkah(n, j, d) = rect(width: 100%, height: 52pt, inset: 4pt, radius: 2pt, stroke: 0.6pt + ink, fill: if n == 6 { kuning.lighten(70%) } else { white })[
  #set text(size: 7pt)
  #set par(justify: false, leading: 0.4em)
  #text(weight: "bold", size: 7.5pt)[#n. #j] \ #d
]
#let pnl = align(center + horizon, text(size: 11pt, fill: g3)[→])
#figure(
  grid(columns: (1fr, 9pt, 1fr, 9pt, 1fr, 9pt, 1fr), row-gutter: 5pt,
    langkah(1, "Riset", [Baca aturan dan amati kanal aduan yang ada]), pnl,
    langkah(2, "Ideasi", [Rumuskan prinsip: nomor, petugas, riwayat]), pnl,
    langkah(3, "Sitemap & flow", [Petakan halaman dan alur tiap peran]), pnl,
    langkah(4, "Wireframe", [Sketsa tata letak _low-fidelity_]),
    langkah(5, "Mockup", [Palet, tipografi, komponen bar status]), pnl,
    langkah(6, "Coding", [Database, login, halaman, peta]), pnl,
    langkah(7, "Uji", [Coba alur penuh dengan 3 akun contoh]), pnl,
    langkah(8, "Dokumentasi", [Screenshot dan proposal ini]),
  ),
  kind: image, supplement: [Gambar], caption: [Alur pembuatan karya],
)
Langkah 5 dan 6 berjalan bergantian: tampilan diperbaiki saat coding, jadi mockup akhir sama dengan hasil jadi.
