# Switch Statements

Switch statements in C provide a way to execute different parts of code based on the value of a variable. They are particularly useful when you have multiple conditions that depend on a single variable.

## Syntax

The syntax and general structure f a `switch` statement is below.  Note that if a `break` is omitted for any given `case`, control will flow into the next case.

```c
switch (expression) {
    case constant1:
        // code to be executed if expression equals constant1
        break;
    case constant2:
        // code to be executed if expression equals constant2
        break;
    // more cases...
    default:
        // code to be executed if expression doesn't match any case
}
```

`switch` statements are commonly used when you have a variable that can take one out of a small set of possible values and you want to execute different code for each value.  They are common used to replace multiple `if-else` statements to make  code cleaner and more readable.

The above `switch` statement is equivalently represented as a series of `if-else` statements:

```c
if (expression == constant1) {
    // code to be executed if expression equals constant1
} else if (expression == constant2) {
    // code to be executed if expression equals constant2
// more else-if clauses...
} else {
    // code to be executed if expression doesn't match any case
}
```

This structure allows you to execute different blocks of code based on the value of `expression`, similar to how the `switch` statement operates. Remember that `if-else` chains can be more flexible, allowing for a range of conditions beyond just equality checks.

## Translating to Assembly

Knowing that a `switch` statement can simply be re-written as an `if` statement, we might assume that it is translated into assembly using the following steps:

1. **Comparison**: The value of the `switch` variable is compared against the case values.
2. **Conditional Jumps**: Based on the comparison result, the assembly code will include conditional jump instructions to jump to the code block corresponding to the matched case.
3. **Default Case**: If none of the case values match, the assembly code will jump to the default case block if it exists.

Here it is in assembly:

```assembly
; Assume the switch variable is in RAX
cmp rax, 1
je case1
cmp rax, 2
je case2
jmp default_case

case1:
; Code for case 1
jmp end_switch

case2:
; Code for case 2
jmp end_switch

default_case:
; Code for default case

end_switch:
; Continue with the rest of the program
```

## Jump Tables

When a compiler encounters a large switch statement, it may optimize it by creating a jump table, which is essentially an array of pointers to the code for each case. This allows for constant-time dispatch regardless of the number of cases, as opposed to a series of comparisons that would result in linear time complexity. Here's how it works:

1. **Index Calculation**: The value of the switch variable is used to calculate an index into the jump table.
2. **Bounds Checking**: If necessary, the code checks to ensure the index is within the bounds of the jump table to prevent out-of-bounds memory access.
3. **Indirect Jump**: The assembly code performs an indirect jump to the address obtained from the jump table, which corresponds to the code block for the matched case.

This approach is much faster than a series of comparisons and jumps because it turns the `switch` statement into a constant-time operation (O(1)), rather than a linear-time operation (O(n)) that would result from a long series of if-else comparisons.

Here's a simplified example of what the assembly code might look like with a jump table:

```assembly
; Assume 'value' is the variable being switched on and is already in a register
; jump_table is an array of pointers to the code for each case

    mov eax, [value]          ; Move the value into the eax register
    cmp eax, MAX_CASES        ; Compare the value with the maximum number of cases
    ja  default_case          ; If the value is above the max, jump to the default case
    jmp [jump_table + eax*4]  ; Jump to the address in the jump table corresponding to the value

section .data
jump_table:
    dd case0
    dd case1
    dd case2
    ; ... more cases

section .text
case0:
    ; Code for case 0
    jmp end_switch

case1:
    ; Code for case 1
    jmp end_switch

case2:
    ; Code for case 2
    jmp end_switch

; ... more cases

default_case:
    ; Code for the default case

end_switch:
```

In this example, `eax` holds the switch variable. The `cmp` and `ja` instructions check if the value is within the valid range of cases. If it is, the program uses the `jmp` instruction to jump to the address in the jump table at the index corresponding to the value (`eax*4` because each pointer is 4 bytes on a 32-bit system). Each case ends with a jump to `end_switch` to avoid falling through to the next case.

The jump table mechanism is efficient because it turns a potentially long series of conditional checks into a single indexed memory access followed by an unconditional jump, which is much faster on modern processors.

The use of a jump table is probably a bit confusing.  Here is a useful video providing additional explanation:

<div class="embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/1r6oflIjC6Q?si=rjg9T7zBFO7XbZB7" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

> **Check Your Understanding**: Given a C switch statement with cases ranging from 1 to 5, describe how a compiler might use a jump table in assembly to handle the case where the switch variable is 3. Include what happens if the switch variable is outside the range of defined cases.
> <details><summary>Click Here for the Answer</summary> In assembly, when the switch variable is 3, the compiler would first check if the variable is within the valid range (1 to 5). If it is, the compiler calculates the offset by subtracting the lowest case value (1 in this scenario) from the switch variable (3 - 1 = 2) and then uses this offset to index into the jump table. The indexed position in the jump table contains the memory address of the code block for case 3, and the assembly code would use an indirect jump to that address to execute the case.
>
> If the switch variable is outside the range of defined cases (less than 1 or greater than 5), the assembly code would jump to the default case’s code block. This is typically handled by a comparison and a conditional jump instruction that redirects the flow to the default label if the variable does not match any case label.</details>