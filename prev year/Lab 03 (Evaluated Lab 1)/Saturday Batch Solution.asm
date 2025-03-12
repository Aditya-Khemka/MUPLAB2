#ORG 2000H
#DB A7H,37H
#ORG 0

LXI H,2000H
MOV D,M	; Numerator
INX H
MOV B,M	; Denominator
loop:
	CALL compare
	CPI 0H
	JNZ cont
INX H
MOV M,D
HLT

cont:
	CALL sub
	JMP loop
		
; D = D - B
sub:
	PUSH PSW
	MOV A,D
	SUB B
	MOV D,A
	POP PSW
	RET

; OVERWRITES reg A
; compares D and B
; if(D>=B) A = 1, else A = 0 
compare:
	MOV A,D	
	CMP B
	JC AisS
	MVI A,01H
	RET
	AisS:
		MVI A,00H
	RET