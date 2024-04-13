#import "@preview/polylux:0.3.1": *
#import themes.clean: *

#set text(font: "Inria Sans")

#show: clean-theme.with(
  footer: [Author, institution],
  short-title: [Short title],
  logo: [],
)

#title-slide(
  title: [Presentation title],
  subtitle: [Presentation subtitle],
  authors: ([Author A], [Author B], [Author C]),
  date: [January 1, 1970],
  watermark: [],
)

#slide(title: [First slide title])[
  #lorem(20)
]

#new-section-slide("The new section")

#slide(title: "Another slide")[
  Note that you can see the section title at the top.

  The rest of this slide will fill more than one page!

  #lorem(100)
]

#focus-slide[
  _Focus!_

  This is very important.
]