# Diving Deep into Optimization

## Reading

To dive more deeply into specific optimization techniques, we will rely on a detailed manual that focuses on software optimization.  We will then look at a few examples and summarize the key takeaways.

Read the following sections from [*Optimizing Software in C++: An optimization guide for Windows, Linux, and Mac platforms*](https://www.agner.org/optimize/optimizing_cpp.pdf) by Ager Fog, Technical University of Denmark before proceeding.  I'll warn you that this is a good amount of reading, so I have included Sherpa links for you to complete after reading each section.  Completion of these Sherpa interviews and attendance during the live class session will make up your class participation grades for this week.

- Sections 1.1 and 1.2 - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca4125986fa574e65ac4e5)
- Sections 3.1 and 3.2  - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca41ed5c1cdd5f12e6b4bd)
- Sections 7.1 through 7.6  - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca42855c1cdd5f12e6b4be)
- Sections 7.12 through 7.14  - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca430d5c1cdd5f12e6b4c0)
- Sections 7.17 through 7.18  - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca437cbb91f4fc6a68899f)
- Section 7.20  - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca43cd5c1cdd5f12e6b4c3)
- Sections 9.1 through 9.6  - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca4419be64b4edf0a22752)
- Section 9.9  - [Complete a Sherpa Discussion](https://app.sherpalabs.co/student/assignment/65ca44745c1cdd5f12e6b4c9)
- (Optional) Chapter 14

I encourage you to first skim through the material and try to form some broad generalizations and intuition about the key topics. As you complete the midterm project this week, you will likely want to reference back to these materials so that you can apply the ideas.

> Note: The material references examples in C++ though the examples that we will focus on are presented using only features that are also present in the C language, so don't be confused.

## Loop Unrolling Example

Loop unrolling is a technique used to increase a program's efficiency by reducing the loop overhead and increasing the loop body's size, allowing for more operations to be executed per iteration. This can lead to better use of CPU caching and instruction pipelining, thus improving overall performance. However, it's important to note that excessive loop unrolling can increase code size and potentially harm performance due to cache misses, so it must be applied judiciously.

### C Program Example

Consider a simple program that sums the elements of a large array:

```c
#include <stdio.h>

#define SIZE 10000 // Array size

int main() {
    int array[SIZE];
    int sum = 0;

    // Initialize the array with values
    for(int i = 0; i < SIZE; i++) {
        array[i] = i;
    }

    // Sum the elements of the array
    for(int i = 0; i < SIZE; i++) {
        sum += array[i];
    }

    printf("Sum = %d\n", sum);

    return 0;
}
```

### Optimized Version with Loop Unrolling

In the optimized version, we'll unroll the loop by summing four elements of the array per iteration. This reduces the number of iterations and decreases loop overhead:

```c
#include <stdio.h>

#define SIZE 10000 // Array size, should be a multiple of 4 for this simple example

int main() {
    int array[SIZE];
    int sum = 0;

    // Initialize the array with values
    for(int i = 0; i < SIZE; i++) {
        array[i] = i;
    }

    // Sum the elements of the array with loop unrolling
    for(int i = 0; i < SIZE; i += 4) {
        sum += array[i] + array[i+1] + array[i+2] + array[i+3];
    }

    printf("Sum = %d\n", sum);

    return 0;
}
```

### Key Points

- **Loop Overhead Reduction**: Each iteration of the unrolled loop does more work, reducing the total number of loop iterations and, consequently, the loop control overhead.

- **Increased Instruction-Level Parallelism**: By executing more operations per iteration, the CPU can better utilize its execution units, potentially leading to performance improvements, especially on modern CPUs with powerful instruction pipelining and execution prediction.

- **Memory Access Optimization**: Accessing multiple consecutive array elements in a single loop iteration can improve cache locality, making better use of data loaded into the CPU cache.

There are som considerations, however, including the following:

- The example assumes the array size (`SIZE`) is a multiple of the unroll factor (4 in this case). In real applications, you may need to handle the remainder elements that don't fit neatly into the unrolled loop.

- The benefits of loop unrolling can vary depending on the specific workload, the size of the data being processed, and the architecture of the CPU. It's always a good idea to profile your code to determine whether loop unrolling provides a significant performance boost in your specific case.

## Tale Recursion

Tail recursion is a special case of recursion where the recursive call is the last operation in the function. Tail recursion can be optimized by the compiler to reuse the stack frame of the current function call for the next one, effectively converting the recursion into a loop. This optimization can significantly reduce the memory overhead associated with recursive calls and prevent stack overflow for deep recursions.

### C Program Example

Consider a simple recursive function to calculate the factorial of a number:

```c
#include <stdio.h>

// Recursive factorial function
unsigned long long factorial(int n) {
    if (n <= 1) return 1; // Base case
    else return n * factorial(n - 1); // Recursive case
}

int main() {
    int number = 20;
    printf("Factorial of %d is %llu\n", number, factorial(number));
    return 0;
}
```

### Optimized Version with Tail Recursion

To optimize this using tail recursion, we introduce an accumulator parameter that carries the result of the factorial calculation through the recursive calls, allowing the final call to return the result directly.

```c
#include <stdio.h>

// Tail recursive factorial function
unsigned long long factorialTail(int n, unsigned long long acc) {
    if (n <= 1) return acc; // Base case
    else return factorialTail(n - 1, n * acc); // Tail recursive case
}

// Wrapper function for factorialTail to provide a clean interface
unsigned long long factorial(int n) {
    return factorialTail(n, 1);
}

int main() {
    int number = 20;
    printf("Factorial of %d is %llu\n", number, factorial(number));
    return 0;
}
```

### Key Points

- **Stack Frame Reuse**: The optimized version uses tail recursion, which allows compilers that support tail call optimization (TCO) to reuse the stack frame for each recursive call. This effectively turns the recursive process into an iterative one under the hood, without growing the stack.

- **Preventing Stack Overflow**: For very large input values, the original recursive version could lead to a stack overflow error. The tail-recursive version avoids this issue by maintaining a constant stack size through optimization.

- **Maintaining Clean Interfaces**: The wrapper function `factorial` hides the implementation detail of the accumulator, providing a clean interface to the caller.

It should be noted that tail recursion is most beneficial when the recursion depth can be very large, and there's a risk of stack overflow, or when optimizing for memory usage is crucial.

## Data Alignment

Data alignment refers to placing variables in memory at addresses that match their size, which is often a power of two. Proper alignment allows the CPU to access data more efficiently, as misaligned accesses might require multiple memory fetches and can lead to increased cache line usage and potential penalties on some architectures.

### Example Demonstrating the Importance of Data Alignment

In this example, we will compare the time it takes to access an aligned vs. a misaligned array of structures.

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Aligned struct using manual padding
typedef struct {
    int a;    // 4 bytes on most platforms
    float b;  // 4 bytes
    // Manual padding to align to 16 bytes
    char c[4]; // 4 bytes
    char padding[4]; // Additional padding to make struct size 16 bytes
} AlignedStruct;

// Misaligned struct without specific alignment
typedef struct {
    char x;   // 1 byte
    int a;    // 4 bytes, potentially misaligned depending on 'x' and padding
    float b;  // 4 bytes
    char c[3]; // 3 bytes to ensure misalignment
} MisalignedStruct;

// Function to simulate processing of struct arrays, no change needed
void processStructs(void* structs, size_t count, size_t structSize, int isAligned) {
    clock_t start, end;
    double cpuTimeUsed;
    start = clock();

    // Access logic remains the same as before
    for (size_t i = 0; i < count; i++) {
        char* baseAddr = (char*)structs + i * structSize;
        volatile int a = *((int*)(baseAddr + (isAligned ? 0 : 1))); // Adjust for potential misalignment
        volatile float b = *((float*)(baseAddr + (isAligned ? sizeof(int) : sizeof(int) + 1)));
        volatile char c = *(baseAddr + (isAligned ? sizeof(int) + sizeof(float) : sizeof(int) + sizeof(float) + 1));
    }

    end = clock();
    cpuTimeUsed = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Time taken for %s structs: %f seconds\n", isAligned ? "aligned" : "misaligned", cpuTimeUsed);
}

int main() {
    size_t count = 10000000; // Number of struct instances

    // Allocation and processing logic remains unchanged
    AlignedStruct* alignedStructs = (AlignedStruct*)malloc(count * sizeof(AlignedStruct));
    MisalignedStruct* misalignedStructs = (MisalignedStruct*)malloc(count * sizeof(MisalignedStruct));

    processStructs(alignedStructs, count, sizeof(AlignedStruct), 1);
    processStructs(misalignedStructs, count, sizeof(MisalignedStruct), 0);

    free(alignedStructs);
    free(misalignedStructs);

    return 0;
}
```

#### Explanation

- **Struct Definitions**: Two struct definitions are provided, `AlignedStruct` and `MisalignedStruct`. `AlignedStruct` is explicitly aligned to a 16-byte boundary using manual padding, while `MisalignedStruct` includes a `char` at the beginning to simulate misalignment for its `int` and `float` members.
  
- **Access Function**: The `processStructs` function simulates processing of arrays of both types of structs. It measures and prints the time taken to access elements of each struct in the array. To simulate misalignment effects in `MisalignedStruct`, the access offsets are adjusted accordingly.

- **Performance Measurement**: The program measures and compares the time taken to process aligned vs. misaligned struct arrays, highlighting the potential impact of data alignment on performance.

#### Considerations

- **Compiler and Architecture**: The actual performance impact of data alignment can vary significantly across different compilers and target architectures. Some systems handle misalignment with minimal penalties, while others may exhibit a substantial performance degradation.

- **Memory Usage**: Aligning data structures can increase memory usage due to added padding. This trade-off between memory usage and access efficiency needs to be considered, especially for memory-constrained environments.

This example demonstrates how data alignment can affect the efficiency of memory access in a C program, emphasizing the importance of considering alignment in performance-critical applications.

## Access Data Sequentially

Accessing data sequentially in memory is crucial for optimizing C programs due to the way modern CPUs and memory hierarchies work. Sequential access patterns take advantage of spatial locality, allowing the CPU's cache mechanism to prefetch data efficiently, thereby reducing cache misses and improving overall program speed.

### Example: Sum of Array Elements

To demonstrate the importance of accessing data sequentially, let's consider two scenarios where we sum the elements of a 2D array: once accessing the data in a row-major order (sequential access) and once in a column-major order (non-sequential access).

We'll use a large 2D array for this example to ensure that the effects on performance due to caching and access patterns are noticeable.

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define ROWS 10000
#define COLS 10000

// Function to sum elements in row-major order
long long sumRowMajor(int arr[ROWS][COLS]) {
    long long sum = 0;
    for (int i = 0; i < ROWS; ++i) {
        for (int j = 0; j < COLS; ++j) {
            sum += arr[i][j];
        }
    }
    return sum;
}

// Function to sum elements in column-major order
long long sumColumnMajor(int arr[ROWS][COLS]) {
    long long sum = 0;
    for (int j = 0; j < COLS; ++j) {
        for (int i = 0; i < ROWS; ++i) {
            sum += arr[i][j];
        }
    }
    return sum;
}

int main() {
    int(*arr)[COLS] = malloc(sizeof(int[ROWS][COLS])); // Dynamic allocation for a large array

    // Initialize array
    for (int i = 0; i < ROWS; ++i) {
        for (int j = 0; j < COLS; ++j) {
            arr[i][j] = 1; // Simplified initialization for demonstration
        }
    }

    clock_t start, end;
    double cpuTimeUsed;

    // Measure time taken for row-major access
    start = clock();
    long long sumRow = sumRowMajor(arr);
    end = clock();
    cpuTimeUsed = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Sum (Row-major): %lld, Time: %f seconds\n", sumRow, cpuTimeUsed);

    // Measure time taken for column-major access
    start = clock();
    long long sumCol = sumColumnMajor(arr);
    end = clock();
    cpuTimeUsed = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Sum (Column-major): %lld, Time: %f seconds\n", sumCol, cpuTimeUsed);

    free(arr); // Clean up
    return 0;
}
```

#### Explanation

- **Row-Major Access**: This pattern accesses array elements sequentially as they are stored contiguously in memory, which matches the order of the inner loop. It benefits from spatial locality and prefetching, making it faster.

- **Column-Major Access**: This pattern causes more cache misses because it jumps across rows, accessing data that is not contiguous in memory. It results in poorer use of the cache and slower performance due to the higher cost of cache misses.

#### Expected Outcome

You'll notice that summing the array elements in row-major order is significantly faster than in column-major order due to the efficient use of the CPU cache. Sequential memory access allows the prefetching mechanism to load contiguous memory blocks into the cache ahead of time, reducing the number of cache misses.

#### Considerations

- **Memory Layout**: Understanding the memory layout of data structures is crucial for optimizing memory access patterns. In C, multi-dimensional arrays are stored in row-major order, which influences how to access them optimally.

- **Hardware Specifics**: The actual performance gain from sequential access can vary depending on the specific hardware architecture, including the size of the cache lines and the efficiency of the prefetching mechanism.

- **Compiler Optimizations**: Modern compilers may attempt to optimize non-sequential accesses in some cases, but it's generally best to manually ensure data is accessed sequentially whenever possible for critical performance paths.

## Summary

Optimizing C programs for efficiency involves understanding low-level details of how a CPU processes instructions and how caching and memory access impact CPU performance, among other things. Proper data alignment reduces memory access penalties and enhances cache utilization, while tail recursion optimization can significantly decrease stack usage, transforming recursive calls into more efficient loops. Sequential data access takes advantage of CPU cache prefetching, minimizing cache misses and improving program execution speed by ensuring memory reads and writes are predictable and contiguous.