# Introduction to Using GDB for Tracing C Binaries

So you have just spent a bunch of time reading all about how CPUs operate, from data sizes to instruction decoding, to memory addressing, and on.  You may be feeling a bit overwhelmed at this point.  Don't worry though.  We could spend several semesters understand the intricacies of these topics.  The important thing at this point is being aware of these items, the relationships between them, and beginning to build a basic understanding.  

A great way to gain some real-world experience with these topics and with the x86 architecture, while building the valuable skill is to use a debugger like GDB to interact with a compiled program, see its assembly code, its binary representation, and how it manipulates data in memory during execution.

This is a high-level introduction to GDB, the GNU Debugger.  You will use this tool extensively in your next assignment.  We don't give a comprehensive introduction here, though the assignment does refer you to a number of other resources that will be useful when completing the assignment.

## What is GDB?

GDB, or the GNU Debugger, is a powerful tool for debugging programs, particularly those written in C and C++. It allows you to see what is going on 'inside' a program while it executes or what the program was doing at the moment it crashed.

## Why GDB?

As you've learned about CPUs, registers, memory addressing, and x86 instructions, GDB provides a hands-on way to see these concepts in action. It allows you to:

- **Step through a program**: You can execute your program one instruction at a time, observe the changes in registers and memory, and understand how instructions affect the state of the program.
- **Set breakpoints**: You can pause your program at specific points and examine the state of variables, registers, and memory.
- **Inspect memory and registers**: Directly view and modify the contents of registers or memory addresses, which is crucial for understanding how operations like arithmetic and logical operations are carried out by the CPU.

## Getting Started with GDB

1. **Compiling Your Program for GDB**: To use GDB, you first need to compile your C program with debugging information included. This is done using the `-g` flag with `gcc`:

   ```bash
   gcc -g myprogram.c -o myprogram
   ```

2. **Starting GDB**: Run GDB with your compiled program:

   ```bash
   gdb ./myprogram
   ```

3. **Setting Breakpoints**: Before running your program, you might want to set breakpoints. A breakpoint pauses the execution of your program so you can examine the state. For example, to set a breakpoint at function `myFunction`, use:

   ```bash
   break myFunction
   ```

4. **Running Your Program**: Start your program in GDB using the `run` command. If you have set breakpoints, the program will stop at these points.

5. **Stepping Through the Program**:
   - `step` or `s`: Executes the next line of code, stepping into any function calls.
   - `next` or `n`: Similar to `step`, but it steps over function calls without going into them.

6. **Inspecting State**:
   - `print varname`: Prints the current value of a variable `varname`.
   - `info registers`: Displays the current value of all registers.
   - `x/address`: Examine memory at a certain address.

7. **Continuing Execution**: After pausing at a breakpoint, use `continue` or `c` to resume execution until the next breakpoint.

8. **Quitting GDB**: Use `quit` or `q` to exit GDB.

## Example Session

Here's a quick example of a GDB session:

```bash
(gdb) break main
Breakpoint 1 at 0x...: file myprogram.c, line 10.
(gdb) run
Starting program: /path/to/myprogram

Breakpoint 1, main () at myprogram.c:10
10      int x = 5;
(gdb) next
11      int y = x + 2;
(gdb) print x
$1 = 5
(gdb) continue
Continuing.
Program exited normally.
```

## Tips for Effective Debugging

- **Start Small**: When learning GDB, start with small programs to understand how basic commands work.
- **Use Help**: GDB has extensive help documentation. Simply type `help` or `help <command>` for guidance.
- **Experiment**: Don't be afraid to test different commands and see their effects on your program's execution.

## Conclusion

GDB is a powerful tool in understanding how your code interacts with the hardware, especially the CPU, memory, and registers. By using GDB, you can demystify many aspects of program execution and gain a deeper understanding of computer architecture.
