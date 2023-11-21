; ----------------------------------------------------------
; Program Description: CMPR 154 - Final Project
; Author: Ben, Nathan, Eileen, Sean		
; Creation Date: 11/8/2023
; Collaboration: 
; ----------------------------------------------------------

include Irvine32.inc

.data
; user balance (initially 0)
balance DWORD 0

; maximum number of credits allowed
MAX_ALLOWED DWORD 20

; TODO figure out where this goes
errorMsg BYTE "ERROR: Maximum allowable credit is $20.00.",0dh,0ah,
			"Please, enter a different amount and try again.",0dh,0ah,0

; number of times the user guessed correctly
correctGuesses SDWORD 0

; # incorrect guesses
missedGuesses SDWORD 0

; user name
name BYTE 20 DUP(""), 0

; prompt user to input choice
choicePrompt BYTE "Please enter your choice (1-5): ", 0

; menu to display options
menu BYTE "*** Team Jurrasic's Guessing Game ***", 0dh,0ah,0dh,0ah,
			"*** MAIN MENU ***", 0dh,0ah,0dh,0ah,
			"Please Select one of the following options: ", 0dh,0ah,0dh,0ah,
			"	1. Display available balance", 0dh,0ah,
			"	2. Add credits to my account", 0dh,0ah,
			"	3. Play the game", 0dh,0ah,
			"	4. Display my statics", 0dh,0ah,
			"	5. Exit", 0dh,0ah,0


.code
main proc
	LOCAL shouldContinueLoop:BYTE
	mov shouldContinueLoop, 1

; TODO Welcome message (set name)

loopStart:

	call printMenu
	call Crlf

	call getChoice
	call Crlf

	call executeChoice

	call WaitMsg
	call Crlf
	call Crlf

	cmp shouldContinueLoop, 0
	jne loopStart

exit
main endp

; -----------------------------------------------
; printMenu
; -----------------------------------------------
; Does: Displays menu
; Receives: none
; Returns: void
; Requires: none
; -----------------------------------------------
printMenu proc USES EDX

	mov edx, OFFSET menu
	call WriteString

	ret
printMenu endp

; -----------------------------------------------
; getChoice
; -----------------------------------------------
; Does: Asks the user for input
; Receives: none
; Returns: uint choice in EAX
; Requires: none
; -----------------------------------------------
getChoice proc USES edx

	mov edx, OFFSET choicePrompt
	call WriteString
	call readDec
	
	; TODO implement error checking

	ret
getChoice endp

; -----------------------------------------------
; executeChoice
; -----------------------------------------------
; Does: Executes action based on user input
; Receives: none
; Returns: none
; Requires: userChoice in eax
; -----------------------------------------------
executeChoice proc 

	cmp eax, 1
	je option1
	cmp eax, 2
	je option2
	cmp eax, 3
	je option3
	cmp eax, 4
	je option4
	cmp eax, 5
	je option5

	option1:
		; call menu option 1

	option2:
		; call menu option 1

	option3:
		; call menu option 1

	option4:
		; call menu option 1

	option5:
		; call menu option 1

	ret
executeChoice endp

end main
