# Kibo Course Template

## Using this template

- create a github repo for the course
- update this Readme with the relevant info for the course
- update book.toml with the course name and authors
- create a main and draft vercel deployment
- create Anchor course
- update the materials in src/

# [Course Name]

- Course design plan:
- See course info:
- See info about Kibo's BSc. Computer Science: https://kibo.school/degree/

## What's here?

```text
$ tree .
.
├── README.md
├── book.toml
├── course.yml
├── theme/
├── scripts
│   ├── convert.rb
│   └── yaml-to-summary.sh
└── src
    ├── SUMMARY.md
    ├── front-matter/
    │   ├── academic-integrity.md
    │   ├── assessments.md
    │   ├── course-overview.md
    │   ├── course-tools.md
    │   ├── getting-help.md
    │   ├── giving-help.md
    │   └── live-classes.md
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

### course.yml

This contains the structure and metadata for each lesson and activity, which is
ready by Anchor.  For information on the structure of this file, please visit
the section on course.yml in
[https://docs.google.com/document/d/1Hm41CGu0pZrGB7_XrPZR50DU7DXvqeC6aZuaTLpRLlo](https://docs.google.com/document/d/1Hm41CGu0pZrGB7_XrPZR50DU7DXvqeC6aZuaTLpRLlo)

### theme/

Any overrides of the default mdbook theme. Right now, just some custom CSS on
top of the standard mdbook CSS.

https://rust-lang.github.io/mdBook/format/theme/index.html

### scripts/convert.rb

If the course was built on Notion, you can convert it to an mdbook course.

1. Download the notion export from your course
2. Edit the constants to fit your course and set the notion export directory.
3. Run `./convert.rb`

### scripts/yaml-to-summary.sh

This Bash script will convert a properly formatted course.yml file into a
SUMMARY.md for use with mdbook.

1. From the root directory for the course, run the command:

    ```sh
    ./scripts/yaml-to-summary.sh
    ```

2. You can then run mdbook to view your material locally:

    ```sh
    mdbook watch . --open
    ```

### src

Holds all the course files.

The static site output will be built to `output`, but that's git ignored.

### src/SUMMARY.md

This gets turned into the sidebar on the site. In general, we recommend
focusing on using the course.yml file as the source of truth for the course
structure and associated metadata, and then using the above `yaml-to-summary.sh`
script to generate the `SUMMARY.md` file.

It's the text that should show, plus links to other md files in `src/`.

https://rust-lang.github.io/mdBook/format/summary.html

Anything that is _not_ linked in the sidebar will not be included in the output
site.

### src/front-matter

Pages front-matter folder are for overview information about the course. The
template includes:

- Course Overview - `course-overview.md`
- Assessments - `assessments.md`
- Live Classes - `live-classes.md`
  - ...

Courses will typically adjust these course information pages to fit their
needs, though we should strive to maintain consistency between courses,
where appropriate (e.g., guidance on getting help and giving help is likely
to be the same for most courses.)

### src/lessons/

These are the pages that make up the course learning materials. It's nice to put
things in folders to organize the different pages. Each week can get an
'introduction page' and a page per lesson, in a folder with that name, like

```text
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

```sh
mdbook build
```

Output lives in the `output` folder.

You can usually ignore these files, they aren't tracked in git.

## Getting Started

Install mdbook: https://rust-lang.github.io/mdBook/guide/installation.html

Use your package manager: 

```sh
brew install mdbook
```

or

```sh
scoop install mdbook
```

Or download a [release from Github](https://github.com/rust-lang/mdBook/releases).

Or if you use rust: `cargo install mdbook`

### Run the site locally

```sh
mdbook serve --open
```

## Deployment

If your course.yml file is correct and meets all validations, the
course will get published to Anchor when changes are pushed to the GitHub
repository.
