// Theme: page setup, global styles, and reusable helpers.
#let font = "Plus Jakarta Sans"

// Apply with `#show: wia`
#let wia(doc) = {
  set document(title: "Proposal (WIA) Web In Action")
  set page(
    paper: "a4",
    margin: 72pt,
    background: image("/media/image1.png", width: 100%, height: 100%, fit: "stretch"),
  )
  set text(font: font, size: 11pt, lang: "id", fill: black, top-edge: "ascender", bottom-edge: "descender")
  set par(justify: true, leading: 0.95em, spacing: 0pt)

  show heading.where(level: 1): it => {
    set text(size: 13pt, weight: "bold", style: "normal")
    set par(justify: false, leading: 0pt)
    pagebreak(weak: true)
    align(center, block(above: 0pt, below: 17pt, it.body))
  }
  show heading.where(level: 2): it => {
    set text(size: 11pt, weight: "bold")
    set par(justify: false)
    block(above: 23pt, below: 3.6pt, sticky: true, it.body)
  }
  doc
}

// Italic placeholder/body text with Word-like 1.5 line spacing.
#let body(it, size: 11pt) = {
  set text(size: size, style: "italic")
  set par(leading: 0.63em, spacing: 0.63em)
  set block(spacing: 0.63em)
  it
}
#let indented(it, size: 11pt) = pad(left: 21.26pt, body(it, size: size))

// Lettered list item: #li[Label][ : text]
#let li(term, rest) = counter("li").step() + v(0.63em) + pad(left: 18pt, body(grid(
  columns: (18pt, 1fr), column-gutter: 0pt,
  context text(font: "Liberation Serif", size: 10pt)[#numbering("a.", counter("li").get().first())],
  [#strong[#term]#rest],
)))

// Chapter heading on a new page: #bab("BAB I", "PENDAHULUAN")
#let bab(num, title) = {
  pagebreak(weak: true)
  heading(level: 1, [#num \ #title])
}
