#show heading: it => [
  // #set text(font: "Inria Serif")
  \~ #underline(it.body) \~
]

= Dragon
With a base health of 15, the
dragon is the most powerful
creature.

= Manticore
While less powerful than the
dragon, the manticore gets
extra style points.

#let separate_words(separator, ..words) = {
  for word in words.pos().intersperse(separator) [
    #word
  ]
}
#let words = ("Apple", "Banana", "Strawberry")
#separate_words("|", ..words)

#let rects = (aqua, orange, blue).map(
  it => {rect(width: 100%, fill: it)}
)

#grid(
  columns: (1fr, 2fr, 3fr),
  ..rects
)

// #let rainbow = gradient.linear(red, blue, green)
// #show regex("[Tt]ypst"): it => {
//   // set text(fill: red)
//   text(fill: rainbow, box(it))
// }
// Typst

#let ul_red = rgb("#ca0123")
#let typst_turquoise = rgb("#239dae")
#let rainbow = gradient.linear(ul_red, typst_turquoise)
#show: it => {text(weight: "bold", fill: rainbow, box(it))}
UL Solutions ♥ typst

#let rects = (aqua, orange, blue, aqua).map(
  it => rect(width: 100%, fill: it)
)
#grid(
  columns: (1fr, 2fr, 3fr),
  column-gutter: 2pt,
  row-gutter: 10pt,
  grid.cell(
    x: 0, y: 1, colspan: 2,
    rect(width: 100%, fill: orange)),
  ..rects
)