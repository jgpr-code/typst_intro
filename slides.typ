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

#let myslide(body) = {
  slide[
    #set text(size: 22pt)
    #body
  ]
}

// ------------------------------------------------------------------------------------------------

#show: clean-theme.with(
  footer: text(fill: ul_red, weight: "semibold")[Safety. Science. Transformation.™],
  short-title: [Intro to TYPST],
  logo: image("media/UL_Logo.png"),
  color: ul_red
)

#show "TYPST": it => {
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
    align: (center, center),
    raw(align: start, block: true, it.text, lang: "typ"),
    rect(radius: 10pt, inset: 15pt, [
      #set text(font: "Arial", size: 16pt)
      #set align(start)
      #eval(it.text, mode: "markup")])
  )
}

#show heading.where(level: 2): it => {
  stack(
    it,
    v(0.75em)
  )
}

// ------------------------------------------------------------------------------------------------

#set text(font: "Arial") // changing font size won't affect slides...

// ------------------------------------------------------------------------------------------------

#title-slide(
  title: "TYPST",
  subtitle: "An Introduction",
  authors: "Jörg Planner",
  date: datetime.today().display(),
  watermark: [],
  secondlogo: []
)

#new-section-slide[Installation & Setup]

#myslide[
  == 1. Installation

  To install typst we will just use `winget`:

  ```shell
  C:\Users\26383> winget install --id Typst.Typst
  ```

  Now you can already create your first typst file `file.typ` and compile it:

  ```shell
  C:\Users\26383> echo Hello World > first.typ
  C:\Users\26383> typst compile first.typ
  ```
]

#myslide[
  == 2. VS Code Extensions

  I recommend using VS Code and installing the following extensions:
  #grid(
    columns: (1fr, 1fr),
    align: (center, center),
    [
      #scale(x: 150%, y: 150%, reflow: true, image("media/Typst_LSP.png"))
    ],
    [
      #scale(x: 150%, y: 150%, reflow: true, image("media/VSCode_Pdf.png"))
    ]
  )
]

#new-section-slide[Basics]

#myslide[
  == Simple Text
  ```typ-show
  = Heading Level 1
  This is just text.

  == Heading Level 2
  An enumeration:
  + basic formattings:
    - _italic_
    - *bold*
  + /* comment */ 2nd item // comment
  ```
]

#myslide[
  == Set Rules
  ```typ-show
  Set rules allow change of style.

  #set text(font: "Consolas")
  Now all text has different font

  #set align(center)
  #set text(
    size: 18pt,
    fill: red,
    weight: "semibold")
  Text has many options!
  ```
]

#myslide[
  == Show Rules
  ```typ-show
  Show rules allow further customizations:
  #show "difficult": "easy"
  #show heading.where(
    level: 3): set text(blue)
  #show heading: it => [
    #set align(center)
    #underline(it.body)
  ]
  #show: it => {rect(inset: 10pt, it)}
  == Typst is difficult
  === Show rules are difficult
  ```
]

#new-section-slide[Scripting]

#myslide[
  == Types of Blocks
  ```typ-show
  + \[ \] is used for content
  + \# and \{ \} is used for code

  For example:

  #let a = [Content block]
  #{
    let b = [ is the default]
    a + b
  }
  ```
]

#myslide[
  == Variables and Conditionals
  #only(1)[
    ```typ-show
    #let subject = [Typst] // a variable
    #let listener = 10
    #let audience = if listener > 10 [
      Best
    ] else {
      [Greatest]
    }
    This talk is about #subject.\
    Its audience is the *#audience*!
    ```
  ]
  #only(2)[
    ```typ-show
    #let subject = [Typst] // a variable
    #let listeners = 25 // more listeners!
    #let audience = if listeners > 10 [
      Best
    ] else {
      [Greatest]
    }
    This talk is about #subject.\
    Its audience is the *#audience*!
    ```
  ]
]

#myslide[
  == Arrays, Dictionaries and Loops
  ```typ-show
  #let arr = (1, 2, 3)
  #let dict = (
    first: "Hello",
    second: "World",
  )
  #for i in arr [
    #i
  ]\
  #for (key, val) in dict [
    #key: #val\
  ]
  ```
]

#myslide[
  == Functions
  ```typ-show
  #let add(x, y) = {x + y}
  #add(2, 3)
  #let alert(fill: red, body) = {
    set text(white)
    rect(fill: fill, [*Warning*\ #body])
  }
  #alert[Functions]
  #alert("Functions")
  #alert(fill: blue)[Overwritten]
  ```
  // sinks and spreads
]

#myslide[
  == Sinks and Spreading
  ```typ-show
  // variable number of arguments
  #let separate_words(sep, ..words) = {
    let words_array = words.pos()
    for word in words_array.intersperse(sep) [
      #word
    ]
  }
  #let fruits = ("Apple", "Banana", "Cherry")
  // pass array as individual arguments
  #separate_words("|", ..fruits)
  ```
]

#new-section-slide[Other]

#myslide[
  == Spacing
  ```typ-show
  We can use `#h`#h(15pt) for horizontal and
  `#v`#v(10pt)
  for vertical spacings

  Percentages or fractions are also a cool way
  #v(10%)
  to #h(1fr) divide #h(2fr) the
  #v(10%)
  space
  ```
]

#myslide[
  == Grid
  ```typ-show
  #let rects = (aqua, orange, blue, aqua).map(
    it => rect(width: 100%, fill: it))
  #grid(
    columns: (1fr, 2fr, 3fr),
    column-gutter: 2pt, row-gutter: 2pt,
    grid.cell(
      x: 0, y: 1, colspan: 2,
      rect(width: 100%, fill: orange)
    ),
    ..rects
  )
  ```
]

#myslide[
  == Colors
  ```typ-show
  #let ul = rgb("#ca0123")
  #let typst = rgb("#239dae")
  #let gradient = gradient.linear(
    dir: ttb, ul, yellow, typst
  )
  #set align(center)
  #set text(size: 50pt, fill: gradient)
  #stack(spacing: 10pt)[Colors][♥❤♥][Typst]

  ```
]

#new-section-slide[
  #link("https://typst.app/docs/reference")[Documentation]\
  &\
  Live Demo
]

#new-section-slide[Questions?]

#focus-slide(background: ul_red)[
  #set align(center)
  The END
]