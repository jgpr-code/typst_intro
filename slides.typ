#import "@preview/polylux:0.4.0": *
// ------------------------------------------------------------------------------------------------

#let UL_RED = rgb("#ca0123")
#let UL_BRANDED = false
#let TYPST_TURQUOISE = rgb("#239dae")
#let PRESENT_DATE = datetime(year: 2024, month: 12, day: 6).display()
#let SHOW_INSTALLATION = false

#set text(font: "Arial", size: 22pt)
// #set page(paper: "presentation-4-3")
#set page(paper: "presentation-16-9", footer: text(fill: UL_RED, weight: "semibold")[Safety. Science. Transformation.™])

#let myslide(title, body) = {
  slide[
    #stack(
      heading(level: 2, title),
      v(0.25em)
    )
    #body
  ]
}

// ------------------------------------------------------------------------------------------------

// #if UL_BRANDED {
//   show: clean-theme.with(
//     footer: text(fill: UL_RED, weight: "semibold")[Safety. Science. Transformation.™],
//     short-title: [Intro to TYPST],
//     logo: image("media_private/UL_Logo.png"),
//     color: UL_RED
//   )
// } else {
//   show: clean-theme.with(
//     footer: text(fill: TYPST_TURQUOISE, weight: "semibold")[\#SWEC24],
//     short-title: [Intro to TYPST],
//     // logo: image("media/Typst_Logo.png"),
//     color: TYPST_TURQUOISE
//   )
// }

#show "TYPST": it => {
  set text(font: "Verdana", weight: "semibold", fill: TYPST_TURQUOISE)
  [typst]
}

#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

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
    rect(radius: 10pt, inset: 15pt, {
      set text(font: "Arial", size: 16pt)
      set align(start)
      eval(it.text, mode: "markup")})
  )
}

// ------------------------------------------------------------------------------------------------
#slide[
  == TYPST
]
// #title-slide(
//   title: "TYPST",
//   subtitle: "An Introduction",
//   authors: "Jörg Planner",
//   date: PRESENT_DATE,
//   watermark: [],
//   secondlogo: []
// )

#if SHOW_INSTALLATION {
  // new-section-slide[Installation & Setup]

  myslide("Installation")[
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

  myslide("VS Code Extensions")[
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
}

// #new-section-slide[Basics]

#myslide("Simple Text")[
  ```typ-show
  = Heading Level 1
  Just text.\ \\ forces a linebreak

  == Heading Level 2
  An enumeration:
  + basic formattings:
    - _italic_
    - *bold*
  + /* comment */ 2nd item // comment
  ```
]

#myslide("Set Rules")[
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

#myslide("Show Rules")[
  ```typ-show
  Show rules allow further customizations:
  #show "difficult": "easy"
  #show heading: heading => [
    #set align(center)
    #underline(heading.body)
  ]
  #show heading.where(level: 3): set text(red)
  #show: it => {rect(inset: 10pt, it)}

  == Typst is difficult
  === Show rules are difficult
  #lorem(20)
  ```
]

// #new-section-slide[Scripting]

#myslide("Variables and Conditionals")[
  #only(1)[
    ```typ-show
    #let subject = [Typst] // a variable
    #let listeners = 10
    #let audience = if listeners > 10 {
      [the *Best*]
    } else {
      [very good]
    }

    This talk is about #subject.\
    Its audience is #audience!
    ```
  ]
  #only(2)[
    ```typ-show
    #let subject = [Typst] // a variable
    #let listeners = 25 // now more!
    #let audience = if listeners > 10 {
      [the *Best*]
    } else {
      [very good]
    }

    This talk is about #subject.\
    Its audience is #audience!
    ```
  ]
]

#myslide("Types of Blocks")[
  ```typ-show
  + \[ \] is used for content
  + \# and \{ \} is used for code

  For example:

  #let a = [Content block]
  // #{ to start a code block
  #{
    let b = [ is the default]
    a + b
  }
  ```
]

#myslide("Arrays, Dictionaries and Loops")[
  ```typ-show
  #let arr = (1, 2, 3)
  #let dict = (
    first: "Hello",
    second: "World",
  )
  #for i in arr {
    [#i]
  }\ // \ for newline
  #for (key, val) in dict [
    #key: #val
  ] // content block newline -> space 🙁
  ```
]

#myslide("Functions")[
  ```typ-show
  #let add(x, y) = {x + y}

  #let alert(fill: red, body) = {
    set text(white)
    rect(fill: fill, [*Warning*\ #body])
  }

  #add(2, 3)
  #alert[Functions]
  #alert("Functions")
  #alert(fill: blue)[Overwritten]
  ```
]

#myslide("Sinks and Spreading")[
  ```typ-show
  // variable number of arguments
  #let separate_words(sep, ..words) = {
    let w_array = words.pos()
    for word in w_array.intersperse(sep) {
      [#word]
    }
  }
  #separate_words("~", "a", "b", "c", "d")

  #let fruits = ("Apple", "Banana", "Fig")
  // pass array as individual arguments
  #separate_words("|", ..fruits)
  ```
]

// #new-section-slide[Other]

#myslide("Spacing")[
  ```typ-show
  Use `#h` #h(15pt) for horizontal and `#v`
  #v(10pt)
  for vertical spacings

  Percentages or fractions are a cool way
  #v(10%)
  to #h(1fr) divide #h(2fr) the
  #v(10%)
  space
  ```
]

#myslide("Grid")[
  ```typ-show
  #let rects = (aqua, orange, blue, aqua).map(
    it => rect(width: 100%, fill: it))

  #grid(
    columns: (1fr, 2fr, 1fr),
    column-gutter: 4pt, row-gutter: 2pt,
    grid.cell(
      x: 0, y: 1, colspan: 2,
      rect(width: 100%, fill: orange)
    ),
    ..rects
  )
  ```
]

#myslide("Colors")[
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

// #new-section-slide[
//   #link("https://typst.app/docs/reference")[Documentation]\
//   &\
//   Live Demo
// ]

// #new-section-slide[Questions?]