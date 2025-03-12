#org 1000H
#db 12H,45H,67H,33H,57H,22H,67H,15H,1H,87H
#org 0H
#begin

main:        ;main program
MVI C,09H    ;C is used as counter
LXI H,1000H
MOV A,M      ;Copy the first element
INX H        ;Increment pointer
loop:
    MOV B,M ;Copy second element to B
    MOV D,A ;Back up A since result of subrouting will come in A
	call compare
    CPI 0H ;Compare result of subrouting with 0
    JZ AisLarge ;If return is 0, A is larger
	MOV A,B ;B is large, so store B to A as result
	JMP Cont ;Continue to loop
    AisLarge:;If A is large, restore A from D and continue loop
	MOV A,D 
	Cont:
    INX H
    DCR C
JNZ loop
STA 2000H ;Store final result in 2000H
HLT


;Assumption, arguments are in A and B register
;return value in A register
compare:
    CMP B
	JC AEorS ;If carry flag is set A smaller than B
	JZ AEorS ;If zero flag is set A is equal to B
	MVI A,0  ;If both conditions not met, A is larger, return 0
	ret
	AEorS:
		MVI A,1 ;If A is smaller or equal, return 1
		ret