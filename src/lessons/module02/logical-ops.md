# Logical Operations

When a programmer is scripting code or an assembler is translating assembly language into machine instructions, they often count on basic logical operations to guide the computer's behavior. These operations include `AND`, `OR`, `XOR` (exclusive OR), `NOT`, and `shift` (bitwise shift). Each of these operations manipulates the bits within the byte or word length of the data being processed - thereby altering the values in register or memory spaces.

## AND Operation

Let's start with the AND operation. In a binary context, the AND operation outputs 1 if and only if both input bits are 1. Otherwise, it outputs 0. Here's an illustrative example using x86 assembly language:

```asm
mov eax, 5   ; binary representation of 5: 101
and eax, 3   ; binary representation of 3: 011
; result in EAX: 001 (decimal 1)
```

In the above code, The `and` operation in x86 acts like a binary 'AND' on the individual bits of the operands. The result is stored in the first operand.

> **Check Your Understanding**: What will be the result of the following operation?
>
> ```asm
> mov eax, 6   ; binary representation of 6: 110
> and eax, 5   ; binary representation of 5: 101
> ```
>
> <details><summary>Click Here for the Answer</summary> The result is `100` (decimal 4), as this matches the places where both operands have 1s.
</details>

## OR Operation

Next, we have the OR operation. The OR operation outputs 1 if at least one of the input bits is 1, and outputs 0 only if both input bits are 0. Let's see how this operation is run in x86 assembly:

```asm
mov ebx, 5   ; binary representation of 5: 101
or ebx, 3   ; binary representation of 3: 011
; result in EBX: 111 (decimal 7)
```

The `or` operation behaves like a binary 'OR' on the individual bits of the operands, and the result is stored back in the first operand.

> **Check Your Understanding**: What will you get as a result for the following operation?
>
> ```asm
> mov ebx, 2   ; binary representation of 2: 010
> or ebx, 5   ; binary representation of 5: 101
> ```
>
> <details><summary>Click Here for the Answer</summary> The result will be `111` (decimal 7), as it includes all the locations where either operand has a bit set to 1. </details>

## NOT Operation

Next, we have the NOT operation. This operation simply inverts the input bit: 1 changes to 0, and vice versa. Let's see an example in C:

```asm
mov ebx, 2  ; binary representation of 2: 010
not ebx     ; binary represention of 5: 101
```

The `~` operator performs a binary 'NOT' operation, flipping each bit to its inverse.[^3^]

## Shift operations

Shift operations are an important category of bit-level operations, utilized in a wide range of applications, from arithmetic to data packing and unpacking, to name just a few. Two principal categories of shift operations exist - logical shifts and arithmetic shifts.

Logical shifts fill the vacant bit positions created by the shift with zeroes, irrespective of the sign bit. On the other hand, arithmetic shifts fill the vacant bit positions with a copy of the sign bit, preserving the sign of signed numbers.

Consider the sequence of bits representing the number 8: '00001000' in an 8-bit representation. A logical right shift by one position, would result in '00000100', representing the number 4, while a left shift would result in '00010000', representing the number 16. 

In C programming, the shift operations are represented by the symbols `>>` for right shift and `<<` for left shift. In x86 assembly language, `shr` and `shl` instructions are used for logical shift right and left, respectively, while `sar` and `sal` are used for arithmetic shift right and left, respectively.

```c
unsigned int x = 8; // represented by '00001000'
unsigned int result_right = x >> 1; // result_right is now 4, '00000100'
unsigned int result_left = x << 1; // result_left is now 16, '00010000'
```

## Rotate operations

In addition to the shift operations, there are also rotate operations, which are bit-level operations that shift bits to the left or right, with the endmost bit wrapping around to the position vacated at the other end. 

In C programming, these operations are not directly available, and one has to compose them out of shift and logical operations. However, in x86 assembly language, `ror` and `rol` instructions are used to rotate right and left, respectively.

```asm
mov eax, 8 ; eax now holds '00001000'
ror eax, 1 ; eax now holds '10000000'
```

> **Check Your Understanding**: What would be the output of applying the NOT operation to an integer 5 in x86 assembly programming?
> <details><summary>Click Here for the Answer</summary> The binary representation of 5 is 0101. Applying the NOT operation inverts this representation to 1010, which equates to -6 in two's complement form. </details>
