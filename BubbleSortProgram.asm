.ORIG X3000

; ------------
; MAIN PROGRAM
; ------------

JSR GET_INPUTS
JSR BUBBLE_SORT
JSR DISPLAY_OUTPUT
HALT

; -----------
; SUBROUTINES
; -----------

GET_INPUTS			; subroutine to obtain inputs

				; prompt user to input number from 0-99

	LD R1, ARRAY		; R1 to point to array
	LD R6, ARR_SIZE		; i elected to use a label here instead of just #8 because it is reused so often
				; loop 8 times to save to array

INPUT_LOOP
				; for this subroutine we want to prompt the user to enter a 2 digit number,
				; for each iteration get a number, multiply it by 10
				; then get another number and add it to the first.
				; remember the 5 bit limit (so you have to use registers to store values)
				; and ASCII offset
	LEA R0, PROMPT
	PUTS

	GETC
	OUT
	ADD R2, R0, #0
	LD R4, ASCII_OFFSET
	NOT R4, R4
	ADD R4, R4, #1

	ADD R2, R2, R4		; R2 - ASCII offset = input
	BRn BAD_INPUT		; input validation
	LD R5, MAX_ASCII
	NOT R5, R5
	ADD R5, R5, #1
	ADD R5, R0, R5
	BRzp BAD_INPUT

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

	ADD R4, R3, R2
	STR R4, R1, #0
	LD R0, NEWLINE
	OUT
	ADD R1, R1, #1 		; increment address for array
	
	ADD R6, R6, #-1
	BRp INPUT_LOOP		; If neg loop
	BR BUBBLE_SORT

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
				; refer to flowchart I made in documentation
	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	LD R6, ARR_SIZE

OUTER_LOOP

	ADD R6, R6, #-1 	; outer loop counter = n-1
	BRnz DISPLAY_OUTPUT
	ADD R2, R6, #0
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

DISPLAY_OUTPUT			; subroutine to output sorted array'
				; loop through array and print results with a space in between (x20 iirc). maybe use newline as well
				; for a 2 digit number, divide by 10 and modulo by 10. 42/10 = 4, 42%10 = 2, so you get 4 and 2
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
	AND R6, R6, #0
	LD R1, ARRAY		; load array into r1
	LD R6, ARR_SIZE		; load array size into r6

DISPLAY_LOOP
	
	LDR R3, R1, #0		; value of arr[R1]
	
	AND R2, R2, #0		; clear registers
	AND R4, R4, #0
	AND R5, R5, #0

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
	ADD R6, R6, #-1		; decrement array length iterator
	BRp DISPLAY_LOOP

	LD R0, NEWLINE		; print newline after
	OUT
	HALT
	

; ----
; VARS
; ----

NEWLINE		.FILL x0A
ASCII_OFFSET	.FILL x30
PROMPT		.STRINGZ "Input a number 0-99: "
MAX_ASCII	.FILL x3A
BAD_MESSAGE	.STRINGZ "Character must be between 0 and 9"
ARRAY		.FILL x3200
ARR_SIZE	.FILL #8
SPACE		.FILL x20

.END

