# Kibo Course Template

## Using this template

- create a github repo for the course
- update this Readme with the relevant info for the course
- update book.toml with the course name and authors
- create a main and draft vercel deployment 
- update the materials in src/

# [Course Name]

- Course design plan: 
- See course info: 
- See info about Kibo's BSc. Computer Science: https://kibo.school/degree/

## What's here?

```
$ tree .
.
├── README.md
├── book.toml
├── convert.rb
├── theme/
└── src
    ├── SUMMARY.md
    ├── course-overview.md
    ├── assessments.md
    ├── live-classes.md
    └── lessons/
        ├── week-1.md
        └── week-1/
            └── example.md
```

### README.md

This describes how to set up and edit the site.

### book.toml

Config file for the course. Authors, title, other mdbook settings.

https://rust-lang.github.io/mdBook/format/configuration/index.html

### convert.rb

If the course was built on Notion, you can convert it to an mdbook course.

1. Download the notion export from your course
2. Edit the constants to fit your course and set the notion export directory.
3. Run `./convert.rb`

Otherwise, you can remove this file.

### theme/

Any overrides of the default mdbook theme. Right now, just some custom CSS on
top of the standard mdbook CSS.

https://rust-lang.github.io/mdBook/format/theme/index.html

### src

Holds all the course files.

The static site output will be built to `output`, but that's git ignored.

### src/SUMMARY.md

This gets turned into the sidebar on the site.

It's the text that should show, plus links to other md files in `src/`.

https://rust-lang.github.io/mdBook/format/summary.html

Anything that is _not_ linked in the sidebar will not be included in the output
site.

### src/*

Pages at the top level of the source folder are for overview information about the course. The template includes:

- Course Overview - `course-overview.md`
- Assessments - `assessments.md`
- Live Classes - `live-classes.md`

But courses will typically adjust these course information pages to fit their needs.

### src/lessons/

These are the pages that actually make up the course. It's nice to put things in folders to organize the different pages. Each week can get a 'cover page' and a page per lesson, in a folder with that name, like

```
working-with-data.md
working-with-data/
    programs-and-comments.md
    variables-and-assignment.md
    data-types-operators-and-expressions.md
    input-and-output.md
```

`lessons/week-1.md` and `lessons/week-1/example.md` illustrate what typical week and lesson pages include.

### output

To generate the static site, run:

```
mdbook build
```

Output lives in the `output` folder.

You can usually ignore these files, they aren't tracked in git.

## Getting Started

Install mdbook: https://rust-lang.github.io/mdBook/guide/installation.html

Use your package manager: 

```
brew install mdbook
```

or

```
scoop install mdbook
```

Or download a [release from Github](https://github.com/rust-lang/mdBook/releases).

Or if you use rust: `cargo install mdbook`

### Run the site locally

```
mdbook serve --open
```

## Deployment

We use `vercel` to handle deploys. It takes some setup to connect a repo to
vercel, assign a production domain, and set up auto-deploys.

* Github actions will run `mdbook build` on pushed changes
* All pushes will automatically deploy to vercel
* Vercel will notify the #tech-status channel on Slack with the deploy preview
* If you pushed to `main`, it will also deploy to the live site. Watch out!

## Previews and Drafts

If you'd like to preview changes, push to `draft` branch, which will have a
separate preview version of the site. 

Remember - commits to `main` get built and deployed to the production site; 
commits to `draft` get pushed to the preview version, others get nothing.
