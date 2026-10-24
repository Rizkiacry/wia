// Helper tambahan: gaya isi, tabel, diagram, dan wireframe.
#let ink = luma(50)
#let g1 = luma(238)
#let g2 = luma(185)
#let g3 = luma(120)
#let kuning = rgb("#f5c400")
#let hitam = rgb("#1b1f23")
#let krem = rgb("#edeee8")
#let st = (
  diterima: rgb("#6b7178"), verifikasi: rgb("#1f6f9c"), tangani: rgb("#1f6f9c"),
  survei: rgb("#6b4c9a"), perbaikan: rgb("#c8851e"), selesai: rgb("#2f6b4f"), tolak: rgb("#d2432b"),
)
#let tahap = (
  ("Diterima", st.diterima), ("Diverifikasi", st.verifikasi), ("Ditangani", st.tangani),
  ("Survei", st.survei), ("Perbaikan", st.perbaikan), ("Selesai", st.selesai),
)

// Gaya isi: pasang di awal tiap file bab dengan `#show: isi`
#let isi(doc) = {
  set text(size: 10pt)
  set par(justify: true, leading: 0.6em, spacing: 0.7em)
  set list(indent: 6pt, body-indent: 5pt, spacing: 0.45em)
  set enum(indent: 6pt, body-indent: 5pt, spacing: 0.45em)
  set table(stroke: 0.45pt + g2, inset: (x: 4pt, y: 3pt))
  set figure(gap: 4pt)
  show figure.caption: set text(size: 8pt)
  show figure.caption: set par(leading: 0.4em, justify: false)
  show figure: set block(breakable: false, above: 7pt, below: 7pt)
  show figure.where(kind: "tabel"): set block(breakable: true)
  show heading.where(level: 2): it => block(above: 12pt, below: 4pt, sticky: true, text(size: 11pt, weight: "bold", it.body))
  show raw: set text(size: 8pt)
  doc
}

#let sub(t) = text(weight: "bold")[#t]
#let kecil(it) = text(size: 8.5pt, it)

// Tabel ringkas: kepala berwarna abu
#let tbl(cols, ..cells, size: 8.5pt, head: true) = {
  set text(size: size)
  set par(justify: false, leading: 0.5em)
  table(
    columns: cols,
    fill: (x, y) => if head and y == 0 { g1 },
    align: left + top,
    ..cells,
  )
}

#let fig(path, cap, w: 100%) = figure(
  box(stroke: 0.5pt + g2, image(path, width: w)),
  caption: cap,
)

// ---------- Diagram umum ----------
#let node(t, sub: none, fill: white, stroke-c: ink, w: 100%) = rect(
  width: w, inset: (x: 3pt, y: 3pt), radius: 2pt, fill: fill, stroke: 0.6pt + stroke-c,
)[
  #set text(size: 7pt)
  #set par(justify: false, leading: 0.4em)
  #align(center)[#t#if sub != none [\ #text(size: 5.8pt, fill: luma(80), font: "DejaVu Sans Mono")[#sub]]]
]

#let chip(t, c) = rect(
  inset: (x: 4pt, y: 3pt), radius: 2pt, fill: c, width: 100%,
  align(center, text(size: 7pt, weight: "bold", fill: white, t)),
)

// ---------- Primitif wireframe ----------
#let bar(w: 100%, h: 2.6pt, c: g2) = rect(width: w, height: h, fill: c, radius: 1pt)
#let lines(n, w: 100%) = stack(spacing: 2.4pt, ..range(n).map(i => bar(w: if i == n - 1 and n > 1 { 60% } else { w })))
#let blk(label, h: 16pt, fill: g1, w: 100%) = rect(
  width: w, height: h, fill: fill, stroke: 0.4pt + g2, radius: 1pt, inset: 1.5pt,
  align(center + horizon, text(size: 5.5pt, fill: ink, label)),
)
#let btn(label, w: auto) = rect(
  width: w, inset: (x: 4pt, y: 2pt), fill: g3, radius: 1pt,
  align(center, text(size: 5.2pt, fill: white, weight: "bold", label)),
)
#let fld(label) = stack(spacing: 1.5pt,
  text(size: 4.8pt, fill: g3, label),
  rect(width: 100%, height: 7pt, stroke: (bottom: 0.6pt + ink)),
)
#let segs(k, n: 6, w: 34pt) = box(width: w, grid(
  columns: (1fr,) * n, column-gutter: 1pt,
  ..range(n).map(i => rect(width: 100%, height: 3pt, fill: if i < k { g3 } else { white }, stroke: 0.3pt + g3)),
))
#let t5(t, b: false) = text(size: 5.5pt, weight: if b { "bold" } else { "regular" }, fill: ink, t)
#let t6(t) = text(size: 6.5pt, weight: "bold", fill: ink, t)

#let wf(nav: none, side: none, body) = block(
  width: 100%, height: 112pt, stroke: 0.6pt + ink, radius: 2pt, inset: 0pt, clip: true, fill: white, breakable: false,
)[
  #set par(justify: false, leading: 0.35em)
  #set align(left)
  #grid(
    rows: (11pt, 1fr),
    rect(width: 100%, height: 100%, fill: g1, stroke: (bottom: 0.4pt + g2), inset: (x: 4pt), align(horizon,
      grid(columns: (1fr, auto), text(size: 5.5pt, weight: "bold")[#box(width: 4pt, height: 4pt, fill: kuning, stroke: 0.4pt + ink) TANGGAP], text(size: 5pt)[#nav]))),
    if side == none { pad(5pt, body) } else {
      grid(columns: (30pt, 1fr),
        rect(width: 100%, height: 100%, fill: g1, stroke: (right: 0.4pt + g2), inset: 3pt,
          stack(spacing: 4pt, ..side.map(s => text(size: 5pt, weight: if s.starts-with("*") { "bold" } else { "regular" }, s.trim("*"))))),
        pad(5pt, body))
    },
  )
]
