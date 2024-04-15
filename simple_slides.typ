#import "@preview/polylux:0.3.1": *
#import themes.simple: *

#set text(font: "Inria Sans")

#show: simple-theme.with(
  footer: [Simple slides],
)


// Display inline code in a small box
// that retains the correct baseline.
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

// Display block code in a larger block
// with more padding.
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

#set raw(align: left)

#show raw.where(lang: "typ-show"): it => {
  grid(
    columns: (1fr, 1fr),
    align: (center, left),
    raw(it.text, lang: "typ"),
    rect(radius: 10pt, inset: 25pt, eval(it.text, mode: "markup"))
  )
}


#title-slide[
  = Keep it simple!
  #v(2em)

  Alpha #footnote[Uni Augsburg] #h(1em)
  Bravo #footnote[Uni Bayreuth] #h(1em)
  Charlie #footnote[Uni Chemnitz] #h(1em)

  July 23
]

#slide[
  == 2. VS Code Setup

  #alternatives[
    For a nicer experience VS Code offers the "Typst LSP" extension:

    #image("media/VSCode_Tooltip.png")
  ][
    Another extension we probably want is "vscode-pdf" to view the compiled pdf directly in VS Code.
  ]
]

#slide[
  ```typ-show
  #set text(fill: blue)
  I'm blue
  ```
]

#slide[
  #set align(center)
  ```rust
  let a = 5;
  let longer = 123;
  ```
]