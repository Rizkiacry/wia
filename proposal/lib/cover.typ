#let cover(title: "[JUDUL KARYA]", team: "Nama Tim", members: ()) = align(center)[
  #v(-4pt)
  #image("/media/image2.png", width: 451.5pt)
  #v(60pt)
  #image("/media/image3.png", width: 149.05pt)
  #v(65pt)
  #text(size: 16pt)[#strong[\[JUDUL KARYA]\]]
  #v(29pt)
  #set par(leading: 1.13em)
  #set text(size: 12pt)
  Disusun Oleh \[#strong(emph[#team\]]) :
  #set text(style: "italic")
  #for m in members [\ #m]
]
