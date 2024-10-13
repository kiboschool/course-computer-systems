# Introduction to ISA

[Instruction Set Architecture (ISA)] (https://en.wikipedia.org/wiki/Instruction_set_architecture), is the interface that stands between the hardware and low-level software. In this module, we will delve into various types of ISAs and their usage.

Let’s first refresh our memories about basic CPU operation:

<div class="embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/sK-49uz3lGg?si=jLdDYNetQ1OgaVos" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

## Definition of ISA

The Instruction Set Architecture (ISA) is essentially the interface between the hardware and the software of a computer system. The ISA encompasses everything the software needs to know to correctly communicate with the hardware, including but not limited to, the specifics of the necessary data types, machine language, input and output operations, and memory addressing modes.

## Role of ISA in Computer Organization

The ISA is what defines a computer's capabilities as perceived by a programmer. The [microarchitecture](https://en.wikipedia.org/wiki/Microarchitecture), or the computer's physical design and layout, is built to implement this set of functions. Any changes in the ISA would necessitate a change in the underlying microarchitecture, and conversely, changes in microarchitecture often foster enhancements in the ISA. 

The ISA--via its role as an intermediary between software and hardware--enables standardized software development since software developers can write software for the ISA, not for a specific microarchitecture. As long as the microarchitecture correctly implements the ISA, the software will function as expected.

Programmers using high-level languages such as C or Python are often insulated from these lower-level details. However, understanding the connection can aid programmers in creating more efficient and effective code.

> **Check Your Understanding**: What is the role of Instruction Set Architecture (ISA) in a computer system?
> <details><summary>Click Here for the Answer</summary>ISA is essentially the interface between the hardware and the software of a computer system. It outlines the specifics needed for software to correctly communicate with the hardware.</details>

## ISA Types

ISAs are classified into three essential types - RISC, CISC, and Hybrid.

### RISC

Reduced Instruction Set Computer (RISC) has simple instructions that execute within a single clock cycle. Notable examples include ARM, [MIPS](https://en.wikipedia.org/wiki/MIPS_architecture), and PowerPC. Generally speaking, since the instructions are simpler in RISC architectures, each individual instruction teds to complete more quickly.  The downside is that it takes more instructions to complete a task.  In addition, it allows room for other enhancements, such as advanced techniques for pipelining and superscalar execution (to be discussed later this term), contributing to a higher performing processor. 

### CISC

Complex Instruction Set Computer (CISC) has complex instructions that may require multiple clock cycles for execution. A notable example is the [x86](https://en.wikipedia.org/wiki/X86) architecture. CISC operates on a principle that the CPU should have direct support for high-level language constructs.

### Hybrid

Hybrid or Mixed ISAs combine elements of both RISC and CISC, aiming to reap the benefits of both architectures. In such cases, a Hybrid ISA might contain a core set of simple instructions alongside more complex, multi-clock ones for certain use-cases. An example of a hybrid ISA is the [x86-64](https://en.wikipedia.org/wiki/X86-64), used in most desktop and laptop computers today.

## Usage of ISAs

RISC ISAs are traditionally used in applications where power efficiency is essential, such as in ARM processors often found in smartphones and tablets. They enable these devices to have long battery life while providing satisfactory performance.

On the other hand, CISC ISAs are commonly employed in devices needing high computational power. Your desktop or laptop computer likely employs a CISC ISA, such as the x86 or x86-64 architecture.

To illustrate this, consider a `MOV` command in an x86 assembly language, a form of a CISC ISA:

`MOV DEST, SRC`

This single instruction moves a value from the `SRC` (source) to `DEST` (destination). It's a complex operation wrapped in one instruction, embodying the CISC philosophy to reduce the program size and increase code efficiency.

In comparison, an equivalent operation in a RISC ISA like ARM might require several instructions:

```assembly
LDR R1, SRC
STR R1, DEST
```

In this example, data is loaded from the memory address `SRC` into a storage location within the microprocessor, and then separately stored to memory address `DEST`.  

> **Check Your Understanding**: How does ISA influence software development?
> <details><summary>Click Here for the Answer</summary> The ISA standardizes software development. Developers write software for the ISA, not for a specific microarchitecture. This allows the same software to operate on different hardware as long as the hardware implements the ISA correctly.</details>

## Overview of x86 ISA

Perhaps the most dominant ISA in the computing world is the x86 instruction set. It is a broad term referring to a family of microprocessors that share a common heritage from Intel. The ISA began with the 8086 microprocessor in the late 1970s and was later extended by the 80286, 80386, and 80486 processors in the 1980s and early 1990s. The naming convention for this series of processors is where the 'x86' terminology comes from.

The x86 ISA has been repeatedly expanded to incorporate capabilities needed for contemporary computing, such as 64-bit data bus width and multi-core functionality. Today, the majority of personal computers and many servers utilize the x86 ISA or its extensions. 

For a more detailed journey into the world of the x86 ISA, check out this video:

<div class="embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/kvDBJC_akyg?si=Jpq4kbCPjJtOqgo3" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

For a more practical understanding, let's examine a simple scenario using C and x86 assembly language. Suppose we have a C program with the following line of code:

```C
int a = 10 + 20;
```

The corresponding x86 assembly code could look like:

```Assembly
mov eax, 10
add eax, 20
```

Here, the C language line involving addition of two integers translate to two assembly instructions - `mov` and `add`. `mov` loads our first integer into the EAX register and `add` performs the operation of adding 20 to the value in EAX.

This direct correspondence doesn't always exist. Real-world code is much more complex and doesn't always translate directly since compilers apply optimizations, high-level languages have abstractions that don't map directly onto assembly, and real-world assembly code takes advantage of hardware features such as pipelining and cache memory. 

> **Check Your Understanding**: What is the significance of the x86 ISA?
> <details><summary>Click Here for the Answer</summary> x86 ISA is a dominant ISA in computer systems, commonly used in personal computers and many servers due to its continual expansion to address contemporary computing needs. </details>
