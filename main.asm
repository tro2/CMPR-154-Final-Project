; ----------------------------------------------------------
; Program Description: CMPR 154 - Final Project
; Author: Ben, Nathan, Eileen, Sean		
; Creation Date: 11/8/2023
; Collaboration: 
; ----------------------------------------------------------

include Irvine32.inc

; -----------------------------------------------
.data
; -----------------------------------------------

; user balance
balance DWORD 0

; maximum number of credits allowed to be added at a time
MAX_ALLOWED DWORD 20

correctGuesses SDWORD 0
missedGuesses SDWORD 0
moneyWon SDWORD 0
moneyLost SDWORD 0

; variable for storing loop
shouldContinueLoop DWORD 1


; -----------------------------------------------
; user name
_name BYTE 15 DUP(" "), 0

; prompt user to input name
namePrompt1 BYTE	"Hello! Welcome to Team ",0
namePrompt2 BYTE	"'s Guessing Game!", 0dh, 0ah,
					"Please enter your name (max of 15 characters): ", 0

; -----------------------------------------------
; prompt user to input menu choice
choicePrompt BYTE "Enter your choice (1-5): ", 0

; error message for choicePrompt
errorChoicePrompt BYTE "=> Error: Choice is not within bounds. Please try again.", 0


; -----------------------------------------------
; menu to display options
menu1 BYTE	"*** Team ",0
menu2 BYTE	"'s Guessing Game ***", 0dh,0ah,0dh,0ah,
			"*** MAIN MENU ***", 0dh,0ah,0dh,0ah,
			"Please Select one of the following options: ", 0dh,0ah,0dh,0ah,
			"	1. Display available balance", 0dh,0ah,
			"	2. Add credits to my account", 0dh,0ah,
			"	3. Play the game", 0dh,0ah,
			"	4. Display my statistics", 0dh,0ah,
			"	5. Exit", 0dh,0ah,0

; -----------------------------------------------
; menu option 1
msgBalance BYTE 'Your balance is: ', 0

; -----------------------------------------------
; menu option 2
addPrompt BYTE "Please enter the amount you would like to add: ",0
errorMsg BYTE "=> ERROR: You can only add between 1 and 20 dollars to your account!",0dh,0ah,
			"=> Please, enter an valid amount and try again.",0dh,0ah,0

; -----------------------------------------------
; menu option 3
guessPrompt BYTE "Welcome to the guessing game! The cost to play is $1.00.", 0dh,0ah, 0dh, 0ah,
				 "Guess a number between 1 and 10: ", 0
winMsg BYTE "Congratuations, you guessed correctly! Here's your $2.00!",0
loseMsg BYTE "Oh! Sorry, you guessed incorrectly. The correct answer was: ", 0
redoPrompt BYTE "Would you like to play again? (y/n): ", 0
brokeMsg BYTE "Uh oh! You have no money in your account, add some before playing again!", 0

; -----------------------------------------------
; menu option 4
msgName				BYTE "'s Statistics", 0
msgAvailableCredit	BYTE "Available credit: ", 0
msgGamesPlayed		BYTE "Games played:     ", 0
msgCorrectGuesses	BYTE "Correct Guesses:  ", 0
msgMissedGuesses	BYTE "Missed Guesses:   ", 0
msgMoneyWon			BYTE "Money you won:    ", 0
msgMoneyLost		BYTE "Money you lost:   ", 0


; -----------------------------------------------
.code
; -----------------------------------------------
main proc

; set default text color
mov eax, yellow
call SetTextColor

call getName
call Clrscr

loopStart:
	call printMenu
	call Crlf

	call getChoice
	call Crlf

	call executeChoice

	call Crlf
	call WaitMsg
	call Clrscr

	cmp shouldContinueLoop, 0
	jne loopStart

next:
	; exit the program message

exit
main endp

; -----------------------------------------------
; printJurrassic
; -----------------------------------------------
; Does: Prints "Jurrasic" in rainbow text to the console
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
printJurassic proc
	pushad

	; print "Jurrasic" in rainbow color

	mov eax, lightRed
	call SetTextColor
	mov al, 'J'
	call WriteChar

	mov eax, yellow
	call SetTextColor
	mov al, 'u'
	call WriteChar

	mov eax, green
	call SetTextColor
	mov al, 'r'
	call WriteChar

	mov eax, lightGreen
	call SetTextColor
	mov al, 'a'
	call WriteChar

	mov eax, lightCyan
	call SetTextColor
	mov al, 's'
	call WriteChar

	mov eax, lightBlue
	call SetTextColor
	mov al, 's'
	call WriteChar

	mov eax, blue
	call SetTextColor
	mov al, 'i'
	call WriteChar

	mov eax, magenta
	call SetTextColor
	mov al, 'c'
	call WriteChar

	; reset color

	mov eax, yellow
	call SetTextColor

	popad
	ret
printJurassic endp

; -----------------------------------------------
; getName
; -----------------------------------------------
; Does: gets user's name and sets global variable
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
getName proc
	pushad

prompt:
	mov EDX, OFFSET namePrompt1
	call WriteString
	call printJurassic
	mov EDX, OFFSET namePrompt2
	call WriteString
	
	mov EDX, OFFSET _name
	mov ECX, 16
	call ReadString

	popad
	ret
getName endp

; -----------------------------------------------
; printMenu
; -----------------------------------------------
; Does: prints choice menu
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
printMenu proc
	pushad

	mov EDX, OFFSET menu1
	call WriteString
	call printJurassic
	mov EDX, OFFSET menu2
	call WriteString

	popad
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
getChoice proc
	push edx

prompt:
	mov edx, OFFSET choicePrompt
	call WriteString

	call readDec
	
	cmp EAX, 0
	jz error
	cmp EAX, 5
	ja error
	jmp next

error:
	mov eax, red
	call SetTextColor
	mov edx, OFFSET errorChoicePrompt
	call WriteString
	mov eax, yellow
	call SetTextColor
	call Crlf
	jmp prompt

next:
	pop edx
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
	call menuOption1
	jmp next
option2:
	call menuOption2
	jmp next
option3:
	call menuOption3
	jmp next
option4:
	call menuOption4
	jmp next
option5:
	call menuOption5
	
next:
	ret
executeChoice endp

; -----------------------------------------------
; menuOption1 - displayBalance
; -----------------------------------------------
; Does: Displays User's Balance
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
menuOption1 proc
	pushad

	mov edx, OFFSET msgBalance
    call WriteString
	mov eax, lightGreen
	call SetTextColor
	mov eax, balance
	call displayBalance
	mov eax, yellow
	call SetTextColor

	popad
	ret
menuOption1 endp


; -----------------------------------------------
; displayBalance helper
; -----------------------------------------------
; Does: Formats and prints number as money
; Receives: none
; Returns: none
; Requires: number to display in eax
; -----------------------------------------------
displayBalance proc
	pushad
	
	; moving balance out of the way
	mov ebx, eax

	mov al, '$'
	call WriteChar

	; moving it back in
	mov eax, ebx
    call WriteDec
	mov al, '.'
	call WriteChar
	mov al, '0'
	call WriteChar
	mov al, '0'
	call WriteChar

	popad
	ret
displayBalance endp

; -----------------------------------------------
; menuOption2 - Add credits to balance
; -----------------------------------------------
; Does: Adds user input credits to balance
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
menuOption2 proc
	pushad

enterAmount: 
    mov edx, OFFSET addPrompt
    call WriteString
    call ReadInt

	cmp eax, 0
	jz error
    cmp eax, MAX_ALLOWED
    JA error
    add balance, eax
    jmp next

error:
	mov eax, red
	call SetTextColor
    mov edx, OFFSET errorMsg
    call WriteString
	mov eax, yellow
	call SetTextColor
    jmp enterAmount

next:
	popad
	ret
menuOption2 endp

; -----------------------------------------------
; menuOption3 - play guessing game
; -----------------------------------------------
; Does: Plays the guessing game, alters balance and try counters
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
menuOption3 proc
	pushad
	
guess:
	cmp balance, 0
	jle noMoney
	dec balance

	call Randomize
	mov EAX, 10
	call RandomRange
	inc EAX
	mov EBX, EAX

	mov EDX, OFFSET guessPrompt
	call WriteString
	call ReadDec

	cmp EAX, EBX
	jnz incorrect

correct:
	inc correctGuesses
	add moneyWon, 2
	call Crlf
	mov EDX, OFFSET winMsg
	call WriteString
	call Crlf
	jmp redo

incorrect:
	inc missedGuesses
	inc moneyLost
	call Crlf
	mov EDX, OFFSET loseMsg
	call WriteString
	mov EAX, EBX
	call WriteDec
	call Crlf

redo:
	mov EDX, OFFSET redoPrompt
	call WriteString
	call ReadChar
	call Crlf

	cmp al, 'y'
	jz guess
	jmp next

noMoney:
	mov EAX, lightRed
	call SetTextColor
	mov EDX, OFFSET brokeMSG
	call WriteString
	mov EAX, yellow
	call SetTextColor

next:
	popad
	ret
menuOption3 endp

; -----------------------------------------------
; menuOption4 - display stats
; -----------------------------------------------
; Does: display user statistics
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
menuOption4 proc
	pushad
	
	; Display name
    mov edx, OFFSET _name
    call WriteString
    mov edx, OFFSET msgName
	call WriteString
	call Crlf
	call Crlf
	
    mov edx, OFFSET msgAvailableCredit
    call WriteString
	mov eax, lightGreen
	call SetTextColor
	mov eax, balance
    call displayBalance
	mov eax, yellow
	call SetTextColor
    call Crlf

    ; Display games played
    mov edx, OFFSET msgGamesPlayed
    call WriteString
    mov eax, correctGuesses
    add eax, missedGuesses
    call WriteDec
    call Crlf

    ; Display correct guesses
    mov edx, OFFSET msgCorrectGuesses
    call WriteString
    mov eax, correctGuesses
    call WriteDec
    call Crlf

    ; Display missed guesses
    mov edx, OFFSET msgMissedGuesses
    call WriteString
    mov eax, missedGuesses
    call WriteDec
    call Crlf

    ; Display money you won
    mov edx, OFFSET msgMoneyWon
	call WriteString
    mov eax, lightGreen
	call SetTextColor
	mov eax, moneyWon
    call displayBalance
	mov eax, yellow
	call SetTextColor
    call Crlf 

    ; Display money you lost
    mov edx, OFFSET msgMoneyLost
    call WriteString
    mov eax, lightRed
	call SetTextColor
	mov eax, moneyLost
    call displayBalance
	mov eax, yellow
	call SetTextColor
    call Crlf

	popad
	ret
menuOption4 endp

; -----------------------------------------------
; menuOption5 - exit
; -----------------------------------------------
; Does: Triggers main loop end
; Receives: none
; Returns: none
; Requires: none
; -----------------------------------------------
menuOption5 proc

	mov shouldContinueLoop, 0

	ret
menuOption5 endp

end main
