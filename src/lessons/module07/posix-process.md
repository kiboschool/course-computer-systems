# POSIX Process Management

All operating systems provide mechanisms for creating new processes, terminating existing processes, and performing
related actions. The details vary from system to system. To provide a concrete example, I will present relevant features
of the POSIX API, which is used by Linux and UNIX, including by Mac OS X.

In the POSIX approach, each process is identified by a *process ID number*, which is a positive integer. Each process
(with one exception) comes into existence through the *forking* of a *parent process*. The exception is the first
process created when the operating system starts running. A process forks off a new process whenever one of the threads
running in the parent process calls the `fork` procedure. In the parent process, the call to `fork` returns the process
ID number of the new child process. (If an error occurs, the procedure instead returns a negative number.) The process
ID number may be important to the parent later, if it wants to exert some control over the child or find out when the
child terminates.

Meanwhile, the child process can start running. The child process is in many regards a copy of the parent process. For
protection purposes, it has the same credentials as the parent and the same capabilities for such purposes as access to
files that have been opened for reading or writing. In addition, the child contains a copy of the parent's address
space. That is, it has available to it all the same executable program code as the parent, and all of the same
variables, which initially have the same values as in the parent. However, because the address space is copied instead
of shared, the variables will start having different values in the two processes as soon as either performs any
instructions that store into memory. (Special facilities do exist for sharing some memory; I am speaking here of the
normal case.)

Because the child process is nearly identical to the parent, it starts off by performing the same action as the parent;
the `fork` procedure returns to whatever code called it. However, application programmers generally don't want the child
to continue executing all the same steps as the parent; there wouldn't be much point in having two processes if they
behaved identically. Therefore, the `fork` procedure gives the child process an indication that it is the child so that
it can behave differently. Namely, `fork` returns a value of 0 in the child. This contrasts with the return value in the
parent process, which is the child's process ID number, as mentioned earlier.

The normal programming pattern is for any `fork` operation to be immediately followed by an `if` statement that checks
the return value from `fork`. That way, the same program code can wind up following two different courses of action, one
in the parent and one in the child, and can also handle the possibility of failure, which is signaled by a negative
return value. The C program below shows an example of this; the parent and child processes are similar (both loop five
times, printing five messages at one-second intervals), but they are different enough to print different messages, as
shown in the sample output. Keep in mind that this output is only one possibility; not only can the ID number be
different, but the interleaving of output from the parent and child can also vary from run to run.

```C
#include <unistd.h>
#include <stdio.h>

int main() {
    int loopCount = 5; // each process will get its own loopCount
    printf("I am still only one process.\n");
    pid_t returnedValue = fork();
    if (returnedValue < 0){
        // still only one process
        perror("error forking"); // report the error
        return -1;
    } else if (returnedValue == 0){
        // this must be the child process
            while(loopCount > 0) {
            printf("I am the child process.\n");
            loopCount--; // decrement child’s counter only
            sleep(1); // wait a second before repeating
            }
    } 
    else {
        // this must be the parent process
        while (loopCount > 0){
            printf("I am the parent process; my child’s ID is %i\n", returnedValue);
            loopCount--; // decrement parent’s counter only
            sleep(1);
        }
    }
    return 0;
}
```

```text
I am still only one process.
I am the child process.
I am the parent process; my child's ID is 23307
I am the parent process; my child's ID is 23307
I am the child process.
I am the parent process; my child's ID is 23307
I am the child process.
I am the parent process; my child's ID is 23307
I am the child process.
I am the parent process; my child's ID is 23307
I am the child process.
```

This example program also illustrates that the processes each get their own copy of the `loopCount` variable. Both start
with the initial value, 5, which was established before the fork. However, when each process decrements the counter,
only its own copy is affected.

In early versions of UNIX, only one thread ever ran in each process. As such, programs that involved concurrency needed
to create multiple processes using `fork`. In situations such as that, it would be normal to see a program like the one
above, which includes the full code for both parent and child. Today, however, concurrency within a program is normally
done using a multithreaded process. This leaves only the other big use of `fork`: creating a child process to run an
entirely different program. In this case, the child code in the forking program is only long enough to load in the new
program and start it running. This happens, for example, every time you type a program's name at a shell prompt; the
shell forks off a child process in which it runs the program. Although the program execution is distinct from the
process forking, the two are used in combination. Therefore, I will turn next to how a thread running in a process can
load a new program and start that program running.

The POSIX standard includes six different procedures, any one of which can be used to load in a new program and start it
running. The six are all variants on a theme; because they have names starting with `exec`, they are commonly called the
*exec family*. Each member of the exec family must be given enough information to find the new program stored in a file
and to provide the program with any arguments and environment variables it needs. The family members differ in exactly
how the calling program provides this information. Because the family members are so closely related, most systems
define only the `execve` procedure in the kernel of the operating system itself; the others are library procedures
written in terms of `execve`.

Because `execl` is one of the simpler members of the family, I will use it for an example. The program below prints out
a line identifying itself, including its own process ID number, which it gets using the `getpid` procedure. Then it uses
`execl` to run a program, named `ps`, which prints out information about running processes. After the call to `execl`
comes a line that prints out an error message, saying that the execution failed. You may find it surprising that the
error message seems to be issued unconditionally, without an `if` statement testing whether an error in fact occurred.
The reason for this surprising situation is that members of the exec family return only if an error occurs; if all is
well, the new program has started running, replacing the old program within the process, and so there is no possibility
of returning in the old program.

```C
#include <unistd.h>
#include <stdio.h>

int main(){
    printf("This is the process with ID %i, before the exec.\n", getpid());
    execl("/bin/ps", "ps", "axl", NULL);
    perror("error execing ps");
    return -1;
}
```

Looking in more detail at the example program's use of `execl`, you can see that it takes several arguments that are
strings, followed by the special `NULL` pointer. The reason for the `NULL` is to mark the end of the list of strings;
although this example had three strings, other uses of `execl` might have fewer or more. The first string specifies
which file contains the program to run; here it is `/bin/ps`, that is, the `ps` program in the `/bin` directory, which
generally contains fundamental programs. The remaining strings are the so-called "command-line arguments," which are
made available to the program to control its behavior. Of these, the first is conventionally a repeat of the command's
name; here, that is `ps`. The remaining argument, `axl`, contains both the letters `ax` indicating that all processes
should be listed and the letter `l` indicating that more complete information should be listed for each process. As you
can see from the sample output below, the exact same process ID that is mentioned in the initial message shows up again
as the ID of the process running the `ps axl` command. The process ID remains the same because `execl` has changed what
program the process is running without changing the process itself.

```text
This is the process with ID 3849, before the exec.
  UID   PID  ...  COMMAND
.
.
. 
    0  3849  ...  ps axl
.
.
.
```

One inconvenience about `execl` is that to use it, you need to know the directory in which the program file is located.
For example, the previous program will not work if `ps` happens to be installed somewhere other than `/bin` on your
system. To avoid this problem, you can use `execlp`. You can give this variant a filename that does not include a
directory, and it will search through a list of directories looking for the file, just like the shell does when you type
in a command. This can be illustrated with an example program that combines `fork` with `execlp`:

```C
#include <unistd.h>
#include <stdio.h>

int main() {
    pid_t returnedValue = fork();
    if (returnedValue < 0) {
        perror("error forking");
        return -1;
    }
    else if (returnedValue == 0) {
        execlp("xclock", "xclock", NULL);
        perror("error execing xclock");
        return -1;
    } 
    else {
        return 0;
    }
}
```

This example program assumes you are running the X Window System, as on most Linux or UNIX systems. It runs `xclock`, a
program that displays a clock in a separate window. If you run the `launcher` program from a shell, you will see the
clock window appear, and your shell will prompt you for the next command to execute while the clock keeps running. This
is different than what happens if you type `xclock` directly to the shell. In that case, the shell waits for the `
xclock` program to exit before prompting for another command. Instead, the example program is more similar to typing
`xclock &` to the shell. The `&` character tells the shell not to wait for the program to exit; the program is said to
run "in the background." The way the shell does this is exactly the same as the sample program: it forks off a child
process, executes the program in the child process, and allows the parent process to go on its way. In the shell, the
parent loops back around to prompt for another command.

When the shell is not given the `&` character, it still forks off a child process and runs the requested command in the
child process, but now the parent does not continue to execute concurrently. Instead the parent waits for the child
process to terminate before the parent continues. The same pattern of fork, execute, and wait would apply in any case
where the forking of a child process is not to enable concurrency, but rather to provide a separate process context in
which to run another program.

In order to wait for a child process, the parent process can invoke the `waitpid` procedure. This procedure takes three
arguments; the first is the process ID of the child for which the parent should wait, and the other two can be zero if
all you want the parent to do is to wait for termination. As an example of a process that waits for each of its child
processes, the program below shows a very stripped-down shell.

```C
#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <string.h>

int main() {
    char command[256]; // Array to hold the command

    while(1) { // Loop until return
        printf("Command (one word only)> ");
        fflush(stdout); // Make sure "Command" is printed immediately

        if (scanf("%255s", command) != 1) {
            fprintf(stderr, "Error reading command\n");
            return -1; // Exit if we fail to read a command
        }

        if (strcmp(command, "exit") == 0) {
            return 0; // Exit the loop if the command is "exit"
        } else {
            pid_t returnedValue = fork();
            if (returnedValue < 0) {
                perror("Error forking");
                return -1;
            } else if (returnedValue == 0) {
                execlp(command, command, NULL);
                perror(command); // If execlp returns, it must have failed
                return -1;
            } else {
                if (waitpid(returnedValue, NULL, 0) < 0) {
                    perror("Error waiting for child");
                    return -1;
                }
            }
        }
    }
}
```

This shell can be used to run the user's choice of commands, such as `date`, `ls`, and `ps`, as illustrated in the
output below. A real shell would allow command line arguments, offer background execution as an option, and provide many
other features. Nonetheless, you now understand the basics of how a shell runs programs

```text
Command (one word only)> date
Thu Feb 12 09:33:26 CST 2024
Command (one word only)> ls
microshell microshell.c 
Command (one word only)> ps
  PID TTY       TIME     CMD
23498 pts/2     00:00:00 bash
24848 pts/2     00:00:00 microshell
24851 pts/2     00:00:00 ps
Command (one word only)> exit
```

Notice that a child process might terminate prior to the parent process invoking `waitpid`. As such, the `waitpid`
procedure may not actually need to wait, contrary to what its name suggests. It may be able to immediately report the
child process's termination. Even in this case, invoking the procedure is still commonly referred to as "waiting for"
the child process. Whenever a child process terminates, if its parent is not already waiting for it, the operating
system retains information about the terminated process until the parent waits for it. A terminated process that has not
yet been waited for is known as a *zombie*. Waiting for a zombie makes its process ID number available for assignment to
a new process; the memory used to store information about the process can also be reused. This is known as the zombie.

At this point, you have seen many of the key elements of the process life cycle. Perhaps the most important omission is
that I haven't shown how processes can terminate, other than by returning from the `main` procedure. A process can
terminate itself by using the `exit` procedure (in Java, `System.exit`), or it can terminate another process using the
`kill` procedure (see the documentation for details).