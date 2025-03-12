.model tiny
.data
FILENAME DB "file1.txt",00H
HANDLE DW ?
FILESIZE DB 37				; 37 Characters in file1.txt
FILECONTENT DB 37 DUP(?),'$'

disnl db 0DH,0AH,'$'
OPEN_SUCCESS DB 'File opened successfully$'
READ_SUCCESS DB 'File read successfully$'
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

MOV AH,3FH					; read the content of the file
MOV BX,HANDLE
MOV CH,00H
MOV CL,FILESIZE
LEA DX,FILECONTENT			; and store it in memory location staring from address of FILECONTENT
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,READ_SUCCESS			; else print "File read successfully"
CALL PRINTLN

LEA DX,FILECONTENT
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