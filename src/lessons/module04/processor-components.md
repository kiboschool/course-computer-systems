# Processor Components

## Processor Architecture

The main components of a computer system can be summarized using the following diagram showing four main subsystems: the central processing unit (CPU) made up by the arithmetic logic unit (ALU), the control unit (CU); memory; and input/output (I/O) interfaces.  You already know that memory stores instructions that the CPU will execute and data that our programs manipulate.  In the following discussion, we will focus on the workings of the CPU.

<div class="embed"><a href="https://commons.wikimedia.org/wiki/File:Von_Neumann_Architecture.svg#/media/File:Von_Neumann_Architecture.svg"><img src="https://upload.wikimedia.org/wikipedia/commons/e/e5/Von_Neumann_Architecture.svg" alt="Von Neumann Architecture.svg" height="295" width="510"></a><br>By <a href="//commons.wikimedia.org/w/index.php?title=User:Kapooht&amp;amp;action=edit&amp;amp;redlink=1" class="new" title="User:Kapooht (page does not exist)">Kapooht</a> - <span class="int-own-work" lang="en">Own work</span>, <a href="https://creativecommons.org/licenses/by-sa/3.0" title="Creative Commons Attribution-Share Alike 3.0">CC BY-SA 3.0</a>, <a href="https://commons.wikimedia.org/w/index.php?curid=25789639">Link</a></div>

In order to execute assembly instructions, they must first be in a form that the CPU can interpret, and as we know, CPUs operate on only 1s and 0s.  Therefore, the assembly code needs to be further manipulated into a numeric representation, ideally one that allows us to represent programs using a minimal amount of memory.

## Instruction Encoding

Earlier in the course, we briefly looked at this showing how assembly code could be equivalently represented as machine code.  We will explore that example in more detail.  

```asm
pushq %rbx
movq %rdx, %rbx 
call mult2 
movq %rax, (%rbx) 
popq %rbx 
ret
```

This assembly code can be equivalently represented as machine code.:

```asm
53 
48 89 d3 
e8 00 00 00 00 
48 89 03 
5b 
c3
```

If you compare the two programs, you can infer a general idea of what each of the hexadecimal values in the machine code represents. Let's break this down in detail (if you want to double-check the below, you can use the table at [http://ref.x86asm.net/](http://ref.x86asm.net/), though it is confusing):

1. `53`: This is a single-byte instruction. The opcode `53` represents `50 + r` where 50 corresponds to a `push` operation and register `rbx` is numerically register 3.

2. `48 89 d3`
   - `48`: Prefix indicating an operation involving 64-bit operands.
   - `89`: Opcode for the `mov` instruction (on a 16-, 32-, or 64-bit register).
   - `d3`: Here, `d3` (`1101 0011` in binary) breaks down as:
     - `11`: The first two bits (`11`) indicate that both operands are registers.
     - `010`: The next three bits (`010`) represent the source register (`rdx`).
     - `010`: The final three bits (`011`) represent the destination register (`rbx`).

3. `e8 00 00 00 00`
   - `e8`: Opcode for the `call` instruction.
   - `00 00 00 00`: This is the displacement for the `call` instruction, which is a relative address. In this case, `0x00000000` is a placeholder for the memory location of the first instruction for the `mult2` function.

4. `48 89 03`
   - `48`: Prefix indicating an operation involving 64-bit operands.
   - `89`: Opcode for the `mov` instruction (on a 16-, 32-, or 64-bit register).
   - `03`: Here, `03` (`0000 0011` in binary) breaks down as:
     - `00`: The first two bits (`00`) indicate that the destination is a memory address.
     - `000`: The next three bits (`000`) represent the `rax` register as the source.
     - `011`: The final three bits (`011`) represent the `rbx` register as the base of the memory address.

5. `5b`: This is a single-byte instruction. The opcode `5b` represents `58 + r` where 58 corresponds to a `pop` operation and register `rbx` is numerically register 3 (58 + 3 = 5b in hexadecimal).

6. `c3`: This is a single-byte instruction with the opcode `c3` for the `ret` (return) command. It pops the return address off the stack and transfers control to that address.

As you can see, each byte or group of bytes in this sequence represents either an opcode (which specifies the operation to be performed), or operands/data (which specify the targets or sources of the operation, such as registers or memory addresses). The combination of opcodes and operands in this sequence of bytes defines the behavior of the CPU when executing this machine code--but how?  To understand that, let's start by revisiting the architecture of a processor.

## The Fetch-Execute Cycle

We also previously introduced the fetch-execute cycle, the process by which a computer executes instructions in a program. 

For convenience, here's the summarized overview of the steps involved in this cycle that we've previously studied:

1. **Fetch:**
   - The CPU fetches the instruction from the computer's memory. This is done by the control unit (CU) which uses the
     program counter (PC) to keep track of which instruction is next.
   - The instruction, stored as a binary code, is retrieved from the memory address indicated by the PC and placed into
     the Instruction Register (IR).
   - The PC is then incremented to point to the next instruction in the sequence, preparing it for the next fetch cycle.

2. **Decode:**
   - The fetched instruction in the IR is decoded by the CU. Decoding involves interpreting what the instruction is and
     what actions are required to execute it.
   - The CU translates the binary code into a set of signals that can be used to carry out the instruction. This often
     involves determining which parts of the instruction represent the operation code (opcode) and which represent the
     operand (the data to be processed).

3. **Execute:**
   - The execution of the instruction is carried out by the appropriate component of the CPU. This can involve various
     parts of the CPU, including the ALU, registers, and I/O controllers.
   - If the instruction involves arithmetic or logical operations, the ALU performs these operations on the operands.
   - If the instruction involves data transfer (e.g., loading data from memory), the necessary data paths within the CPU
     are enabled to move data to or from memory or I/O devices.
   - Some instructions may require interaction with input/output devices, changes to control registers, or alterations
     to the program counter (e.g., in the case of a jump instruction).

4. **Repeat:**
   - Once the execution of the instruction is complete, the CPU returns to the fetch step, and the cycle begins again
     with the next instruction as indicated by the program counter.

To illustrate how the previous example's machine code is executed on a processor, we'll present each step in the fetch-execute cycle in a tabular form.


| Step | Machine Code     | Fetch                                    | Decode                                               | Execute                                                                                      | Store                                                                                   | PC Update                                                                                                       |
|------|------------------|------------------------------------------|------------------------------------------------------|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| 1    | `53`               | Fetches `53` from memory at PC.       | Decodes `53` as `push rbx`.                          | Pushes `rbx` value onto the stack.                                                            | Stack pointer decremented, `rbx` stored on stack.                                         | PC incremented to point to next instruction (`48 89 d3`).                                                       |
| 2    | `48 89 d3`         | Fetches `48 89 d3` from memory at PC. | Decodes `48 89 d3` as `mov rdx, rbx`.                 | Moves `rdx` value to `rbx`.                                                                   | `rbx` updated with `rdx` value.                                                           | PC incremented to point to next instruction (`e8 00 00 00 00`).                                                 |
| 3    | `e8 00 00 00 00`   | Fetches `e8 00 00 00 00` from memory at PC.     | Decodes as `call` with offset `0x0`.                  | Current PC pushed onto stack. Control transferred to address. | Stack pointer decremented, return address stored on stack.                                | PC updated to target address.                      |
| 4    | `48 89 03`         | Fetches `48 89 03` from memory at PC. | Decodes `48 89 03` as `mov rax, (rbx)`.               | Moves `rax` value to location pointed by `rbx`.                                                | Memory at `rbx` address updated with `rax` value.                                         | PC incremented to point to next instruction (`5b`).                                                             |
| 5    | `5b`               | Fetches `5b` from memory at PC.       | Decodes `5b` as `pop rbx`.                           | Pops top stack value into `rbx`.                                                               | `rbx` updated with popped value, stack pointer incremented.                               | PC incremented to point to next instruction (`c3`).                                                             |
| 6    | `c3`               | Fetches `c3` from memory at PC.       | Decodes `c3` as `ret`.                               | Pops return address off the stack, transfers control to that address.                           | Instruction pointer updated with return address.                                         | PC set to the popped return address, pointing to next instruction in the calling function.                       |

Each step in the table shows how the Instruction Pointer (or Program Counter) is updated after executing each instruction. The PC points to the next instruction to be executed, and it's updated after each step to reflect the location of the next instruction in the memory. The `call` instruction is a bit more complex, as it involves storing the return address on the stack and updating the PC to the address of the called function (which in this code is given as a placeholder `0x0`). The `ret` instruction then sets the PC back to the return address, which is the next instruction after the `call` in the calling function.

### Control Unit vs. Arithmetic Logic Unit

From the above example, perhaps you are getting the ide of the distinct bu complementary roles that the Control Unit (CU) and the Arithmetic Logic Unit (ALU) play during the fetch-execute cycle.

The Control Unit orchestrates the overall operation of the processor. Its primary function starts with fetching instructions from the memory, a task guided by the Program Counter (PC). Once an instruction is fetched, the CU decodes it, translating the opcode and operands into a set of actions the CPU understands. This decoding is crucial as it determines how the rest of the processor should respond. The CU then sequences the necessary steps to execute the instruction, ensuring that each phase of the cycle occurs in the correct order and at the right time. It's responsible for managing the flow of data within the CPU, controlling the interactions between various components, including memory, registers, and the ALU.

Additionally, the Control Unit generates and interprets a range of control signals essential for CPU operations. These signals facilitate memory read/write operations, the loading of instruction registers, and more. In cases of branching and conditional instructions, the CU evaluates the conditions and decides the program's execution path, often based on flags set by previous operations.

On the other hand, the Arithmetic Logic Unit is the computational heart of the CPU. It performs all arithmetic operations, such as addition, subtraction, multiplication, and division. Besides arithmetic, the ALU is responsible for executing logical operations like AND, OR, and XOR, which are fundamental in decision-making processes within programs. It compares data, setting flags based on the outcomes, which the CU may use for further decision-making. The ALU also handles operations like bit shifting and rotation, modifying the arrangement of bits within a data word.

The ALU often utilizes internal registers to store temporary data during its operations. Unlike the Control Unit, which directs and orchestrates, the ALU is the executor, carrying out the actual computations and logical decisions as instructed by the decoded operations from the CU.

In essence, the CU and the ALU work in tandem within the CPU: the Control Unit acts as the director, coordinating and controlling the sequence of operations, while the Arithmetic Logic Unit is the performer, executing the computational and logical tasks as instructed.

In order to understand more about how these two main components of the CPU are constructed, we will have to dig deeper. 
