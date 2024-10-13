# Types of Optimizations

The following video is a bit long, but it gives a very nice introduction to a wide variety of different approaches and considerations (with several examples) when working to optimize software. Please take the time to watch it before proceeding.

As you watch this video, keep your ear out for justifications for why the approach is valuable based on computer architectures or how CPUs operate.

<div class="embed"><iframe width="560" height="315" src="https://www.youtube.com/embed/H-1-X9bkop8?si=eBNKpGbXwlN5FIrl" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe></div>

## Summary 

To summarize, and for your future reference, four categories of the "New Bentley Rules" were introduced with each category containing several methods:

1. Data Structures
   - Packing and Encoding - The idea of packing is to store more than one data value in a machine word.  The related idea of encoding is to convert data values in a representation requiring fewer bits.
   - Augmentation - Add information to a data structure to make common operations do less work.
   - Pre-computation - Perform calculations in advance to avoid doing them at "mission-critical" times.
   - Compile-time initialization - Store values of constants during compilation, saving work at execution time.
   - Caching - Store results that have been accessed recently so that the program need not compute them again.
   - Lazy Evaluation
   - Sparsity - Avoid storing and computing on zeroes. ("Fhe fastest way to compute is to not compute at all.")
2. Logic
   - Constant folding and propagation - Evaluate constant expressions and substitute the result into further expressions, all during compilation.
   - Common sub-expression elimination - Avoid computing the same expression multiple times by evaluating the expression once and storing the result for later use.
   - Algebraic Identities - Replace expensive algebraic expressions with algebraic equivalents that require less work.
   - Short-circuiting - When performing a series of tests, stops evaluation as soon as you know the answer.
   - Ordering Tests - In code that executes a sequence of logical tests, perform those are are more often "successful" before tests that are rarely successfully.  Similarly, inexpensive tests should precede expensive ones.
   - Creating a fast path - Test for simpler cases with less expensive operations, before doing the more complicated cases.
   - Combining Tests - Replace a sequence of tests with one test or switch.
3. Loops
   - Hoisting - avoid recomputing loop-invariant code each time through the body of the loop.
   - Sentinels - Leverage special dummy values places in data structure to simplify the logic of boundary conditions and, in particular, the handling of loop-exist tests.
   - Loop Unrolling - Attempts to save work by combining several consecutive iterations of a loop into a single iteration, thereby reducing the total number of iterations of the loop and, consequently, the number of times that the instruction that control the loop must be executed.
   - Loop Fusion - Combine multiple loops over the same index range into a single loop body, thereby save the overhead of loop control.
   - Eliminating Wasted Iterations - Modify loop bounds to avoid executing loop iterations over essentially empty loop bodies.
4. Functions
   - Inlining - Avoid the overhead of a function call by replacing a call to the function with the body of the function itself.
   - Tail-recursion Elimination - Replace a recursive call that occurs as the last step of a function with a branch, saving function-call overhead.
   - Coarsening Recursion - Increase the size of the base case and handle it with more efficient code that avoids function-call overhead.
  
*Source: https://ocw.mit.edu/courses/6-172-performance-engineering-of-software-systems-fall-2018/resources/mit6_172f18_lec2/*

> **Note:** Premature optimization should be avoided.  It can lead to unnecessary complexity in code, making it difficult to read, maintain, and debug. It often involves focusing on performance improvements before fully understanding the system's actual needs and bottlenecks, potentially wasting time optimizing parts of the code that have little impact on overall performance. A better alternative is to first ensure your program is correct, and then devote effort to optimizing the portions of the code that are the largest bottlenecks.