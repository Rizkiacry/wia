// Proposal WIA 2026 — entry point. Compile: typst compile --font-path fonts --root . main.typ
#import "lib/theme.typ": wia
#import "lib/cover.typ": cover
#import "lib/toc.typ": toc

#show: wia

#cover(
  title: "TANGGAP: Web App Pengaduan Warga dengan Pelacakan Laporan yang Transparan",
  team: "Tim TANGGAP",
  members: ("Zain Akbar Rizkia - Institut Teknologi PLN",),
)

#toc()

#include "content/kata-pengantar.typ"
#include "content/bab1.typ"
#include "content/bab2.typ"
#include "content/bab3.typ"
#include "content/bab4.typ"
#include "content/lampiran.typ"
#include "content/daftar-pustaka.typ"
