# LC-3 Bubble Sort Program

This LC-3 assembly language program implements the "Bubble Sort" algorithm to sort 8 user-input numbers (ranging from 0 to 99) in ascending order, and outputs the sorted list onto the console.  It utlizes such LC-3 features like subroutines, stack operations, branching, and ASCII conversion.

### Project Objetives
- Apply core LC-3 concepts such as branching, looping, stack managemnet, subroutines, and input handling in a practical program.
- Support user input of up to 8 integers (0-99), stored them in an array, sorts using Bubble Sort, and display sorted output

### How To Assemble And Run
1. Open the LC-3 simulator (LC3Edit.exe)
2. Load the `BubbleSortProgram.asm` file
3. Assemble program in LC3Edit.
4. Load the BubbleSortProgram.obj in LC3 Simulator (Simulate.exe)
5. Run the program
6. Console will prompt you to enter 8 numbers
7. Input number between 0 - 99 (Format single digits ex. 01, 02, 03...)
8. Console will output inputed numbers in ascending order

   
### Test Case
Input:
11 08 02 17 06 04 03 21

Expected Output:
02 03 04 06 08 11 17 21

### Limitations
This program cannot handle three digit integers and negative integers. This program is unable to store more than 8 integers. 



###Files
`BubbleSortProgram.asm` - Main LC-3 Source Code

`README.md` - This documentation

`CIS11 Course Project Documentation.pdf` -  Project Objective & Flowchart

### Team Members
**Team Stacker**

-**Zayden Middleton**

-**Bienvenido Palma Jr**

-**Chris Shey Caponpon Enriquez**

### Course Info
**Assembly Programming**

**Dr. Nguyen**

**2025-06-11**
