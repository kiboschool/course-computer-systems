# Processes & Protection

Whether the operating system gives each process its own address space, or instead gives each process its own access
rights to portions of a shared address space, the operating system needs to be privileged relative to the processes.
That is, the operating system must be able to carry out actions, such as changing address spaces or access rights, that
the processes themselves cannot perform. Otherwise, the processes wouldn’t be truly contained; they could get access to
each other’s memory the same way the operating system does.

For this reason, every modern processor can run in two different modes, one for the operating system and one for the
application processes. The names of these modes vary from system to system. The more privileged mode is sometimes called
*kernel mode*, *system mode*, or *supervisor mode*. Kernel mode seems to be in most common use, so I will use it.
The less privileged mode is often called *user mode*.

When the processor is in kernel mode, it can execute any instructions it encounters, including ones to change memory
accessibility, ones to directly interact with I/O devices, and ones to switch to user mode and jump to an instruction
address that is accessible in user mode. This last kind of instruction is used when the operating system is ready to
give a user process some time to run.

When the processor is in user mode, it will execute normal instructions, such as `add`, `load`, or `store`. However, any
attempt to perform hardware-level I/O or change memory accessibility interrupts the process’s execution and jumps to a
handler in the operating system, an occurrence known as an exception. The same sort of transfer to the operating system occurs
for a page fault or any interrupt, such as a timer going off or an I/O device requesting attention. Additionally, the
process may directly execute an instruction to call an operating system procedure, which is known as a *system call*. For
example, the process could use system calls to ask the operating system to perform the `fork` and `execve` operations that I
described previously. System calls can also request I/O, because the process doesn’t have unmediated access to the
I/O devices. Any transfer to an operating system routine changes the operating mode and jumps to the starting address of
the routine. Only designated entry points may be jumped to in this way; the process can’t just jump into the middle of
the operating system at an arbitrary address.

The operating system needs to have access to its own portion of memory, as well as the memory used by processes. The
processes, however, must not have access to the operating system’s private memory. Thus, switching operating modes must
also entail a change in memory protection. How this is done varies between architectures.

Some architectures require the operating system to use one address space for its own access, as well as one for each
process. For example, if a special register points at the base of the page table, this register may need to be changed
every time the operating mode changes. The page table for the operating system can provide access to pages that are
unavailable to any of the processes.

Many other architectures allow each page table entry to contain two different protection settings, one for each
operating mode. For example, a page can be marked as readable, writable, and executable when in kernel mode, but totally
inaccessible when in user mode. In this case, the page table need not be changed when switching operating modes. If the
kernel uses the same page table as the user-mode process, then the range of addresses occupied by the kernel will be off
limits to the process. The IA-32 architecture fits this pattern. For example, the Linux operating system on the IA-32
allows each user-mode process to access up to 3 GiB of its 4-GiB address space, while reserving 1 GiB for access by the
kernel only.

In this latter sort of architecture, the address space doesn’t change when switching from a user process to a simple
operating system routine and back to the same user process. However, the operating system may still need to switch
address spaces before returning to user mode if its scheduler decides the time has come to run a thread belonging to a
different user-mode process. Whether this change of address spaces is necessary depends on the overall system design:
one address space per process or a single shared address space.

Now that we have an understanding of how the operating systems allows for switching between threads and processes, that
we've explored some of the security implications, let's explore some of the practical tools that we can use to work with
threads directly.
