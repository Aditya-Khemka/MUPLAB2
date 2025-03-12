.model tiny
.data
FILENAME DB "FILE2.txt",00H
NEWFILENAME DB "ID.txt",00H

RENAME_SUCCESS DB 'File renamed successfully$'
FAIL DB 'Error occurred$'
.code
.startup

; DO NOT open the file before renaming it :)

MOV AH,56H
LEA DX,FILENAME
LEA DI,NEWFILENAME
MOV CX,0H
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,RENAME_SUCCESS		; else print "File renamed successfully"
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
end