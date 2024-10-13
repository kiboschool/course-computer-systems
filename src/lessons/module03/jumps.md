# Jumps

Jumps are used to control flow in assembly language, allowing the execution sequence to be altered based on certain conditions or decisions. In particular, jumps are instructions that modify the program counter (PC) (i.e., instruction pointer (IP)) to cause the CPU to execute a different instruction sequence. This is necessary for implementing decision-making capabilities, loops, and branching in programs.

There are two main types of jump instructions in x86-64:

- **Unconditional Jumps:** These jumps always cause the control flow to divert to the specified location. They are used for structures like function calls and infinite loops. The `jmp` instruction is an example of an unconditional jump.

- **Conditional Jumps:** These jumps divert control flow only if a specific condition is met, based on the flags set by previous instructions. They are used for if-else structures, for-loops, while-loops, and more. Examples include `je` (jump if equal), `jne` (jump if not equal), `jg` (jump if greater), etc.

More details and examples follow.

## Unconditional Jumps

### The `jmp` Instruction

The `jmp` instruction in x86 assembly is used to perform an unconditional jump to a specified label or memory address, altering the flow of execution.

The syntax for the `jmp` instruction is straightforward:

```assembly
jmp dest
```

Where `dest` is the label or memory address to jump to.

In C, this would correlate to a `goto` statement.  `goto` statements allow jumping to another position in the program based on a label.  Please note that use of this programming language construct is *very widely* considered to be poor practice.  However, it is instructional in our upcomding exploration if 

For example:

```c
void example_function() {
    goto label;
    // ... some code ...

label:
    // Code to jump to
}
```

would be represented as assembly similarly to the following:

```assembly
example_function:
    jmp label
    ; ... some code ...

label:
    ; Code to jump to
    ret
```

### Conditional Jumps

Conditional jumps are used to alter the flow of execution based on the status of flags set by comparison instructions like `CMP` and `TEST`. Here's a brief overview of some common conditional jump instructions and how they're typically used:


| Instruction | Description | Example |
|-------------|-------------|---------|
| `JE`/`JZ`   | Jump if Equal/Jump if Zero | `cmp eax, ebx` <br> `je equal_label` |
| `JNE`/`JNZ` | Jump if Not Equal/Jump if Not Zero | `cmp eax, ebx`<br> `jne not_equal_label` |
| `JG`/`JNLE` | Jump if Greater/Jump if Not Less or Equal | `cmp eax, ebx`<br> `jg greater_label` |
| `JL`/`JNGE` | Jump if Less/Jump if Not Greater or Equal | `cmp eax, ebx`<br> `jl less_label` |
| `JA`        | Jump if Above (unsigned) | `cmp eax, ebx`<br> `ja above_label` |
| `JB`        | Jump if Below (unsigned) | `cmp eax, ebx`<br> `jb below_label` |
| `JO`        | Jump if Overflow | `add eax, ebx`<br> `jo overflow_label` |
| `JS`        | Jump if Sign (negative result) | `sub eax, ebx`<br> `js negative_label` |

As you can see in all of the above examples, `cmp` is used to compare two operands before performing the jump.  This instruction is essentially equivalent to a `subx` instruction, which sets the flags accordingly, without changing the operands.  

We now have all the building blocks that we need to be able to represent higher-level `if` statements.  

## Representing `if` Statements

Let's start with the simple example of a basic `if` statement:

```c
if (a < b) {
    // code to execute if condition is true
}
```

This can alternatively be represented in C using `goto` statements as shown below.  

```c
if (a >= b) goto skip;
// code to execute if condition is true
skip:
```

The above representation very directly translates to assembly as follows:

```assembly
; Assume 'a' is in EAX and 'b' is in EBX
cmp eax, ebx
jge skip_if ; Jump if greater or equal, meaning if NOT a < b
; Code to execute if a is less than b
skip_if:
```

### Representing `if...else` Statements

We can follow the same procedure for a slightly more complex `if...else` statement.  Consider this example:

```c
if (a > b) {
    // code to execute if a is greater than b
} else {
    // code to execute if a is not greater than b
}
```

Once again, we will manipulate the code slightly to represent the same behavior using `goto` statements.  

```c
if (a <= b) goto else_part;
  // code to execute if a is greater than b
  goto end_if;
else_part:
  // code to execute if a is not greater than b
end_if:
```

Finally, as we did before, we can very directly convert the above C program to assembly code as follows:

```assembly
; Assume 'a' is in EAX and 'b' is in EBX
cmp eax, ebx
jle else_part ; Jump if less or equal, to the else part
; Code to execute if a is greater than b
jmp end_if
else_part:
; Code to execute if a is not greater than b
end_if:
```

Make sure that you read through the above examples and understand the relationship between each version of the example.  Remember that in assembly, the actual condition checking (e.g., comparing two values) would need to be done before the `test` or `cmp` instruction, and the result of that comparison would determine the jump.

> **Check Your Understanding**: There are other alternatives to how an `if...else` statement can be converted to an equivalent version using `goto` statements.  Come up with one alternative and then re-write it as assembly.
> <details><summary>Click Here for the Answer</summary>
> 
> C Program:
> ```c
> if (a > b) goto then_part;
>   // code to execute if a is not greater than b
>   goto end_if;
> then_part:
>   // code to execute if a is greater than b
> end_if:
> ```
> 
> Assembly Program:
> ```assembly
> ; Assume 'a' is in EAX and 'b' is in EBX
> cmp eax, ebx
> jg then_part ; Jump if greater than, to the then part
> ; Code to execute if a is not greater than b
> jmp end_if
> then_part:
> ; Code to execute if a is greater than b
> end_if:
> ```
> </details>
