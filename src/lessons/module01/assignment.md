<!--meta exposure: initial -->
<!--meta assessmentFormat: assignment -->
<!--meta instructionType: specific -->
<!--meta submissionFormatFlexibility: yes -->
<!--meta submissionTopicFlexibility: yes -->
<!--meta rubricAvailable: yes -->
<!--meta rubricShared: yes -->
<!--meta groupWork: yes -->
<!--meta automatedGrading: 5 -->
<!--meta studentInstructionsLink: course-computer-systems/src/lessons/module01/assignment.md -->
<!--meta topics:  -->

# Assignment 1: Introduction to C

Click this link to clone the repository: [Assignment1-Intro-to-C](https://github.com/kiboschool/cs-assignment1-intro-c)

## Overview

In this first assignment, you will get your system set up to be able to compile and run C programs, begin to familiarize
yourself with the C programming language (we will use C throughout this term), and apply some of what you have learned
about how your computer represents numbers.

## Set Up Your Environment

Some general instructions for getting up and running with C on your computer are provided below. However, at this point
in the program, we expect that you will be able to figure out some of the details yourself. If you get stuck, *please*
reach out on Discord!

### Windows 10 or 11

[Mingw](https://www.mingw-w64.org) is a Windows runtime environment for `GCC`, `GDB`, `make` and related binutils. To
install `mingw`, open up a Windows Terminal and run the following `scoop` command. This assumes that you already have
`scoop` installed.  If you don't, following the instructions at [scoop.sh](https://scoop.sh/#/) to install it.

```bash
> scoop install mingw
```

### OS X

Install `gcc` and `gdb` using `brew`. If you don't have `brew` installed, first following the instructions at
[brew.sh](https://brew.sh/) to install it.

```bash
> brew install gcc
> brew install gdb
```

### Alternatives: Linux Virtual Machine, Dual Boot, or WSL

The GNU tools work particularly well in Linux, Unix, and FreeBSD -based environments.  If you are running Windows, you
can get up and running with a full Linux environments a number of different ways.  Refer to the following article for
information about those options [How to Install Ubuntu on
Windows](https://www.minitool.com/partition-disk/install-ubuntu-on-windows-11.html).

### Test Your Setup

1. Next, let's test your setup to make sure that everything is installed properly.  Create a file that contains the
   following basic C program.  You may use whatever editor you chose (e.g., notepad, emacs, vi, VSCode, etc.).  Name
   your file `hello.c`.

   ```C
   #include <stdio.h>

   int main() {
      printf("Hello, World!\n");
      return 0;
   }
   ```

2. From within your shell, make sure that you have navigated to the directory containing the file you just created and
   run the following commands:

   ```bash
   > gcc hello.c -o hello
   ```

   This command uses the `gcc` compiler to compile your C program into an executable called `hello`. You can now
   run your compiled program as follows:

   ```bash
   > ./hello
   ```

   If all goes well, your program should print out the message "Hello, World!" to the prompt.  If all didn't go well,
   please post your errors or questions to the course's Discord Channel.  

## Assignment

**Objective:**

Develop a C program to parse command-line arguments and determine if they match specific patterns. This
assignment is designed to introduce you to C while applying some of what you have learned about number representations
and challenge your problem-solving skills.

**Task:**

Implement a program in ANSI C that takes command-line arguments and checks if each argument matches a specific
pattern based on a command-line flag: `-x`, `-y`, or `-z`, with `-x` being the default. The program should handle a `-v`
flag for a variant output.

**Output:**

By default, the program prints “match” for each argument that matches the pattern and “nomatch” for those
that do not, each on a separate line. If the `-v` flag is provided, the program instead performs a transformation on
matching arguments (specified below) and prints nothing for non-matching arguments.

**Flags:**

- At most one of `-x`, `-y`, or `-z` can be provided.
- The `-v` flag can appear before or after the pattern flag.
- All flags precede other command-line arguments.
- Non-flag arguments do not start with `-`.
- All arguments are in ASCII.

**Patterns and Conversions:**

- **-x mode:**
  - Match a sequence of alternating digits and letters (e.g., `1a2b3`), ending with a digit.
  - For matches with `-v`, convert each character to its ASCII value.
  - Example: `1a2b` → `1-97-2-98-3`

- **-y mode:**
  - Match any string where the sum of ASCII values of all characters is a prime number.
  - For matches with `-v`, convert the string into its hexadecimal ASCII representation.
  - Example: `abb` (sum = 293, not a prime number) → `61-62-62`

- **-z mode:**
  - Match strings that form a valid arithmetic expression using digits and `+`, `-`, `*`, `/` (e.g., `12+3-4`).
  - For matches with `-v`, print the number of `+` operations, followed by the number of `-` operations, followed by the number of `*` operations, followed by the number of `\` operations.
  - Example: `12+3-4` → `1100`
  - Note that depending on your shell, you may have to surround the expression with quotes when passing it through the command line.  In Unix-like shells, `*` is interpreted as a wildcard character.

**Constraints:**

- Compile without errors using `gcc` with no extra flags.
- Do not depend on libraries other than the standard C library.
- Do not use `regex.h`, multiplication, division, or modulo operators. Bitwise operations are allowed.
- Hand in a single `assignment1.c` file.

**Examples:**

```bash
$ ./assignment1 -x 1a2b3
match
$ ./assignment1 -x -v 1a2b3
1-97-2-98-3
$ ./assignment1 -y abb
match
$ ./assignment1 -z 12+3-4
match
$ ./assignment1 -z "1+2*3*2"
1020
```

## Grading

**Total Points: 70**

1. **Correctness and Functionality (55 Points)**
   - **Pattern Matching (-x, -y, -z) (45 points)**
     - Correctly identifies matching and non-matching patterns for each mode. (15 points per mode)
   - **Transformation with -v Flag (10 points)**
     - Correctly performs the specified transformations for matching patterns.

2. **Code Quality and Style (10 Points)**
   - **Readability and Comments (5 points)**
     - Code is well-organized and readable with clear, concise comments explaining complex logic.
   - **Conventions and Syntax (5 points)**
     - Consistent naming conventions and adherence to standard C syntax and idiomatic practices.

3. **Efficiency (5 Points)**
   - **Algorithmic Efficiency (5 points)**
     - Uses efficient solutions and avoids unnecessary computations.

## Submitting Your Work

Your work must be submitted Anchor for degree credit and to Gradescope for
grading.

1. Ensure that you `commit` and `push` your local code changes to your remote
   repository.  (Note: In general, you should commit and push frequently, so
   that you have a backup of your work, so that there is evidence that you did
   your own work, and so that you can return to a previous state easily.)
2. Upload your submission to [Gradescope](https://www.gradescope.com) via the
   appropriate submission link by selecting the correct GitHub repository from
   the drop-down list.
3. Export a zip archive of your GitHub repository by visiting your repo on
   [GitHub](https://www.github.com), clicking on the green `Code` button, and
   selecting "Download Zip".
4. Upload the zip file of your repository to Anchor using the form below.