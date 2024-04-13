#show raw.where(lang: "typ-show"): it => {
  grid(
    columns: (1fr, 1fr),
    align: (center, left),
    raw(it.text, block: true, lang: "typ"),
    rect(radius: 10pt, inset: 25pt, eval(it.text, mode: "markup"))
  )
}

```typ-show
Why is below line not left aligned?
should be left
```

#set align(center)
```typ
Why is below line not left aligned?
should be left
```