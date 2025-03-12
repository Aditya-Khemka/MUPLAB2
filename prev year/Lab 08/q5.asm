.model tiny
.data
FILENAME DB "file2.txt",00H
HANDLE DW ?

STR1 DB 'Enter name: $'
STR2 DB 'Enter ID: $'

MYNAMEMAX DB 33			; 32 characters + enter
MYNAMEACT DB ?
MYNAME DB 34 dup('$')	; 32 characters + enter + '$'

MYIDMAX DB 21			; 20 characters + enter
MYIDACT DB ?
MYID DB 22 dup('$')		; 20 characters + enter + '$'

disnl db 0DH,0AH,'$'
CREATE_SUCCESS DB 'File created successfully$'
PRINT_SUCCESS DB 'Wriiten to file successfully$'
CLOSE_SUCCESS DB 'File closed successfully$'
FAIL DB 'Error occurred$'
.code
.startup

LEA DX,STR1				; display "Enter name: "
CALL PRINT

LEA DX,MYNAMEMAX		; input name
MOV AH,0AH
INT 21H

LEA DX,disnl			; display <newline>
CALL PRINT

LEA DX,STR2				; display "Enter ID: "
CALL PRINT

LEA DX,MYIDMAX			; input ID
MOV AH,0AH
INT 21H

LEA DX,disnl			; display <newline>
CALL PRINT

MOV AH,3CH				; create a new file
LEA DX,FILENAME
MOV CL,00H
INT 21H
MOV HANDLE,AX
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,CREATE_SUCCESS		; else print "File create successfully"
CALL PRINTLN

MOV AH,40H					; write my name to file
MOV BX,HANDLE
MOV CH,00H
MOV CL,MYNAMEACT
LEA DX,MYNAME
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,PRINT_SUCCESS		; else print "Wriiten to file successfully"
CALL PRINTLN

MOV AH,40H					; write <newline> to file
MOV BX,HANDLE
MOV CX,02H
LEA DX,disnl
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,PRINT_SUCCESS		; else print "Wriiten to file successfully"
CALL PRINTLN

MOV AH,40H					; write my id to file
MOV BX,HANDLE
MOV CH,00H
MOV CL,MYIDACT
LEA DX,MYID
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,PRINT_SUCCESS		; else print "Wriiten to file successfully"
CALL PRINTLN

MOV AH,3EH					; close the file
MOV BX,HANDLE
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,CLOSE_SUCCESS		; else print "File closed successfully"
CALL PRINT

.exit
ERROR_DETECTED:
LEA DX,FAIL
CALL PRINT
.exit

PRINT:
PUSH AX
MOV AH,09H
INT 21H
POP AX
RET

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