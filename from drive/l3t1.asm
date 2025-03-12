.model Tiny
.486
.data

STR1 DB 20
STR2 DB ?
STR4 DB 20 DUP(?),'$'

.code
.startup

LEA DX,STR1
MOV AH,0AH
INT 21H
 

LEA DX,STR4
MOV AH,09H
INT 21H 


.exit
end

