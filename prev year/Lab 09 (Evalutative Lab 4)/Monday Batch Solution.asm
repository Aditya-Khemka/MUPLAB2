.model tiny
.data
FILENAME DB "myfile.txt",00H
HANDLE DW ?

MAX DB 32							; 31 characters + enter
ACT DB ?
FILECONTENT DB 33 DUP('$')			; 31 characters + enter + $
FILESIZE_DECIMAL DB ?

STR1 DB 'write on myfile.txt (Y/N)?$'
STR2 DB 'What do you want to write (< 32 char)?$'
STR3 DB 'Exiting...$'
STR4 DB 'You have given an invalid choice, exiting...$'
disnl db 0DH,0AH,'$'

UPPER DB ?
LOWER DB ?
.code
.startup
MOV AH,3CH				; Create the file
LEA DX,FILENAME
MOV CL,00H
INT 21H
MOV HANDLE,AX

MOV AH,3EH				; Close the file
MOV BX,HANDLE
INT 21H

LEA DX,STR1				; display "write on myfile.txt (Y/N)?"
CALL PRINTLN

MOV AH,01H				; input character
INT 21H

LEA DX,disnl			; display <newline>
CALL PRINT

CMP AL,'Y'				; if character == 'Y' go to write_file
JE write_file
CMP AL,'N'				; else if character == 'N' go to exit_prog
JE exit_prog

LEA DX,STR4				; else display "You have given an invalid choice, exiting..." and exit
CALL PRINT
.exit

exit_prog:
	LEA DX,STR3			; display "Exiting..." and exit 
	CALL PRINT
.exit

write_file:
	LEA DX,STR2			; display "What do you want to write (< 32 char)?"
	CALL PRINTLN
	
	MOV AX,3D01H		; open the file
	LEA DX,FILENAME
	INT 21H
	MOV HANDLE,AX

	LEA DX,MAX			; take input of string
	MOV AH,0AH
	INT 21H
	
	MOV DH,0H			; SI = number of characters entered
	MOV DL,ACT
	MOV SI,DX
	
	LEA DX,FILECONTENT		; DX = address of last character
	ADD DL,ACT
	DEC DX
	
	LOOP1:
		MOV AH,40H			; write 1 character to the file
		MOV BX,HANDLE	
		MOV CX,1H
		INT 21H
		
		DEC DX				; go to next character to be printed
		DEC SI
		JNZ LOOP1
	
	MOV AH,40H				; write <newline> to the file
	LEA DX,disnl
	MOV BX,HANDLE
	MOV CX,2H
	INT 21H
	
	MOV AL,ACT					; convert number from hexadecimal to decimal
	MOV FILESIZE_DECIMAL,AL		; and store it in FILESIZE_DECIMAL
	CALL HEXTODEC
	
	MOV AL,FILESIZE_DECIMAL
	AND AL,0F0H					; mask the lower nibble
	MOV CL,4H
	ROR AL,CL
	ADD AL,30H
	MOV UPPER,AL				; UPPER stores ASCII value of the upper decimal digit
	
	MOV AL,FILESIZE_DECIMAL
	AND AL,0FH					; mask the upper nibble
	ADD AL,30H
	MOV LOWER,AL				; LOWER stores ASCII value of the lower decimal digit
	
	MOV AH,40H					; Write UPPER to the file
	LEA DX,UPPER
	MOV BX,HANDLE
	MOV CX,1H
	INT 21H
	
	MOV AH,40H					; Write LOWER to the file
	LEA DX,LOWER
	MOV BX,HANDLE
	MOV CX,1H
	INT 21H
	
	MOV AH,3EH					; Close the file
	MOV BX,HANDLE
	INT 21H	
.exit

; Converts a hex number to it's decimal equivalent
; Requires number to be <= 99
; Number should be present in FILESIZE_DECIMAL
; Result will be written to FILESIZE_DECIMAL
HEXTODEC:
	PUSH AX
	PUSH CX
	
	MOV AL,0H
	MOV CH,0H
	MOV CL,FILESIZE_DECIMAL		; CX = number in hexadecimal
	JCXZ return
	LOOP2:
		ADD AL,01H
		DAA						; converts hexadecimal to decimal
		LOOP LOOP2
	MOV FILESIZE_DECIMAL,AL
	
	return:
		POP CX
		POP AX
		RET
	
; Subroutine to print on DOSBOX
; Requies DX to contain address of data to be printed
PRINT:
PUSH AX

MOV AH,09H		; display <DX> on screen
INT 21H

POP AX
RET

; Subroutine to print on DOSBOX, followed by a new line
; Requies DX to contain address of data to be printed
PRINTLN:
PUSH AX
PUSH DX

MOV AH,09H		; display <DX> on screen
INT 21H

LEA DX,disnl	; display <newline> on screen
MOV AH,09H
INT 21H

POP DX
POP AX
RET
end