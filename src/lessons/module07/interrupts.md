# Interrupts & Exceptions

## Interrupts

Normally a processor will execute consecutive instructions one after another, deviating from sequential flow only when
directed by an explicit jump instruction or by some variant such as the `ret` instruction used in the Linux code for
thread switching. However, there is always some mechanism by which external hardware (such as a disk drive or a network
interface) can signal that it needs attention. A hardware timer can also be set to demand attention periodically, such
as every millisecond. When an I/O device or timer needs attention, an *interrupt* occurs, which is almost as though a
procedure call instruction were forcibly inserted between the currently executing instruction and the next one. Thus,
rather than moving on to the program’s next instruction, the processor jumps off to the special procedure called the
*interrupt handler*.

The interrupt handler, which is part of the operating system, deals with the hardware device and then executes a *return
from interrupt* instruction, which jumps back to the instruction that had been about to execute when the interrupt
occurred. Of course, in order for the program’s execution to continue as expected, the interrupt handler needs to be
careful to save all the registers at the start and restore them before returning

Using this interrupt mechanism, an operating system can provide preemptive multitasking. When an interrupt occurs, the
interrupt handler first saves the registers to the current thread’s stack and takes care of the immediate needs, such as
accepting data from a network interface controller or updating the system’s idea of the current time by one millisecond.
Then, rather than simply restoring the registers and executing a return from interrupt instruction, the interrupt
handler checks whether it would be a good time to preempt the current thread and switch to another

For example, if the interrupt signaled the arrival of data for which a thread had long been waiting, it might make sense
to switch to that thread. Or, if the interrupt was from the timer and the current thread had been executing for a long
time, it may make sense to give another thread a chance. These policy decisions are related to scheduling.

In any case, if the operating system decides to preempt the current thread, the interrupt handler switches threads using
a mechanism such as the `switchFromTo` procedure. This switching of threads includes switching to the new thread’s stack,
so when the interrupt handler restores registers before returning, it will be restoring the new thread’s registers. The
previously running thread’s register values will remain safely on its own stack until that thread is resumed.

## Exceptions

While interrupts are external signals requiring the processor's attention, exceptions are quite different in nature and
origin. An exception arises during the execution of a program due to unusual or illegal conditions that the CPU
encounters while executing instructions. These conditions could range from arithmetic errors, such as division by zero,
to memory issues like accessing invalid memory addresses.

Unlike interrupts, which can occur at any time and are independent of the currently executing program, exceptions are
directly tied to the program's actions. When an exception occurs, it is as though the program itself has generated a
signal demanding immediate attention due to some problematic situation. The processor responds by temporarily halting
the current program flow to address the issue, typically by jumping to a predefined section of code known as the
exception handler.

The primary distinction between exceptions and interrupts lies in their sources and how they are triggered.  Another
difference is in their handling. The interrupt handler aims to quickly address the needs of the external device and then
returns to the previous state of the program, preserving its flow as if the interruption never occurred. On the other
hand, an exception handler deals with errors or special conditions arising from the program's execution. After handling
an exception, the system must decide whether to continue the execution of the program, fix the issue, or terminate the
program if the error is severe and unrecoverable.

In operating systems, the distinction between interrupts and exceptions is crucial for maintaining system stability and
security. While handling interrupts ensures that the operating system remains responsive to external events and devices,
handling exceptions ensures that errors within programs do not lead to broader system failures. Both mechanisms require
the operating system to save and restore the state of the program correctly, but they serve different purposes: one
maintains external communication and functionality, and the other preserves internal program integrity and security.

> **Security and Threads**:
>
> Security issues arise when some threads are unable to execute because others are hogging the
> computer’s attention. Security issues also arise because of unwanted interactions between threads. Unwanted
> interactions include a thread writing into storage that another thread is trying to use or reading from storage another
> thread considers confidential. These problems are most likely to arise if the programmer has a difficult time
> understanding how the threads may interact with one another.  It is beyond the scope of this course to explore solutions
> to these problems in detail; however, it is worth mentioning.