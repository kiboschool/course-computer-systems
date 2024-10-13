# Introduction to C (gcc)

## Overview

Let's take a break and get to writing some code!  Throughout this term, we are going to spend our time working with the
C programming language.  C is highly valued in systems programming due to its close-to-hardware level of abstraction,
allowing programmers to interact directly with memory through pointers and memory management functions. This proximity
to hardware makes C ideal for developing low-level system components such as operating systems, device drivers, and
embedded systems, where efficiency and control over system resources are paramount. Additionally, C's widespread use and
performance efficiency, combined with a rich set of operators and standard libraries, make it a foundational language
for building complex, high-performance system architectures.

## Using `gcc`

`gcc` stands for GNU C Compiler (and `g++` is the GNU C++ Compiler).  We will give a quick introduction to get you
started with the compiler.  Instructions for installing `gcc` on your platform are provided in the homework assignment. 

Let's say that you have a simple "Hello, World" program as follows:

```C
#include <stdio.h>

void main ()
{
    printf("hello");
}
```

You can compile and run this from your prompt as follows:

```bash
$ gcc hello.c 
```

This will create an executable file called "a.out", which you can run using the following command:

```bash
$ ./a.out
```

Alternatively, you can specify the name of the executable that gets generates by using the "-o" flag.  Here's an example:

```bash
$ gcc -o hello hello.c
```

If there are any syntax errors in your program, the compilation will fail and you'll get an error message letting you know 
what the error is (thought it may be a bit cryptic).  

This should get you started with the very basics of using gcc.

## C Language Tutorial

This video will provide a good introduction to much of the syntax of the language.  You'll probably notice that the video
is four hours long!  Don't worry, though, you only need to watch the first hour for now.  I encourage you to revisit
this video over the coming weeks to learn about some of other syntax that may come in handy in the following weeks.

Also, as you are approached learning C, remember that you already know how to program and that you can apply that knowledge
to C.  In other words, at this point, you don't need to learn *what* an if statement is or how to use if statements to
construct more complex logic, you just need to learn *how* to write an if statement in C. Don't be overwhelmed!

As always, it's best to try to follow along on your own with the tutorial as you go.  Try entering the programs on your
computer and running them yourself, then experiment with how you can make the sample programs perform other operations!

<div class="embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/KJgsSFOSQv0?si=brwvdanF4ygx83XM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

## References

There are a ton of really good references available to you as you learn C.  The one that I highly recommend is the book
that is commonly referred to as "K & R" for its authors, Brian Kernighan and Dennis Ritchie, the creator of the C
language. The book is very well written, thorough in its coverage, provides lots of good practice problems.  
You can view the full text of the book linked below:

Kernighan, B.W.; Ritchie, D.M.  [The C Programming Language](https://courses.physics.ucsd.edu/2014/Winter/physics141/Labs/Lab1/The_C_Programming_Language.pdf). Prentice Hall Software Series.

## Exploration

In the introduction of this section, I mentioned that C was often used in systems programming due to its
"close-to-hardware" level of abstraction.  Let's explore a very simple example, which will demonstrate some of these
operations.  Try walking through the below example and writing down on paper, the bits that correspond to the value of
`x` at each step of executing the program and what the corresponding integer value is.  After you have stepped through
it manually, enter the program and see if your predictions match the output.

```C
#include <stdio.h>

// Function to set the nth bit of x
unsigned int setBit(unsigned int x, int n) {
    return x | (1 << n);
}

// Function to clear the nth bit of x
unsigned int clearBit(unsigned int x, int n) {
    return x & ~(1 << n);
}

// Function to toggle the nth bit of x
unsigned int toggleBit(unsigned int x, int n) {
    return x ^ (1 << n);
}

// Function to check if the nth bit of x is set (1)
int isBitSet(unsigned int x, int n) {
    return (x & (1 << n)) != 0;
}

int main() {
    unsigned int x = 0; // Initial value

    printf("Initial value: %u\n", x);

    // Set the 3rd bit
    x = setBit(x, 3);
    printf("After setting 3rd bit: %u\n", x);

    // Clear the 3rd bit
    x = clearBit(x, 3);
    printf("After clearing 3rd bit: %u\n", x);

    // Toggle the 2nd bit
    x = toggleBit(x, 2);
    printf("After toggling 2nd bit: %u\n", x);

    // Check if 1st bit is set
    printf("Is 1st bit set? %s\n", isBitSet(x, 1) ? "Yes" : "No");

    // Check if 2nd bit is set
    printf("Is 2nd bit set? %s\n", isBitSet(x, 2) ? "Yes" : "No");

    return 0;
}
```

> ❓ **Test Your Knowledge**
>
> Did your answers match the actual output?  If not, try experimenting with the [Memory
> Spy](https://memory-spy.wizardzines.com/) tool to see how the computer sees the data, though you'll have to the
> program into smaller pieces.  For example, [this
> example](https://memory-spy.wizardzines.com/game#run=I2luY2x1ZGUgPGludHR5cGVzLmg+CmludCBtYWluICgpIHsKICBpbnQgeCA9IDEyODsKICBpbnQgeSA9IDEgPDwgMzsKICBpbnQgeiA9IHggXiB5Owp9Cg==)
> shows the result of performing a basic shift operation and "anding" it to another value.

<!-- https://ocw.mit.edu/courses/6-087-practical-programming-in-c-january-iap-2010/pages/assignments/ -->
<!-- https://memory-spy.wizardzines.com/ -->