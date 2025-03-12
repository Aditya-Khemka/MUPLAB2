.model tiny
.186
.data
filename db "myfile.txt",00H
handle dw ?
str1 db 'create a new file (Y/N)?$'
str2 db 'Hello',0DH,0AH,'World'
str3 db 'Done$'
str4 db 'Exiting...$'
str5 db 'invalid choice, exiting...$'
disnl db 0DH,0AH,'$'

.code
.startup
LEA DX,str1			; display "create a new file (Y/N)?"
CALL PRINTLN

MOV AH,01H			; input 1 character and store it in AL
INT 21H

LEA DX,disnl		; display new line
CALL PRINT

CMP AL,'Y'			; if character == 'Y', jump to create_file
JE create_file

CMP AL,'N'			; else if character == 'N', jump to exit_prog
JE exit_prog

LEA DX,str5			; else display "invalid choice, exiting..."
CALL PRINT
.exit

exit_prog:
	LEA DX,str4		; display "Exiting..."
	CALL PRINT
.exit

create_file:
	MOV AH,3CH			; create a file named "myfile.txt"
	LEA DX,filename
	MOV CL,00H
	INT 21H
	MOV handle,AX		; and store it's filehandle in memory location "handle"
	
	MOV AH,40H			; write "Hello",<newline>,"World" in myfile.txt
	MOV BX,handle
	MOV CX,12			; (Since no. of characters in str2 is 12)
	LEA DX,str2
	INT 21H
	
	MOV AH,3EH			; close the file
	MOV BX,handle
	INT 21H
	
	LEA DX,str3			; display "Done"
	CALL PRINT
.exit

; Subroutine to print string on console
; Requires DX to have address of string to be be displayed
PRINT:
	PUSH AX
	MOV AH,09H
	INT 21H
	POP AX
	RET
; Subroutine to print string on console followed by a new line
; Requires DX to have address of string to be be displayed
PRINTLN:
	PUSH AX
	PUSH DX
	MOV AH,09H
	INT 21H
	LEA DX,disnl
	MOV AH,09H
	INT 21H
	POP DX
	POP AX
	RET
end