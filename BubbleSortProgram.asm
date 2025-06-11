.ORIG X3000

; ------------
; MAIN PROGRAM
; ------------

;JSR GET_INPUTS
JSR BUBBLE_SORT
;JSR DISPLAY_OUTPUT
HALT

; -----------
; SUBROUTINES
; -----------

;GET_INPUTS			; subroutine to obtain inputs

				; prompt user to input number from 0-99

	LEA R1, ARRAY		; R1 to point to array
	AND R2, R2, #0		; R2 for loop counter
				; loop 8 times to save to array

INPUT_LOOP
	LEA R0, PROMPT
	PUTS
	JSR GET_NUM 		; subroutine for getting two digit number
	STR R7, R1, #0
	LD R0, NEWLINE
	OUT
	ADD R1, R1, #1 		; increment address for array
	ADD R2, R2, #1 		; increment loop counter
	
				; exit condition should be when array is filled
				; array has length 8, so
	LD R3, ARR_SIZE		; i elected to use a label here instead of just #8 because it is reused so often
	NOT R3, R3
	ADD R3, R3, #1		; 2's comp
	ADD R3, R2, R3		; -8+loop counter
	BRn INPUT_LOOP		; If neg loop
	RET

GET_NUM
		

	; for this subroutine we want to get a number, multiply it by 10
	; then get another number and add it to the first.
	; remember the 5 bit limit (so you have to use registers to store values)
	; and ASCII offset
	GETC
	OUT
	LD R4, ASCII_OFFSET
	NOT R4, R4
	ADD R4, R4, #1
	ADD R0, R0, R4		; R0 - 48
	ADD R5, R0, R0		; R5 = R0 * 2
	ADD R6, R5, R5		; R6 = R0 * 4
	ADD R6, R6, R6		; R6 = R0 * 8
	ADD R6, R6, R5		; R6 = (8+2)*R0 = R0*10
	GETC
	OUT
	ADD R0, R0, R4
	ADD R0, R6, R0
	RET
	

BUBBLE_SORT			; subroutine for bubble sort
				; bubble sort will contain two loops, one increments down from 7 and triggers inner loop
				; refer to flowchart I made in documentation
	LD R6, ARR_SIZE

<<<<<<< HEAD
DISPLAY_OUTPUT
	
	;
	;	
	;
	; subroutine to output sorted array'
	; loop through array and print results with a space in between (x20 iirc). maybe use newline as well
=======
OUTER_LOOP
>>>>>>> c818771d45f9c7104d521228585fdb4a1dd14107

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

; ----
; VARS
; ----

NEWLINE		.FILL x0A
ASCII_OFFSET	.FILL x30
PROMPT		.STRINGZ "Input a number 0-99: "
ARRAY		.FILL x3200
ARR_SIZE	.FILL #8

.END

<<<<<<< HEAD
;TEST CHANGE 7
=======
>>>>>>> c818771d45f9c7104d521228585fdb4a1dd14107
