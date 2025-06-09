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

;prompt user to input number from 0-99

LEA R1, ARRAY			; R1 to point to array
AND R2, R2, #0			; R2 for loop counter
; loop 8 times to save to array

INPUT_LOOP
	LD R0, PROMPT
	OUT
	JSR GET_NUM 		; subroutine for getting two digit number
	STR R0, R1, #0
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

BUBBLE_SORT	; subroutine for bubble sort
	; bubble sort will contain two loops, one increments down from 7 and triggers inner loop
	; refer to flowchart I made in documentation

DISPLAY_OUTPUT	; subroutine to output sorted array'
	; loop through array and print results with a space in between (x20 iirc). maybe use newline as well


; ----
; VARS
; ----

ASCII_OFFSET	.FILL X30
PROMPT	.STRINGZ "Input a number 0-99: "
ARRAY	.BLKW 8
ARR_SIZE	.FILL #8

.END