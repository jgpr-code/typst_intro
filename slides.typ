#import "@preview/polylux:0.4.0": *
// ------------------------------------------------------------------------------------------------

#let UL_RED = rgb("#ca0123")
#let UL_BRANDED = false
#let TYPST_TURQUOISE = rgb("#239dae")
#let PRESENT_DATE = datetime(year: 2025, month: 5, day: 17).display()
#let SHOW_INSTALLATION = true

#set text(font: "Arial", size: 22pt)
#let footer = if UL_BRANDED {
  text(fill: UL_RED, weight: "semibold")[Safety. Science. Transformation.™]
} else {
  text(fill: TYPST_TURQUOISE, weight: "semibold")[\#SWEC25]
}
#show: set page(
  paper: "presentation-16-9", // "presentation-4-3"
  footer: footer,
)

#let myslide(title, body) = {
  slide[
    #stack(
      heading(level: 2, title),
      v(0.25em),
    )
    #body
  ]
}

#let title_slide(title, subtitle, author) = {
  show: it => {
    set align(center + horizon)
    set page(footer: none)
    it
  }
  show heading: set text(size: 50pt)
  slide[
    = #title
    #text(size: 25pt, subtitle)
    #v(1em)
    Jörg Planner\
    #PRESENT_DATE
  ]
}

#let section_slide(title) = {
  show heading: it => {
    set align(center + horizon)
    set text(size: 35pt)
    it
  }
  slide[
    = #title
  ]
}

// ------------------------------------------------------------------------------------------------

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
    rect(
      radius: 10pt,
      inset: 15pt,
      {
        set text(font: "Arial", size: 16pt)
        set align(start)
        eval(it.text, mode: "markup")
      },
    ),
  )
}

// ------------------------------------------------------------------------------------------------
#title_slide("TYPST", "An Introduction", "Jörg Planner")

#if SHOW_INSTALLATION {
  section_slide[Installation & Setup]
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

    Get the "Tinymist Typst" extension for VS Code for nice IDE experience!
  ]
}

#section_slide[Basics]

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

#myslide("Images")[
  ```typ-show
  Its also easy to display images:

  #image("media/logo.png", width: 70%)
  ```
]

#section_slide[Scripting]

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

#section_slide[Layout]

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

#section_slide[Fun]

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

#section_slide[
  #link("https://typst.app/docs/reference")[Documentation]\
  &\
  Live Demo
]

#section_slide[Questions?]
