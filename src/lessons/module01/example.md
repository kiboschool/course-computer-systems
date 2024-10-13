# Example Lesson

Some of the markdown features available to use in lessons. 

See the `example.md` file to see the source markdown, and open the page [1.1 Example Lesson](./example.md) to see the rendered HTML.

## Links, lists, and emphasis

[Markdown syntax](https://www.markdownguide.org/basic-syntax/) can create:

- lists
- links
- _italicized_ and **bold** text for emphasis
- inline `monospaced / code` formatting
- multiline code blocks

```python
name = input("name: ")
print("hello", name)
```

We try to stick to `-` for lists, `_` for italics, and `**` for bold. Markdown syntax is
more permissive -- a single `*` could mean a list or italics.

## Tables

For things like a course schedule, or other tabular information, it's convenient
to display a table.

| Resource | Purpose | Link |
|---|---|---|
| Markdown Tables Generator | Make writing tables easier | [Link](https://www.tablesgenerator.com/markdown_tables) |

## Insets

You can inset notes to draw attention, using blockquotes or the `<aside>` tag.

> blockquote
> uses the `>` character

<aside>

  Aside uses inline HTML

</aside>

## Toggle (details/summary)

To have content that hides and shows with an arrow, use the `<details>` and
`<summary>` tags.

<details><summary>Summary is the 'title' of the toggle</summary>

The other content within `<details>` is hidden until toggled open.

**You can have other kinds of content within a toggle.**

I frequently use it to hide videos or other embeds that are optional viewing.

</details>


## Youtube Embed

* We prefer youtube for video embeds; it has better availability for students than other video hosts
* Use "Unlisted" for videos
* Use the wrapping div (copy paste from this example and update the youtube embed `src`) instead of the default youtube embed. The default does not resize flexibly.

<div class="embed"><iframe src="https://www.youtube.com/embed/jfa-YLyanFw" title="Weather - Reading from API Part 1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>

## Other kinds of embeds

Other tools we've embedded in the past include

- Padlet
- Google Forms
- Typeform
- Replit

Typically, they have an iframe / embed in their 'share' settings that you can copy. To make it look nice on our page, use the wrapping div like the Youtube example above. 

Remove any other styles from what you copied, and add `<div class="embed">` around the iframe.
