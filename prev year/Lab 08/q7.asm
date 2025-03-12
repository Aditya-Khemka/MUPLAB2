.model tiny
.data
FILENAME DB "ID.txt",00H

DELETE_SUCCESS DB 'File deleted successfully$'
FAIL DB 'Error occurred$'
.code
.startup

MOV AH,41H
LEA DX,FILENAME
INT 21H
JC ERROR_DETECTED			; if error, print "Error occurred"
LEA DX,DELETE_SUCCESS		; else print "File deleted successfully"
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