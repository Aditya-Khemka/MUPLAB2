MOV AX,[2000H]
MOV CL,02H
DIV CX
MOV CX,AX		; CX = N/2
loop:
	MOV AX,[2000H]
	MOV DX,00H
	DIV CX
	CMP DX,00H		; If (DX-AX pair) % CX = 0, then not_prime, else iterate 
	JE not_prime
	DEC CX
	CMP CX,02H		; If CX >= 2, then loop, else prime
	JAE loop
MOV byte ptr [2002H],01H
MOV AX,00H
INT 21H

not_prime:
	MOV byte ptr [2002H],00H
	MOV AX,00H
	INT 21H