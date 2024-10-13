# Arrays

Arrays are fundamental data structures that store elements of the *same data type* in a *contiguous* block of memory. 

Here a simple example is of an array being declared in C:

```c
int myArray[10]; // Declares an array of 10 integers. The indices range from 0 to 9.
```

To access the third element, you would use `myArray[2]` since array indexing starts at 0. 

An array uses a single stretch of memory to store all its elements in order to allow for efficient access and manipulation of the array elements. The base address is the memory location of the first element of the array (often denoted as index 0). Array indexing is used to access elements at a particular position within the array. The memory address of any element can be calculated using the base address and the index.

## Representing Multi-dimensional Arrays

In order to represent multi-dimensional arrays (like 2D arrays) row-major order is used.  This is a method of storing the elements such that the entire first row is stored contiguously, followed by the entire second row, and so on. This is the convention used in languages like C and C++.

Imagine a 2D array with 2 rows and 3 columns:

```txt
+-----+-----+-----+
| A00 | A01 | A02 |  <-- Row 0
+-----+-----+-----+
| A10 | A11 | A12 |  <-- Row 1
+-----+-----+-----+
```

In row-major order, this array would be stored in memory as a single contiguous block like this:

```txt
+-----+-----+-----+-----+-----+-----+
| A00 | A01 | A02 | A10 | A11 | A12 |
+-----+-----+-----+-----+-----+-----+
```

Each cell represents an element of the array, and the elements of each row are stored contiguously before moving on to the next row.

In memory, if the base address is `B`, and the array is `int arr[2][3]`, the address of the element `arr[i][j]` (where `sizeof(int)` is `S`) can be calculated as:

```txt
Address(arr[i][j]) = B + ((i * number_of_columns) + j) * S
```

For `arr[1][2]` in our example, the address would be:

```txt
Address(arr[1][2]) = B + ((1 * 3) + 2) * S
```

This calculation ensures that we move past the entire first row (`1 * 3` elements) and then to the third element in the second row (`+ 2`). This representation allows the system to calculate the memory address of any array index *extremely* efficiently since it relies only on addition and multiplication.  

## Accessing Array Elements

As is the theme of this module, let's dive into some example C code for accessing array elements and the corresponding assembly code to gain a deeper understanding of how processors work with arrays.

An array name can be thought of as a pointer to its first element, and you can access elements by adding an offset to the pointer.  For example, `int value = *(myArray + 2);` accesses the third element of the array (since it is indexed from 0).  This is equivalent to `int value = array[2];`.

With this in mind, let's write a simple C loop that iterates through all the elements in an array and prints out the values:

```c
for(int i = 0; i < arraySize; i++) {
    printf("%d\n", myArray[i]);
}
```

Now, let's study the equivalent code in assembly:

```ass
mov rax, 0           ; Initialize index to 0
loop_start:
cmp rax, arraySize   ; Compare index with array size
jge loop_end         ; Jump to end if index >= array size
mov rsi, rax         ; Move current index to rsi
mov rdi, myArray     ; Move array base address to rdi
add rdi, rsi         ; Add index to base address
mov rdx, [rdi]       ; Move the value at address to rdx
; Code to print value in rdx
inc rax              ; Increment index
jmp loop_start       ; Jump back to the start of the loop
loop_end:
```

In this code, the register `rax` represents the variable `i` (the loop counter) and the register  `rdi` contains the result of adding the bas address of the array to the index.  This register is then used to index into that memory address and store the value of the array element to the register `rdx`.  

Here is another example:

<div class="embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/EAQm2CKrWdU?si=STN_xj-1PkC4uRcm" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

## Accessing Multi-dimensional Array Elements

Next, we will look at a slightly more complicated example.  This time we will look at working with a 2D array.

Consider the following C code which sues a nested loop to access each element in a 2D array.

```c
for(int i = 0; i < rows; i++) {
    for(int j = 0; j < columns; j++) {
        printf("%d ", myArray[i][j]);
    }
    printf("\n");
}
```

Notice in the following assembly code how we calculate the offset of the array element using the number of columns in the array.  As far as the assembly code is concerned, the data in the array is just a contiguous block of memory.  

```ass
mov rax, 0          ; Initialize row index to 0
row_loop_start:
cmp rax, rows       ; Compare row index with total rows
jge row_loop_end    ; Jump to end if row index >= rows

mov rbx, 0          ; Initialize column index to 0
column_loop_start:
cmp rbx, columns    ; Compare column index with total columns
jge column_loop_end ; Jump to end if column index >= columns

; Calculate address of myArray[i][j]
mov rsi, rax        ; Move row index to rsi
imul rsi, columns   ; Multiply row index by total columns
add rsi, rbx        ; Add column index to get element index
mov rdi, myArray    ; Move array base address to rdi
lea rdi, [rdi + rsi*4] ; Calculate element address (assuming 4 bytes per int)
mov rdx, [rdi]      ; Move the value at address to rdx
; Code to print value in rdx

inc rbx             ; Increment column index
jmp column_loop_start ; Jump back to the start of the column loop
column_loop_end:

inc rax             ; Increment row index
jmp row_loop_start  ; Jump back to the start of the row loop
row_loop_end:
```

There are several more topics that we could dive into with regard to working with arrays at the assembly code level including how arrays are passed as function arguments, and how we would maintain arrays of structs.  But we haven't talked about structs yet, so let's get right on to that!
