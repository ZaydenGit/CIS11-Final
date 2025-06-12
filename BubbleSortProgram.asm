.ORIG X3000

; ------------
; MAIN PROGRAM
; ------------

LD R6, STACK_TOP		; load stack
JSR GET_INPUTS
JSR BUBBLE_SORT
JSR DISPLAY_OUTPUT
HALT

; -----------
; SUBROUTINES
; -----------

GET_INPUTS			; subroutine to obtain inputs

				; prompt user to input number from 0-99
	ST R7, PARENT_R7
	JSR PUSH_ALL
	LD R1, ARRAY		; R1 to point to array
	LD R7, ARR_SIZE		; i elected to use a label here instead of just #8 because it is reused so often
				; loop 8 times to save to array
	

INPUT_LOOP
				; for this subroutine we want to prompt the user to enter a 2 digit number,
				; for each iteration get a number, multiply it by 10
				; then get another number and add it to the first.
				; remember the 5 bit limit (so you have to use registers to store values)
				; and ASCII offset
	ST R7, COUNTER

	LEA R0, PROMPT
	PUTS

	GETC			; get first character
	OUT
	ADD R2, R0, #0		; copy into r2
	LD R4, ASCII_OFFSET	
	NOT R4, R4
	ADD R4, R4, #1

	ADD R2, R2, R4		; R2 - ASCII offset = input
	BRn BAD_INPUT		; input validation
	LD R5, MAX_ASCII
	NOT R5, R5
	ADD R5, R5, #1
	ADD R5, R0, R5
	BRzp BAD_INPUT		; more input validation
				; multiply first digit by 10, so
	ADD R3, R2, R2		; R3 = input * 2
	ADD R2, R3, R3		; R2 = R3 * 2 = input * 4
	ADD R2, R2, R2		; R2 = input * 8
	ADD R3, R3, R2		; R3 = (8+2)*input = input*10
	GETC
	OUT
	ADD R2, R0, #0

	ADD R2, R2, R4		; num-2 - ASCII offset
	BRn BAD_INPUT		; input validation
	LD R5, MAX_ASCII
	NOT R5, R5
	ADD R5, R5, #1
	ADD R5, R0, R5
	BRzp BAD_INPUT

	ADD R4, R3, R2		; add two numbers together
	STR R4, R1, #0		; store in array
	LD R0, NEWLINE
	OUT
	ADD R1, R1, #1 		; increment address for array
	LD R7, COUNTER		; load counter
	ADD R7, R7, #-1
	BRp INPUT_LOOP		; If neg loop
	BR POP_ALL_AND_RET

BAD_INPUT

	LD R0, NEWLINE
	OUT
	LEA R0, BAD_MESSAGE
	PUTS
	LD R0, NEWLINE
	OUT
	BR INPUT_LOOP

BUBBLE_SORT			; subroutine for bubble sort
				; bubble sort will contain two loops, one increments down from 7 and triggers inner loop
				; refer to flowchart made in documentation
	ST R7, PARENT_R7
	JSR PUSH_ALL
	LD R7, ARR_SIZE

OUTER_LOOP

	ADD R7, R7, #-1 	; outer loop counter = n-1
	BRnz SORTED
	ADD R2, R7, #0
	LD R1, ARRAY		; point to first array element

INNER_LOOP

	LDR R3, R1, #0		; N'th element of array
	LDR R4, R1, #1		; N+1
	NOT R5, R4
	ADD R5, R5, #1
	ADD R5, R3, R5
	BRnz POST_SWAP		; if N-(N+1) is negative, N <= N+1 so elements are in order, no swap
	STR R4, R1, #0
	STR R3, R1, #1
	
POST_SWAP

	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp INNER_LOOP
	BRnzp OUTER_LOOP

SORTED BR POP_ALL_AND_RET

DISPLAY_OUTPUT			; subroutine to output sorted array'
				; loop through array and print results with a space in between (x20 iirc). maybe use newline as well
				; for a 2 digit number, divide by 10 and modulo by 10. 42/10 = 4, 42%10 = 2, so you get 4 and 2
	ST R7, PARENT_R7
	JSR PUSH_ALL
	LD R1, ARRAY		; load array into r1
	LD R5, ARR_SIZE		; load array size into r6
DISPLAY_LOOP
	ST R5, COUNTER		; store r5 in temp counter in memory
	AND R4, R4, #0

	LDR R3, R1, #0		; value of arr[R1]
	ADD R2, R3, #0		; copy r3
DIV_LOOP
	ADD R2, R2, #-10	; subtract (division is looped subtraction) by 10
	BRn DIV_EXIT		; if negative then number is fully divided
	ADD R4, R4, #1 		; quotient++
	BR DIV_LOOP
DIV_EXIT
	ADD R2, R2, #10		; since our remainder is the loop iterator, add 10 to get a positive value again
	LD R5, ASCII_OFFSET
	ADD R4, R4, R5
	ADD R2, R2, R5 

	ADD R0, R4, #0		; display r4
	OUT

	ADD R0, R2, #0		; display r2
	OUT

	LD R0, SPACE		; space in between numbers
	OUT
	
	ADD R1, R1, #1		; increment array pointer
	LD R5, COUNTER
	ADD R5, R5, #-1		; decrement array length iterator
	BRp DISPLAY_LOOP
	BR POP_ALL_AND_RET

PUSH_ALL
	ST R0, TEMP_R0		; store registers here and load after so as to not mess with their contents
	ST R1, TEMP_R1
	ST R7, INNER_STACK_R7
	ADD R1, R6, #-7		; check for all 7 spaces in memory instead of individually (7 spaces because we do not include r6)
	LD R0, STACK_BASE
	ADD R0, R0, R1 		; R7=(R6-7)-R7 = STACK-7-BOTTOM > 0
	BRn STACK_OVERFLOW
	LD R0, TEMP_R0		; loaded temp vals
	LD R1, TEMP_R1

	ADD R6, R6, #-1		; traverse down the stack
	STR R0, R6, #0		; save each register

	ADD R6, R6, #-1
	STR R1, R6, #0

	ADD R6, R6, #-1
	STR R2, R6, #0

	ADD R6, R6, #-1
	STR R3, R6, #0
	
	ADD R6, R6, #-1
	STR R4, R6, #0

	ADD R6, R6, #-1
	STR R5, R6, #0

	ADD R6, R6, #-1
	LD R7, PARENT_R7
	STR R7, R6, #0
	LD R7, INNER_STACK_R7

	RET
	
POP_ALL_AND_RET

	ADD R1, R6, #7		; no need to preserve registers here as they get overwritten in pop
	LD R0, STACK_TOP
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R1
	BRp STACK_UNDERFLOW	; if stack top is x4000, current stack + 7 - 4000 should be negative or zero
	
	LDR R7, R6, #0		; load value to register
	ADD R6, R6, #1		; traverse up stack

	LDR R5, R6, #0
	ADD R6, R6, #1
	
	LDR R4, R6, #0
	ADD R6, R6, #1

	LDR R3, R6, #0
	ADD R6, R6, #1

	LDR R2, R6, #0
	ADD R6, R6, #1

	LDR R1, R6, #0
	ADD R6, R6, #1

	LDR R0, R6, #0
	ADD R6, R6, #1

	RET
	

STACK_OVERFLOW	
	LEA R0, STACK_OFLOW_MSG
	PUTS 
	HALT

STACK_UNDERFLOW
	LEA R0, STACK_UFLOW_MSG
	PUTS
	HALT


; ----
; VARS
; ----

STACK_OFLOW_MSG	.STRINGZ "Stack overflow"
STACK_UFLOW_MSG	.STRINGZ "Stack underflow"

NEWLINE		.FILL x0A
ASCII_OFFSET	.FILL x30
PROMPT		.STRINGZ "Input a number 00-99: "
MAX_ASCII	.FILL x3A
BAD_MESSAGE	.STRINGZ "Character must be between 0 and 9"
ARRAY		.FILL x3200
ARR_SIZE	.FILL #8
SPACE		.FILL x20
STACK_BASE	.FILL xCD00	; -x3300
STACK_TOP	.FILL x4000

TEMP_R0		.BLKW 1
TEMP_R1		.BLKW 1
COUNTER		.BLKW 1
PARENT_R7	.BLKW 1
INNER_STACK_R7	.BLKW 1

.END