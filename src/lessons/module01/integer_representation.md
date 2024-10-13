# Integer Representation and Arithmetic

Computers use the binary number system, which consists of only two digits: 0 and 1. This system, i.e. "Base 2", is the
foundation for storing and manipulating data in computing devices. This section covers the binary representation of
numbers, including both unsigned and signed integers, and explains binary arithmetic operations such as addition and
subtraction.  Even though you have previously covered this material in Mathematical Thinking, and will do so again in
Discrete Mathematics, we will review it here.

## Binary Representation of Integers

Unsigned integers are binary numbers that represent only positive values or zero. For example, in an 8-bit unsigned
integer, the binary number `00000001` represents the decimal value 1, while `11111111` represents 255.

The value of an unsigned binary number is calculated by summing the powers of 2 for each bit position that contains a 1.
For instance, `1010` in binary (assuming a 4-bit system) is equal to \(2^3 + 2^1 = 8 + 2 = 10\) in decimal.

Sometimes it helps to visualize this as a table.  Where each column, starting from the right is a power of 2.  The
presence of a 0 or 1 in the binary representation indicates if we should include that column in the calculation.

| Powers of 2 | 2^3   | 2^2   | 2^1   | 2^0   |
|  :----      | :---: | :---: | :---: | :---: |
| Place       |  Eights   |  Fours   |  Twos   |  Ones   |
|             |  \*   |  \*   |  \*   |  \*   |
| Binary Value| `1`   | `0`   | `1`   | `0`   |
|             |  =    |  =    |  =    |  =    |
| Product     |  8    |  0    |  2    |  0    |

And finally, 8 + 2 = 10.

For comparison, the decimal system behaves the same way, as in the example below.

| Powers of 10  | 10^3  | 10^2  | 10^1  | 10^0  |
| :---          | :---: | :---: | :---: | :---: |
| Place         | Thousands | Hundreds  | Tens   | Ones    |
|               |  \*   |  \*   |  \*   |  \*   |
| Decimal Value | **4** | **0** | **3** | **2** |
|               |  =    |  =    |  =    |  =    |
| Product       |  4000 |  0    |  30   |  2    |

> ❓ **Test Your Knowledge**
>
> Base 2 (Binary) and base 10 (Decimal) systems aren't special.  In fact, we could have base 3 or base 4 systems, or
> even Base 8349 systems.  In fact, in computer science, we commonly use base 8 (Octal) or base 16 (hexadecimal) systems
> also.  Given the octal value 2631, what is this in decimal?

## Representing Negative Values

So how do we represent negative numbers in binary? When humans do math, we usually just throw a negative sign in front
of the value to show that it is negative.  However, computers don't have negative signs! Instead, we use a
representation known as **Two's Complement**. In two's complement, negative numbers are represented differently from
their positive counterparts. The highest bit (most significant bit) is used as the sign bit: 0 for positive numbers and
1 for negative numbers.  To find the negative of a number, invert all the bits (changing 0s to 1s and vice versa) and
then add 1. For example, to represent -3 in an 4-bit system, start with the binary of +3 (`0011`), invert the bits
(`1100`), and add 1 (`1101`).  

This seems a bit funky.  Why does this work?  To build some intuition, let's start with a smaller version that's easier
to think about; say 3 bits. If we use those three bits to represent only unsigned values, the minimum value we can
represent is 0 (`000`) and the maximum value we can represent is 7 (`111`).  Now, let's look at what all the possible
3-bit values are in twos complement (remember, flip the bits and add 1):

| Signed Decimal    | -4    | -3    | -2    | -1    | 0     | 1     | 2     | 3     |
| :---------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ------|
| Twos Complement   | `100` | `101` | `110` | `111` | `000` | `001` | `010` | `011` |
| Unsigned Value    |  4    | 5     | 6     | 7     | 0     | 1     | 2     | 3     |

From this table, you can see that now the minimum number we can represent is -4 (`100`) and the maximum number that we
can represent is 3 (`011`). So we are basically mapping all the binary values that begin with a 1 to a negative value.
Twos complement makes doing binary arithmetic with signed number very convenient as well.  We will see some examples in
a bit.  

> ❓ **Test Your Knowledge**
>
> Convert the decimal number -14 to an 8-bit two's complement binary number.  If your answer was interpreted as an
> unsigned binary value instead of a twos complement value, what would its decimal value be?

## Binary Arithmetic

Binary addition and subtraction are fundamental operations that are performed by the Arithmetic Logic Unit (ALU) of a
computer's CPU. Understanding how these operations work in binary gives insight into the basic functioning of computers.

### Addition

1. **Process:** Binary addition works similarly to decimal addition but with two digits. You add bit by bit, starting
   from the least significant bit (rightmost bit).
2. **Carry Over:** If the sum of two bits is 2 (binary 10), the 0 is written in the sum, and a 1 is carried over to the
   next higher bit.

Example:

```text
   1101  (13 in decimal)
 + 0111  (7 in decimal)
 -------
  10100  (20 in decimal)
```

### Subtraction

This is where the beauty of twos complement comes in!  Subtraction is simply the addition of a positive number and the
negation of another number. In other words, to subtract B from A, all we need to do is add A to the two's complement of
B.

Example:

```text
A = 1010 (10 in decimal)
B = 0101 (5 in decimal)

Two's complement of B = 1011

Now add A and two's complement of B:

  1010
+ 1011
-------
 10101 (The leftmost bit is the carry, which is discarded in an 4-bit system, resulting in 0101 or 5 in decimal)
```

In summary, computers use binary representation to handle all sorts of data. Understanding binary arithmetic, including
the representation of unsigned and signed integers, is fundamental to grasping how computers perform basic arithmetic
operations.

> ❓ **Test Your Knowledge**
>
> Perform the binary addition of `1101` and `1011`. What happens if there is an overflow (when the number of bits that
> we have is insufficient to represent the sum)?
