# Structures

In C programming, a structure (normally referred to as a `struct`) is a user-defined data type that allows you to combine data items of different kinds. Structures are used to represent a record. Suppose you want to keep track of books in a library. You might want to track the following attributes about each book:

- Title
- Author
- Subject
- Book ID

In C, you can create a structure to hold this information like this:

```c
struct Book {
    char title[50];
    char author[50];
    char subject[100];
    int book_id;
};
```

To use the `struct`, you would declare a variable of that type:

```c
struct Book book;
```

You can then access the members of the structure using the dot `.` operator:

```c
strcpy(book.title, "C Programming");
strcpy(book.author, "Dennis Ritchie");
strcpy(book.subject, "Programming Language");
book.book_id = 6495407;
```

Structures can also contain pointers, arrays, and even other structures, making them very versatile for organizing complex data.

How a struct is represented in memory on an x86-64 platform.



## Memory Alignment and Padding

Memory alignment is leveraged to improve performance and ensure correctness. Aligned memory accesses are faster because modern CPUs are designed to read or write data at aligned addresses in a single operation. Misaligned accesses may require multiple operations and can lead to penalties in terms of performance.

To ensure proper alignment, compilers often insert unused bytes between structure members, known as padding. This automatic padding helps maintain the correct alignment of each member according to their size and the architecture's requirements, thus preventing misaligned accesses and potential performance hits.

Consider the following C structure:

```c
struct example {
    char a;    // 1 byte
    int b;     // 4 bytes
    char c;    // 1 byte
};
```

On an x86-64 system, the compiler will likely add padding to align the `int b` on a 4-byte boundary:

```txt
Offset: 0   1   2   3   4   5   6   7
        +---+---+---+---+---+---+---+---+
        | a |   padding | b             |
        +---+---+---+---+---+---+---+---+
        | c |   padding |
        +---+---+---+---+
```

In this example, 3 bytes of padding are added after `char a` to align `int b`, and another 3 bytes are added after `char c` to make the total size of the structure a multiple of the largest alignment requirement (which is 4 bytes for `int` in this case).

## Accessing Structure Elements in C

You can access elements of a structure using the dot operator if you have a structure variable, or the arrow operator if you have a pointer to a structure. Here's a quick example:

```c
struct Point {
    int x;
    int y;
};

struct Point p1 = {10, 20};
p1.x = 30; // Accessing and modifying using the dot operator

struct Point *p2 = &p1;
p2->y = 40; // Accessing and modifying using the arrow operator
```

In x86-64 assembly, structures are not explicitly defined. Instead, you work with memory offsets. Assuming the `Point` structure from above and that it's aligned in memory, you would access its elements by calculating their offsets from the base address of the structure.

Here's how you might do it in assembly, assuming `p1` is in the `rdi` register:

```asm
; Assuming p1 is in RDI and it's properly aligned in memory
mov DWORD PTR [rdi], 30   ; Set p1.x to 30. The x offset is 0 because it's the first element.
mov DWORD PTR [rdi+4], 40 ; Set p1.y to 40. Assuming 'int' is 4 bytes, y offset is 4.
```

Remember that in x86-64, the size of an integer is typically 4 bytes, so you need to account for that when calculating offsets. 

Finally, you may remember the linked list data structure from Data Structures and Algorithms.  It turns out that structs are an ideal tool for implementing this data structure.  Here is a video walking through this example:

<div class="embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/yxdMGZaN1qI?si=UkuYCcbrUK1_imYz" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

## Conclusion

We've explored the transformation of basic control flows, delved into the nuances of function calls, and unraveled the complexities of advanced data structures such as arrays and structs. This module has equipped us with a deeper understanding of how our abstract ideas and algorithms that we express using higher-level programming languages are translated into the precise language that our machines comprehend. Next week, we will get into some of the nitty gritty details of how the hardware interprets the instructions and executes them.