# Arithmetic Operations

Arithmetic operations form the building blocks of most programmatic tasks. They are behind the computing of coordinates for graphics, calculating sum totals, adjusting sound volumes, and a myriad of other tasks. Broadly speaking, arithmetic operations allow manipulation and processing of data. In this section, we will delve into the mechanics of performing basic arithmetic operations using Machine Instructions and working with arithmetic operations in x86.

## Addition and Subtraction

In x86 assembly language, the `ADD` and `SUB` instructions are used to perform addition and subtraction respectively. C provides the common symbols `+` and `-` for these operations.

Here is an example: 

```C
int sum = 5 + 3;
int diff = 5 - 3;
```

```assembly
MOV EAX, 5
ADD EAX, 3  ; sum stored in EAX
MOV EBX, 5
SUB EBX, 3  ; difference stored in EBX
```

## Multiplication and Division

Multiplication is accomplished using the `MUL` instruction and division uses `DIV`. In C, these operations are represented by `*` and `/` respectively. Here's a simple example:

```C
float product = 6 * 2;
float quotient = 6 / 2;
```

```assembly
MOV EAX, 6
IMUL EAX, 2  ; product stored in EAX
MOV EBX, 6
IDIV EBX, 2  ; quotient stored in EBX
```

> **Check Your Understanding**: If a program requires the multiplication of two numbers, which instruction can you use in x86 assembly code?
> <details><summary>Click Here for the Answer</summary> The `MUL` instruction is used to multiply two numbers in x86 assembly. </details>

## Modulo

Modulo operation, also referred to as modulus, is closely tied with division. It finds the remainder or signed remainder of a division, of one number by another (called the modulus of the operation).

In programming realms, especially in conditions like looping over a circular buffer or implementing some hash functions, the modulo operation plays a vital role.

Unlike other processors, x86 doesn't have a specific instruction for modulo. It is usually calculated from the remainder part after executing the `DIV` instruction.

Here's an example in C:

```C
int dividend = 15;
int divisor = 10;
int quotient = dividend / divisor;    // Division
int remainder = dividend % divisor;   // Modulo
```

In this case, the quotient would be `1`, and the remainder is `5` which is the result of the modulo operation.

## Overflow

In the realm of computer arithmetic operations, particularly those that deal with signed and unsigned integers, special situations arise when implementing addition, subtraction, multiplication, and division operations. These situations, often referred to as "overflows", can potentially cause unexpected and undesired behavior in a system. 

When we perform arithmetic operations, the state of the result determines the flag settings. Overflow is a condition that occurs when the result of an operation exceeds the number range that can be represented by the permitted number of bits. 

### Overflow Flags

When it comes to handling overflows, the processor leverages a dedicated bit, known as the Overflow Flag (OF), to indicate the occurrence of an overflow during an arithmetic operation [(Michael, 2016)](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html). 

For instance, consider a signed 8-bit integer variable (with the range of -128 to 127) and the operation `100 + 50`. The result, being `150`, exceeds the maximum positive value `127` and thus we say an overflow has occurred. The overflow flag would be set in this case.

### Flag Usage in Instructions

You can use instructions including `JO (Jump if Overflow)` and `JNO (Jump if Not Overflow)` for manipulating program control flow based on the state of the overflow flag. These instructions are useful for implementing effective error handling mechanisms in your code.

Let's consider this example, using x86 assembly language:

```assembly
mov eax, 0x7FFFFFFF  ; Move maximum 32-bit signed integer to EAX
add eax, 1            ; Add 1 to EAX
jo  overflow_occurred ; Jump to overflow_occurred if Overflow Flag is set
jmp operation_success ; Jump to operation_success if Overflow Flag is not set

overflow_occurred:
; Implement error handling here

operation_success:
; Continue with normal operation
```

In the code above, the `add` instruction causes an overflow, making `JO` instruction to pass control to 'overflow_occurred' label.

## Conclusion

Let’s conclude with a final example:

```asm
section .data
a db 9
b db 4

section .text
global _start
_start:

mov al, [a]
add al, [b]

mov al, [a]
sub al, [b]

mov al, [a]
imul al, [b]

mov al, [a]
idiv byte [b]

mov al, [a]
idiv byte [b]
mov ah, 0
```

> **Check Your Understanding**: What is the purpose of the `mov ah, 0` instruction in the example above?
> <details><summary>Click Here for the Answer</summary> The `mov ah, 0` instruction is used to clear the upper portion of the accumulator so that the next division operation doesn't consider it as part of the dividend. </details>