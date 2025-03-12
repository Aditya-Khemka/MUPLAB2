MOV BX,2004H					; Stores address where next factor is to be stored
MOV CX,1H						; Iterates from 1 to N
loop1:
	MOV AX,word ptr [2000H]
	MOV DX,word ptr [2002H]
	DIV CX
	CMP DX,0H					; if (remainder = 0) move CX to [BX], else CX = CX + 1
	JNZ iter
	MOV [BX],CX
	ADD BX,02H
iter:
	INC CX
	CMP CX,[2000H]
	JBE loop1
MOV AX,0H
INT 21H