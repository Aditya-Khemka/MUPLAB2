.model tiny
.data
FILENAME DB "file1.txt",00H
HANDLE DW ?
MYNAME DB 'Shamit Khetan'
MYID DB '2022AAPS1222G'

disnl db 0DH,0AH,'$'
CREATE_SUCCESS DB 'File created successfully$'
PRINT_SUCCESS DB 'Wriiten to file successfully$'
CLOSE_SUCCESS DB 'File closed successfully$'
FAIL DB 'Error occurred$'
.code
.startup

MOV AH,3CH               	; create a new file function
MOV CL,00H					
LEA DX,FILENAME       		
INT 21H                     
MOV HANDLE, AX       		; AX = handle (or error code)
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,CREATE_SUCCESS		; else print "File created successfully"
CALL PRINTLN

MOV AH,40H					; write my name to file
MOV BX,HANDLE
MOV CX,0DH
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
MOV CX,0DH
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