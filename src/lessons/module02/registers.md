# Registers and their use in Programming

## Definition and Purpose of Registers

On the most elementary level, registers are small storage areas in the CPU where data is temporarily held for immediate processing. At any moment, these small storage areas contain the most relevant and significant information for a current instruction. The purpose of registers is to provide a high-speed cache for the arithmetic and logical units, the parts of the CPU that perform operations on data. 

> **Check Your Understanding**: What is the purpose of registers in a CPU?
> <details><summary>Click Here for the Answer</summary> Registers provide a high-speed cache for the arithmetic and logical units of the CPU to perform operations on data. They temporarily store the most relevant information for the current instruction being executed. </details>

## Types of Registers

There are several types of registers depending on the CPU, serving different purposes.

For the x86 architecture, these include (https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture):

1. **Accumulator Registers (AX):** These are used for arithmetic calculations. For instance, in x86 assembly language, the `acc` command utilizes the accumulator register for performing operations. The accumulator register stores the results of arithmetic and logical operations (such as addition or subtraction).

2. **Data Registers (DX):** Data registers are utilized for temporary storage of data. They are typically involved in data manipulation and holding intermediate results.

3. **Counter Register (CX):** It is used in loop instruction to store the loop count.

4. **Base Register (BX):** It behaves as a pointer to data in data segment.

5. **Stack Pointer (SP):** It points to a location in the stack segment.

6. **Stack Base Pointer (BP):** Used to point at the base of the stack.

7. **Source Index (SI) and Destination Index (DI):** SI is used as a source data address in string manipulation and DI as a destination data address.

8. **Instruction Pointer (IP):** It keeps track of where the CPU is in its sequence of tasks.

In the realm of x86 architecture, these registers have evolved from 8-bit to 16-bit (AX, BX, CX, DX), later to 32-bit (EAX, EBX, ECX, EDX), and currently to 64-bit versions (RAX, RBX, RCX, RDX).

General-purpose registers are key to operations like arithmetic, data manipulation, and address calculation. The x86 architecture presents eight general-purpose registers denoted by EAX, EBX, ECX, EDX, ESI, EDI, EBP, and ESP.

Special-purpose registers oversee specific computer operations—examples include the Program Counter (PC), Stack Pointer (SP), and Status Register (SR).  

_Refer to [this wiki on CPU Registers](https://en.wikipedia.org/wiki/Processor_register) to explore more on the topic_

## Registers in x86 Instruction Set Architecture (ISA)

Here's an illustrative example of how registers are used in x86 assembly language:

```assembly
section .text
   global _start     ;must be declared for using gcc
_start:             
   mov eax, 5       
   add eax, 3       
```

In the above example, the EAX register is utilized to store and perform arithmetic operation on values. Initially, the value `5` is moved into EAX register. Then, `3` is added to the value currently in EAX register, making the final value in EAX as `8`.

Watch this video for a deeper understanding of the use of registers in x86.

<div class="embed"> <iframe width="560" height="315" src="https://www.youtube.com/embed/pVQNkCVs_Uk?si=5Dgv0JLuU_nN_cyi" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe> </div>

> **Check Your Understanding**: Why do you think the EAX register is often used in programming?
> <details><summary>Click Here for the Answer</summary> EAX is often referred to as an "accumulator register," as it is frequently used for arithmetic operations. Its value can easily be modified by addition, subtraction, or other operations, making it a versatile choice for programmers. </details>
