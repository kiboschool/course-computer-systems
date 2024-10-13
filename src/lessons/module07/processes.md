# An Operating System "process"

Processes play a central role in the view of an operating system as experienced by most system administrators,
application programmers, and other moderately sophisticated computer users. In particular, the technical concept of
process comes the closest to the informal idea of a running program.

The concept of process is not entirely standardized across different operating systems. Not only do some systems use a
different word (such as "task"), but also the details of the definition vary. Nonetheless, most mainstream systems are
based on definitions that include the following:

- **One or more threads**: Because a process embodies a running program, often the process will be closely associated
  with a single thread. However, some programs are designed to divide work among multiple threads, even if the program
  is run only once. (For example, a web browser might use one thread to download a web page while another thread
  continues to respond to the user interface.)

    > In operating systems, a thread is the smallest sequence of programmed instructions that can be managed independently by a scheduler. Threads enable parallel execution of tasks within a single process, improving the efficiency of resource usage and application performance. We will discuss threads in more detail shortly.

- **Memory accessible to those threads**: The word "accessible" implies that some sort of protection scheme ensures that
  the threads within a process access only the memory for which that process has legitimate access rights. As you will
  see, the mainstream protection approach is for each process to have its own virtual memory address space, shared by
  the threads within that process. However, I will also present an alternative, in which all processes share a single
  address space, but with varying access rights to individual objects within that address space. In any case, the access
  rights are assigned to the process, not to the individual threads.

- **Other access rights**: A process may also hold the rights to resources other than memory. For example, it may have
  the right to update a particular file on disk or to service requests arriving over a particular network communication
  channel. We will sketch two general approaches by which a process can hold access rights. Either the process can hold
  a specific *capability*, such as the capability to write a particular file, or it can hold a general *credential*,
  such as the identification of the user for whom the process is running. In the latter case, the credential indirectly
  implies access rights, by way of a separate mechanism, such as *access control lists*.

- **Resource allocation context**: Limited resources (such as space in memory or on disk) are generally associated with
  a process for two reasons. First, the process's termination may serve to implicitly release some of the resources it
  is holding, so that they may be reallocated. Operating systems generally handle memory in this way. Second, the
  process may be associated with a limited resource quota or with a billing account for resource consumption charges.
  For simplicity, I will not comment on these issues any further.

- **Miscellaneous context**: Operating systems often associate other aspects of a running program's state with the
  process. For example, systems such as Linux and UNIX (conforming to the POSIX standard) keep track of each process's
  current working directory. That is, when any thread in the process accesses a file by name without explicitly
  indicating the directory containing the file, the operating system looks for the file starting from the process's
  current working directory. For historical reasons, the operating system tracks a single current working directory per
  process, rather than one per thread.

From this list, you can see that many of the key aspects of processes concern protection, and these are the aspects on
which we will focus. But first, we will devote the next section to the basics of how the POSIX
process management API can be used, such as how a thread running in one process creates another process and how a
process exits. This section should serve to make the use of processes more concrete. Studying this API will also allow
you to understand how the shell (command interpreter) executes user commands.
