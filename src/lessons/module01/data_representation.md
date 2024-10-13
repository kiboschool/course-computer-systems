# Bits, Bytes, and Data Representation

## The Binary World

Every digital device speaks the language of bits, the tiniest units of data in computing. These binary digits, 0 and 1,
are the foundation of all modern computer systems. A single bit is like a light switch—it can either be in the off
position, represented by a '0', or in the on position, represented by a '1'. Despite their simplicity, when combined,
bits have the power to represent any form of data—be it text, images, or sound.

<div class="embed"><iframe src="https://www.youtube-nocookie.com/embed/M41M9ATm49M" title="Binary and Bits" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>

> ❓ **Test Your Knowledge**
>
> Consider a series of 8 light switches, each corresponding to a bit. How many unique patterns can you create with the
> switches being in either the on or off positions.

## Bytes: Grouping Bits

While a bit represents a binary state, a byte, composed of 8 bits, is the standard unit for organizing and processing
data. The 8 bits in a byte are enough to represent 256 different values, which can be anything from numbers to to
floating point values to characters. Larger data measurements build upon bytes, with kibibytes (KiB), mebibytes (MiB),
gibibytes (GiB), and so on.  A KiB is 1024 bytes, a MiB is 1024 KiB (or 1024*1024 bytes), and so on.

You may be thinking, "I've always heard them referred to as kilobytes, megabytes, gigabytes, etc. What's with this kibi,
mebi, gibi stuff?"  Or you may be thinking, "why 1024 instead of 1000?".  Well, you're correct to ask these questions?
Historically, since computers are based on binary systems, we generally count in powers of 2, and 1024 is equal to 2^10.
It also used to be the case that we used the prefixes kilo, mega, giga, etc. referring to these. But for marketing
purposes, hard drive manufacturers stuck to counting bytes using a base ten system, claiming they just follow
[International System of Units](https://en.m.wikipedia.org/wiki/International_System_of_Units), which created growing
confusion among customers. To resolve the concerns, the idea of new prefixes for the base 2 counting was born (kibi,
mibi, tebi, etc.) and standardized as [IEEE 1541-2002](https://en.m.wikipedia.org/wiki/IEEE_1541-2002). Many people
haven't adopted the updated terminology and so you will hear both.

| Size in Bytes (Binary)           | Binary Term (IEC Standard) | Size in Bytes (Decimal)           | Decimal Term    |
| ---------------------------------- | ---------------------------- | ----------------------------------- | ----------------- |
| 1 (2^0)                          | 1 Byte                     | 1 (10^0)                          | 1 Byte          |
| 1,024 (2^10)                     | 1 Kibibyte (KiB)           | 1,000 (10^3)                      | 1 Kilobyte (KB) |
| 1,048,576 (2^20)                 | 1 Mebibyte (MiB)           | 1,000,000 (10^6)                  | 1 Megabyte (MB) |
| 1,073,741,824 (2^30)             | 1 Gibibyte (GiB)           | 1,000,000,000 (10^9)              | 1 Gigabyte (GB) |
| 1,099,511,627,776 (2^40)         | 1 Tebibyte (TiB)           | 1,000,000,000,000 (10^12)         | 1 Terabyte (TB) |
| 1,125,899,906,842,624 (2^50)     | 1 Pebibyte (PiB)           | 1,000,000,000,000,000 (10^15)     | 1 Petabyte (PB) |
| 1,152,921,504,606,846,976 (2^60) | 1 Exbibyte (EiB)           | 1,000,000,000,000,000,000 (10^18) | 1 Exabyte (EB)  |

> ❓ **Test Your Knowledge**
>
> If one book page contains approximately 2,000 characters, estimate the number of pages that can fit into 1MB of
> storage.

## Encoding Characters: ASCII and Unicode

Characters on a computer are represented using character encoding standards. ASCII (American Standard Code for
Information Interchange) was one of the first coding schemes, using 7 bits to represent 128 unique characters. However,
with the rise of global communication, the need for more characters became evident. Unicode was introduced to resolve
this, providing a comprehensive character set that supports most of the world’s writing systems.

[ASCII Characters](https://en.wikipedia.org/wiki/ASCII) [Unicode
Characters](https://en.wikipedia.org/wiki/List_of_Unicode_characters)

> ❓ **Test Your Knowledge**
>
> Encode your name in both ASCII and Unicode, noting any differences in the process or results.
