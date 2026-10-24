#let toc() = {
  pagebreak()
  heading(level: 1, [DAFTAR ISI])
  set par(justify: false, leading: 0pt)
  show outline.entry: it => {
    let chap = it.level == 1
    block(above: if chap { 6pt } else { 4.5pt }, below: 0pt, inset: (left: if chap { 0pt } else { 18pt }), {
      set text(weight: if chap { "bold" } else { "regular" })
      link(it.element.location(), it.indented(none, it.inner()))
    })
  }
  set outline.entry(fill: repeat[.])
  outline(title: none, depth: 2, indent: 0pt)
}
