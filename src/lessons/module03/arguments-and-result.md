# Arguments and Result

In x86-64 assembly, the function prologue and epilogue are used to manage the stack frame for a function call, particularly when arguments are being passed and values are being returned. Here's an overview:

## Setting up the stack frame (Prologue)

1. **Push the base pointer onto the stack** to save the previous base pointer value.

   ```asm
   push rbp
   ```

2. **Move the stack pointer into the base pointer** to set up a new base frame.

   ```asm
   mov rbp, rsp
   ```

3. **Allocate space on the stack for local variables** by moving the stack pointer.

   ```asm
   sub rsp, <size>
   ```

   `<size>` represents the number of bytes needed for local variables.

## Cleaning up the stack frame (Epilogue)

1. **Move the base pointer back into the stack pointer** to deallocate local variables.

   ```asm
   mov rsp, rbp
   ```

2. **Pop the old base pointer off the stack** to restore the previous base pointer value.

   ```asm
   pop rbp
   ```

3. **Return from the function** using the `ret` instruction.

   ```asm
   ret
   ```

> Note: The `leave` instruction is a shorthand for the `mov` and `pop` operations in (in the epilogue) to clean up the stack frame. Essentially, `leave` resets the stack pointer and base pointer to their state before the function call.

These steps ensure that each function has its own stack frame, which is essential for local variable management and for the return address to be properly restored when the function completes. Remember that the calling convention may require you to save and restore other registers as well.

## Passing Arguments to Functions

Arguments can be passed to functions in a couple of ways:

1. Register usage for arguments - In many calling conventions, the first few arguments are passed in registers, which is faster than using the stack. The specific registers used can vary depending on the architecture (e.g., EAX, EDX, ECX on x86; RDI, RSI, RDX, RCX, R8, R9 on x86-64).
2. Stack usage for additional arguments - If there are more arguments than there are registers available for argument passing, or if the calling convention dictates, additional arguments are passed on the stack.  The stack is also used to pass arguments that are larger than the size of a register.

So, with this information in mind, let's look at an example of a C function call that takes just a few simple arguments:

```c
#include <stdio.h>

// Function declaration
void greet(char *name, int age);

int main() {
    // Function call with arguments
    greet("Alice", 30);
    
    return 0;
}

// Function definition
void greet(char *name, int age) {
    printf("Hello, %s! You are %d years old.\n", name, age);
}
```

In this example, the function `greet` is declared and defined to take two arguments: a string `name` and an integer `age`. The `main` function then calls `greet` with the arguments `"Alice"` and `30`. When you run this program, it will output: `Hello, Alice! You are 30 years old.`

Let's look at it as assembly:

```asm
section .rodata
helloString db "Hello, %s! You are %d years old.", 10, 0 ; String with a newline and null terminator

section .text
global main
extern printf

; greet function
greet:
    push rbp
    mov rbp, rsp
    sub rsp, 16           ; Allocate space for local variables if needed
    mov rdi, [rbp+16]     ; First argument (char *name)
    mov rsi, [rbp+24]     ; Second argument (int age)
    mov rdx, helloString  ; Address of the format string
    mov rax, 0            ; No vector registers used for floating point
    call printf           ; Call printf function
    leave
    ret

; main function
main:
    push rbp
    mov rbp, rsp
    sub rsp, 16           ; Allocate space for local variables if needed
    mov rdi, name         ; Address of the name string
    mov rsi, 30           ; Age
    call greet            ; Call greet function
    mov eax, 0            ; Return 0
    leave
    ret

section .data
name db "Alice", 0       ; Null-terminated string "Alice"
```

In this example, the `greet` function takes two arguments:

1. A pointer to a character array (the name string)
2. An integer (the age)

Here's how the registers are used in the `greet` function call:

- `rdi` is used to pass the first argument, which is the pointer to the string `"Alice"`.
- `rsi` is used to pass the second argument, which is the integer `30`.

When calling the `printf` function from within `greet`, the arguments are as follows:

- `rdi` is used for the format string.
- `rsi` is reused to pass the first variable argument, which is the name string.
- `rdx` is used to pass the second variable argument, which is the age integer.
- `rax` is set to 0 because `printf` is a variadic function, and `rax` is used to indicate the number of vector registers used; in this case, none are used.

The `printf` function then uses these register values to access the arguments and print the formatted string to the standard output. 🖨️🔢

## Return Values from Functions

Values can be returned from a function in a couple of different ways:

1. **Return values in registers**: For small return values, typically those that are the size of a register or smaller, most calling conventions use registers to return values.  On a 64-bit system, the `rax` register is commonly used. Returning values in registers is fast because it avoids the overhead of memory access. 🚀

2. **Handling larger return values**: When a function needs to return a value larger than the size of a register, such as a large struct or an array, the typical approach is to pass a pointer to a memory space allocated by the caller, where the function can write the return value. This technique is known as passing the return value by reference.  The function signature might require the caller to provide a pointer to the space where the return value should be stored. This approach can also be used to return multiple values from a function by passing multiple pointers for each value that needs to be returned.

Here's an example of a function returning a value.

```c
int add(int a, int b) {
    return a + b;
}

int main() {
    int result = add(3, 4);
    return result;
}
```

Now, let's look at how this might be translated into assembly:

```asm
; Function: add
; Adds two integers and returns the result
add:
    mov eax, edi        ; Move first argument (a) into eax
    add eax, esi        ; Add second argument (b) to eax
    ret                 ; Return with result in eax

; Function: main
; Calls add and returns its result
main:
    push rbp            ; Save base pointer
    mov rbp, rsp        ; Set up new base pointer

    mov edi, 3          ; Set first argument (3) for add function
    mov esi, 4          ; Set second argument (4) for add function
    call add            ; Call add function; result will be in eax

    mov ebx, eax        ; Store the result of add in ebx (or another register/memory location)

    mov eax, ebx        ; Move the result into eax to be the return value of main
    pop rbp             ; Restore base pointer
    ret                 ; Return with result in eax
```

In this Assembly code the `main` function sets up the stack frame by pushing the base pointer (`rbp`) onto the stack and then copying the stack pointer (`rsp`) to `rbp`. It prepares the arguments for the `add` function by moving the values `3` and `4` into the `edi` and `esi` registers, respectively. The `call` instruction is used to call the `add` function. After the call, the result is in the `eax` register. The result is then moved from `eax` to `ebx` for temporary storage (this step is not strictly necessary if you're immediately returning the value). Finally, the result is moved back into `eax` to set up the return value for `main`, the stack frame is cleaned up, and the `ret` instruction is used to return from `main`.

> **Check Your Understanding**: Implement a simple C program that uses recursion to calculate factorial (e.g., 6! = 6 * 5 * 4 * 3 * 2 * 1).  Use your compiler or https://gcc.godbolt.org/ to generate the assembly.  Study it and trace through the instructions that are used for modifying stack frame, for passing arguments, and for returning values.

This concludes the explanation for how the computer is able to provide the low-level support for function calls.  In the next section, we will dive into a couple of more complex data structures that we commonly use in C: arrays and structures (aka `structs`).