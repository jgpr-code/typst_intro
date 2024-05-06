#import "@preview/polylux:0.3.1": *
#import themes.clean: *

// ------------------------------------------------------------------------------------------------

#let ul_red = rgb("#ca0123")
#let typst_turquoise = rgb("#239dae")

#set text(font: "Arial") // changing font size won't affect slides...

#let myslide(title, body) = {
  slide[
    #stack(
      heading(level: 2, title),
      v(0.25em)
    )
    #set text(size: 22pt) // here it will affect the slides though
    #body
  ]
}

// ------------------------------------------------------------------------------------------------

// #show: clean-theme.with(
//   footer: text(fill: ul_red, weight: "semibold")[Safety. Science. Transformation.™],
//   short-title: [Intro to TYPST],
//   logo: image("media/UL_Logo.png"),
//   color: ul_red
// )

#show: clean-theme.with(
  footer: text(fill: typst_turquoise, weight: "semibold")[\#SWEC24],
  short-title: [Intro to TYPST],
  logo: image("media/Typst_Logo.png"),
  color: typst_turquoise
)

#show "TYPST": it => {
  set text(font: "Verdana", weight: "semibold", fill: typst_turquoise)
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

#title-slide(
  title: "TYPST",
  subtitle: "An Introduction",
  authors: "Jörg Planner",
  date: datetime.today().display(),
  watermark: [],
  secondlogo: []
)

#new-section-slide[Installation & Setup]

#myslide("Installation")[
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

#myslide("VS Code Extensions")[
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

#new-section-slide[Scripting]

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
  }\
  #for (key, val) in dict [
    #key: #val
  ] // newlines in content block -> space 🙁
  ```
]

#myslide("Functions")[
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
]

#myslide("Sinks and Spreading")[
  ```typ-show
  // variable number of arguments
  #let separate_words(sep, ..words) = {
    let words_array = words.pos()
    for word in words_array.intersperse(sep) {
      [#word]
    }
  }
  #separate_words("~", "a", "b", "c", "d")\
  #let fruits = ("Apple", "Banana", "Cherry")
  // pass array as individual arguments
  #separate_words("|", ..fruits)
  ```
]

#new-section-slide[Other]

#myslide("Spacing")[
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