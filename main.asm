; ----------------------------------------------------------
; Program Description: CMPR 154 - Final Project
; Author: Ben, Nathan, Eileen, Sean		
; Creation Date: 11/8/2023
; Collaboration: 
; ----------------------------------------------------------

include Irvine32.inc

.data
; declaring balance to zero
balance DWORD 0

; declaring credits to the maxed number, 20
MAX_NUM DWORD 20

; 
errorMsg BYTE "ERROR: Maximum allowable credit is $20.00.",0dh,0ah,
			"Please, enter a different amount and try again.",0dh,0ah,0

; Entering the variable to guess a number correctly
val1 SDWORD 0

; Entering any incorrect number
val2 SDWORD 0

; Entering the user's name
name BYTE 20 DUP(""), 0


; choosing the options
choose BYTE "1. Display available balance", 0dh,0ah,
			"2. Add credits to my account", 0dh,0ah,
			"3. Play the game", 0dh,0ah,
			"4. Display my statics", 0dh,0ah,
			"5. Exit", 0dh,0ah,0

.code
main proc



exit
main endp
end main
