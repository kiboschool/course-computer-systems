# Assignment 4: A Simple CPU

For assignment 4, you will spend some time exploring a basic digital logic circuit, and adding additional capability to it ultimately resulting in a basic CPU.  For this, we will use the [CircuitVerse](https://circuitverse.org) tool.

The starter circuit ALU that you are provided with is shown below:

<iframe src="https://circuitverse.org/simulator/embed/alu-example-starter?theme=default&display_title=false&clock_time=false&fullscreen=false&zoom_in_out=false" style="border-width:; border-style: solid; border-color:;" name="myiframe" id="projectPreview" scrolling="no" frameborder="1" marginheight="0px" marginwidth="0px" height="500" width="500" allowFullScreen></iframe>

This circuit takes two data input bits (`A`, `B`) and a carry-in bit (`Cin`).  It produces a data bit (`F`) and a carry-out bit (`Cout)`).  Two additional control bits (`M1` and `M0`) are required to control what the output of the circuit is: `sum`, `and`, `or`, or `xor`.

You can change the values of the various inputs by clicking on the corresponding squares.  When you do so, the outputs will automatically update.  Begin by spending a few minutes exploring this circuit: observe how the output bits change based on the data inputs and the selector bits feeds into the mux. In this assignment, you will apply some of what we have learned this week to expand the circuit.

## Getting Started

To get started, follow these steps:

1. Click on this link to download the starter template: [Download Starter Template](https://drive.google.com/file/d/1jJlIJwtXt4d9Q4MSyc9s3duxqXbX7zq5/view?usp=sharing).
2. Click on this link [https://circuitverse.org/groups/7277/invite/m1NNyJ3LM6kg6J4RWj57KbGb](https://circuitverse.org/groups/7277/invite/m1NNyJ3LM6kg6J4RWj57KbGb) to join the CircuitVerse group for our class.  
3. Click on the Google icon below the login page to login using your Kibo School Google Account.
4. On your Circuitverse Dashboard, once you have logged in, click on Launch for Assignment 4.  This will create a new workspace that you should complete your work in for this assignment.
5. Finally, upload the starter template to your new workspace by using the "Project" -> "Import File" menu option, selecting the file that you downloaded in Step 1, and clicking ok.  

Upon creating your project, click on "Help" -> "Tutorial Guide" to get an in-tool guide showing you how to use this tool.

You can click on the varying tabs of the circuit to see some of the sub-components that make up the single-bit ALU: the full adder, which uses two half adders to add two bits; and the 4:1 mux, which allows selecting between one of the four inputs to propagate to the output based on two selection bits.

> This tool does not automatically save your work.  Be sure to select the option to "Save Online" frequently so that you don't lose your work.

## Part 1: Fix the Error (20 pts)

The existing circuit contains a logic error somewhere in it.  The logic error may be in the main circuit or one of the the sub-circuits.  You have completed this task once the 1-bit ALU produces the correct outputs for all possible inputs.

## Part 2: Create an 8 bit ALU (40 pts)

In the second part of the assignment, your task is to create an 8-bit ALU by stringing together multiple single-bit ALUs.

1. Click on the "Circuit" menu and selection "New Circuit".
2. Call the circuit "8-bit ALU".
3. Within the new tab, right-click and select "Insert Sub Circuit" to add new copies of circuits in your workspace.  You will need to add 8 copies of the single-bit ALU.
4. If you need any additional basic digital logic components, you can search for them in the "Circuit Elements" menu and add them to your design.  In particular, you will need multiple copies of the Input and Output pins.

When complete, your 8-bit ALU should have an two 8-bit data inputs (`A[7:0]` and `B[7:0]`), an 8 bit data output (`O[7:0]`), a carry-out bit, and two bit opcode inputs that are used to specifiy what operation the ALU will perform.  

## Part 3: Build a Mini-CPU (40 pts)

Finally, you are going to use your 8-bit ALU together with some registers and a clock to implement a basic CPU that has 4 operations (`add`, `and`, `or`, and `xor`), and 4 registers (`r0`, `r1`, `r2`, and `r3`).

The instruction format will be as follows:

| opcode | src    | dest   | padding   |
| ------ | ------ | ------ | --------- |
| 2 bits | 2 bits | 2 bits | `00`      |

The opcodes are as follows, which you may have observed from the previous parts of the assignment:

| Operation | opcode |
| ----------| :------- |
| `add`     | `00`     |
| `and`     | `01`     |
| `or`      | `10`     |
| `xor`     | `11`     |

The registers are addressed as follows:

| register | address |
| --------| :------- |
| `r0`    | `00`     |
| `r1`    | `01`     |
| `r2`    | `10`     |
| `r3`    | `11`     |

So, some example instructions, their binary representation, and  are as follows:

| Instruction   | Binary representation   | Operation     |
| ------------- | :---------------------- | ------------- |
| `add r0 r2`   | 00001000                | r2 = r0 + r2  |
| `and r1 r3`   | 01011100                | r3 = r1 & r3  |
| `or r2 r2`    | 10101000                | r2 = r2 \| r2 |
| `xor r3 r1`   | 11110100                | r1 = r3 ^ r1  |

You will create another tab in your workspace to contain the circuit, and along the way to keep things organized, you may want to create additional sub-circuits.  You will want to make use of the following components (available within the built-in library) as well:

* D Flip-Flop - This will be useful for building your register.  You may note that the D Flip Flop in the library has some additional inputs that we didn't see in our example in the weekly reading.  You may want to experiment with it a little bit to understand how they function.
* Button Input - When pressed, emits a 1.  When released, emits a 0.  This can be used to simulate the clock, which you will need to trigger the updating of values in the registers.  
* Multiplexer - For selecting which registers the two inputs of the ALU should be read from.
* Demultiplexer - For selecting which register the output of the ALU should be written to.

The main element missing from this CPU is memory from which instructions would be read.  Instead, you'll have to manually configure the inputs for the instruction you want to execute, and trigger the clock to cause the instruction to be executed.

> **Note**: Since our instruction encoding doesn't have any mechanism to provide immediate values or to read values into registers from memory, you may have to manually set values in your register (other than 0) to see that the calculations are working as expected. As a bonus exercise, how could you modify the ISA and the corresponding circuit to support allowing immediate values in the instructions?  

## Submitting Your Work

Your work must be submitted to Anchor for degree credit and to Gradescope for
grading.

1. After you have finished designing your circuits using the instructions above, save a  images for all of the circuits in your project ("Tools" -> "Download Image" with the options PNG, Full Circuit View, and 1X).
2. Export your project using the "Project" -> "Export as File" menu option.  This will produce a `.cv` file.
3. Zip these files into a single zip archive.
4. Upload the zip archive to Anchor below.
5. Upload your zip archive to [Gradescope](https://www.gradescope.com) via the
   appropriate submission link.