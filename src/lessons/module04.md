# Processor Architecture

We have spent the last couple of weeks diving into machine representation, particularly how higher level programming constructs are represented in assembly code, which can be more directly interpreted by the Central Processing Unit.  This week we will get into more details on how those instructions are actually executed by the hardware.  To do this, we will review the main components in the processor and how they are constructed using logic gates.  We will look at a few examples of basic digital circuits for performing computations (like addition), and then we will see how these digital circuits can be combined to form more complex circuits which are capable of executing the assembly programs we have been learning about.  Finally, we will conclude with some concepts around how we can maximize the efficiency of processors.

Note, that we will not be diving extremely deeply into these concepts.  Entire courses could be taught in just digital logic design.  However, we aim to provide sufficient details that you have a strong idea of the connective tissue ensuring that you have a strong idea of how things work.  An understanding of how processors work will aid your overall understanind og how computer systems wok as a whole.  

## Topics Covered

- Basic Components of a Processor
- Logic Gates and basic digital circuit design
- Combination vs. Sequential circuits and execution
- Clock cycles and clock rate
- Pipelining Overview

## Learning Outcomes

After this week, you will be able to:

- Identify and describe the function of the core components within a processor, including the ALU, control unit, registers, and cache.
- Understand and apply the basic principles of digital logic gates in circuit design.
- Differentiate between combinational and sequential circuits and their uses in processor design.
- Define what a clock cycle is and how the clock rate affects processor performance.
- Explain the concept of pipelining and its impact on processor performance and potential issues such as pipeline hazards.
