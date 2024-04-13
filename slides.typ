// what are my goals for this presentation?
// - get everyone to make their first document with typst
// - explain the most basic concepts # [] {}
// - show how to use the great documentation
// - a small exercise
// - just do some live navigation of important concepts in the doc and explain them
// - grid, stack, v, h
// (- explain how this presentation itself was made using typst)

// idea make a slide that shows itself but smaller (is this possible?)
// idea randomly insert memes between every other slide (probably not a good idea lol) -> no random as of yet so don't do this

// Agenda

// 0. What ist Typst (compare with Latex maybe)
// 1. How to install tpyst
// 2. Basics (tpying, set rules, show rules)
// 3. Some useful basics that I have already used (grid, stack, v, h)
// 3. Scripting (if for [] {} functions, arrays, dicts)
// 4. The docs
// 5. Small exercise (I will do it live as well)
// 6. Live explanation of presentation code

#import "@preview/polylux:0.3.1": *
#import themes.clean: *

// ------------------------------------------------------------------------------------------------

// define some standard colors
#let ul_red = rgb("#ca0123")
#let typst_turquoise = rgb("#239dae")

// ------------------------------------------------------------------------------------------------

#show: clean-theme.with(
  footer: text(fill: ul_red, weight: "semibold")[Safety. Science. Transformation.™],
  short-title: [Intro to typst],
  logo: image("UL_Logo.png"),
  color: ul_red
)

#show "typst": it => {
  set text(font: "Verdana", weight: "semibold", fill: typst_turquoise)
  [typst]
}

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

#show raw.where(lang: "typ-show"): it => {
  grid(
    columns: (1fr, 1fr),
    align: (center, left),
    raw(align: start, block: true, it.text, lang: "typ"),
    rect(radius: 10pt, inset: 25pt, eval(it.text, mode: "markup"))
  )
}

#show heading.where(level: 2): it => {
  stack(
    it,
    v(1em)
  )
}

// ------------------------------------------------------------------------------------------------

#set text(font: "Arial") // changing font size won't affect slides

// ------------------------------------------------------------------------------------------------

#title-slide(
  title: "typst",
  subtitle: "An Introduction",
  authors: "Jörg Planner",
  date: datetime.today().display(),
  watermark: [],
  secondlogo: []
)

#new-section-slide[Installation & Setup]

#slide[
  ```typ-show
  #set text(fill: blue)
  I'm blue
  ```
]

#slide[
  #align(horizon)[why is this not on horizon?]
]

#slide[
  == 1. Installation


  #align(horizon)[We are going to install typst with `winget`:]

  ```shell
  C:\Users\26383> winget install --id Typst.Typst
  ```
]

#slide[
  == 2. VS Code Setup

  Just install typst LSP

  TODO
]

#new-section-slide[The Basics]

#slide[
  == Text

  ```typ-show
  Just writing text

  + lists
  + with
  + items
  ```
]

#new-section-slide[Scripting]

#new-section-slide[The Docs]

#focus-slide(background: ul_red)[
  #set align(center)
  Live Demo!
]
