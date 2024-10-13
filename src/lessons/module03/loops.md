# Loops

Another major category of higher-level programming constructs that allow for controlling the flow of the program are loops. Let's understand how these get translated to assembly code as well.  For each of the examples below, spend a few minutes ensuring that you understanding the translation.  Note that just like the examples with the `if` statements that we just covered, it is probably helpful to first think about how the C program might first be re-written to use `goto` statements.  

## `while` loop

C code example:
```c
int i = 0;
while (i < 10) {
    printf("%d\n", i);
    i++;
}
```

x86-64 assembly translation:

```assembly
    mov ecx, 0          ; Initialize counter i to 0
start_while:
    cmp ecx, 10         ; Compare i with 10
    jge end_while       ; If i >= 10, jump to end_while
    ; Body of the loop
    ; ... (code to print ecx)
    add ecx, 1          ; Increment i
    jmp start_while     ; Jump back to the start of the loop
end_while:
```

## `do-while` loop

C code example:

```c
int i = 0;
do {
    printf("%d\n", i);
    i++;
} while (i < 10);
```

x86-64 assembly translation:
  
```assembly
    mov ecx, 0          ; Initialize counter i to 0
start_do_while:
    ; Body of the loop
    ; ... (code to print ecx)
    add ecx, 1          ; Increment i
    cmp ecx, 10         ; Compare i with 10
    jl start_do_while   ; If i < 10, jump back to the start of the loop
```

## `for` loop

C code example:

```c
for (int i = 0; i < 10; i++) {
    printf("%d\n", i);
}
```

x86-64 assembly translation:

```assembly
    mov ecx, 0          ; Initialize counter i to 0
start_for:
    cmp ecx, 10         ; Compare i with 10
    jge end_for         ; If i >= 10, jump to end_for
    ; Body of the loop
    ; ... (code to print ecx)
    add ecx, 1          ; Increment i
    jmp start_for       ; Jump back to the start of the loop
end_for:
```

In each of these examples, the C code is a high-level representation of the loop, while the x86-64 assembly is a lower-level implementation that uses jump instructions to create the loop structure. 

## Complex Control Flow

Nesting of control flow statements like decisions and loops are a common. Let's explore an example.

Here's a simple C nested loop example that iterates through a 2D array:

```c
#include <stdio.h>

int main() {
    int arr[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };

    for (int i = 0; i < 3; i++) {         // Outer loop
        for (int j = 0; j < 3; j++) {     // Inner loop
            printf("%d ", arr[i][j]);
        }
        printf("\n");
    }

    return 0;
}
```

Here is a simplified version of the assembly version of the above program.

```assembly
section .data
    arr db 1, 2, 3, 4, 5, 6, 7, 8, 9  ; Define a 3x3 matrix

section .text
    global _start

_start:
    mov esi, 0          ; Outer loop counter (i)
outer_loop:
    cmp esi, 3          ; Compare outer loop counter with 3
    jge end_outer_loop  ; If i >= 3, jump to the end of the outer loop

    mov edi, 0          ; Inner loop counter (j)
inner_loop:
    cmp edi, 3          ; Compare inner loop counter with 3
    jge end_inner_loop  ; If j >= 3, jump to the end of the inner loop

    ; Calculate the address of arr[i][j]
    mov eax, esi        ; Copy outer loop counter (i) to eax
    imul eax, 3         ; Multiply by the number of columns to get the row offset
    add eax, edi        ; Add inner loop counter (j) to get the column offset
    movzx ebx, byte [arr + eax] ; Move the value at arr[i][j] into ebx, zero-extend to 32-bit

    ; Here you would typically call a print function to output ebx

    inc edi             ; Increment inner loop counter (j)
    jmp inner_loop      ; Jump back to the start of the inner loop

end_inner_loop:
    ; Newline or other row separation could be printed here

    inc esi             ; Increment outer loop counter (i)
    jmp outer_loop      ; Jump back to the start of the outer loop

end_outer_loop:
    ; Exit the program or perform other end-of-program tasks
```

Note that we can write arbitrarily complex programs using various forms of the `jmp` instruction.  Though, as you can see from this example, they become much more difficult to read as the complexity increases.  This is why the constructs that are available in higher-level languages are so valuable.  Assembly language is much lower level and more complex than high-level languages like C, so translating nested loops into assembly requires a good understanding of the target architecture's instruction set and conventions.

> **Check Your Understanding**: We explored one way that we could convert a basic `while` loop to assembly.  Can you come up with another?  It may help to first think in terms of `goto` statements.
> <details><summary>Click Here for the Answer</summary>
> 
> C Program:
> ```c
> while (test) {
>     // body
> }
> ```
> 
> C version 1 using `goto` statements:
> ```c
> loop:
>   if (!test)
>     goto done;
>   // body
>   goto loop;
> done:
> ```
> 
> C version 2 using `goto` statements:
> ```c
>   if (!test)
>     goto done;
> loop:
>   // body
>   if (test)
>     goto loop;
> done:
> ```
>
> Translation to assembly of the above is straight-forward.
> </details>

