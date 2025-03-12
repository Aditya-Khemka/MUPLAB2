.model tiny
.data
FILENAME DB "file1.txt",00H
HANDLE DW ?
FILECONTENT DB 64 DUP(?),'$'					; 64 bytes reserved for file content

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

LEA DX,FILECONTENT				; DX stores the memory address of where the next character is to be stored
LOOP1:
	MOV AH,3FH					; read the content of the file
	MOV BX,HANDLE
	MOV CX,01H
	INT 21H
	JC ERROR_DETECTED			; if error, print "Error occurred"
	
	INC DX						; increment DX to the next memory location
	CMP AX,00H					; if character != EOF, then loop 
	JNZ LOOP1
	
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