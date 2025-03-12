#ORG 3000H
#DB 15H,34H,32H,65H,38H,45H,12H,35H,15H,12H
#ORG 2000H
#DB 0AH,15H
#ORG 0H

LDA 2000H
MOV C,A	; Initialize counter to number of variables in array
MVI D,00H	; Register to hold count of number of matches
LXI H,3000H	; Initializing M
loop:	; Iterate over every element
	LDA 2001H	; A = No that needs to be matched
	CALL compare 
	CPI 01H	; Compare whether M == A
	JNZ next	; If M != A iterate to next element
	INR D	; else increment match counter
	next:
	INX H	; Go to next memory
	DCR C	; Decrement loop counter
	JNZ loop	; If loop counter != 0, repeat loo[
LXI H,2002H		; Go to memory 2002H
MOV M,D	; Store match count in M
HLT


; If (A == M) A = 1 else A = 0
compare:
	CMP M
	JZ equal
	MVI A,00H
	RET
	equal:
	MVI A,01H
	RET