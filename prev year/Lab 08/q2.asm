.model tiny
.data
FILENAME DB "file1.txt",00H
HANDLE DW ?
HOSTEL DB 0DH,0AH,'DH5 303'

disnl db 0DH,0AH,'$'
OPEN_SUCCESS DB 'File opened successfully$'
PRINT_SUCCESS DB 'Wriiten to file successfully$'
MOVE_SUCCESS DB 'Cursor moved successfully$'
CLOSE_SUCCESS DB 'File closed successfully$'
FAIL DB 'Error occurred$'
.code
.startup
MOV AX,3D02H				; open the file
LEA DX,FILENAME
INT 21H
MOV HANDLE,AX
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,OPEN_SUCCESS			; else print "File opened successfully"
CALL PRINTLN

MOV AX,4202H				; Move cursor to end of file
MOV BX,HANDLE
MOV CX,0H
MOV DX,0H
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,MOVE_SUCCESS			; else print "Cursor moved successfully"
CALL PRINTLN

MOV AH,40H					; write my hostel to file
MOV BX,HANDLE
MOV CX,09H
LEA DX,HOSTEL
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