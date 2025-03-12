#org 1000H
#db 12H,45H,69H,33H,57H,22H,67H,15H,1H,87H
#org 0H
#begin

;In the main, C is used as outer loop control variable
;D as inner loop control variable
;HL pair as memory pointer
;E for temporarily storing A register
main:            
MVI C,AH          ;Outer loop variable initialized to 10 (# of elements)
DCR C		   
outer_loop:
    MOV D,C	      ;Inner loop variable 1 less than outer 
    LXI H,1000H   ;Each timer inner loop starts from beginning of array
    inner_loop:
	          MOV A,M      ;Take element from the array
	          MOV E,A      ;Backup A since result of compare is in A
	          INX H        ;Point to next element in memory
	          MOV B,M	     ;Store next element in B
	          call compare ;Compare the elements
	          CPI 0H
	          JNZ NO_SWAP  ;If element in memory is larger, no swapping, else, swap 
	          MOV A,E      ;Restore A before calling swap
	          call swap
	          NO_SWAP:
	          DCR D        ;Decrement inner loop variable
   	          JNZ inner_loop ;If loop variable is 0, exit loop
    DCR C             ;Decrement outer loop variable
    JNZ outer_loop    ;If loop variable is 0, exit loop
HLT

;Subrouting for multiplication
;assumption parameters are in A and B
;result is in A
;Don't modify other registers. If modifying, restore before
;returning
compare:
    CMP B
	JC AEorS ;If carry flag is set A smaller than B
	JZ AEorS ;If zero flag is set A is equal to B
	MVI A,0  ;If both conditions not met, A is larger, return 0
	ret
	AEorS:
		MVI A,1 ;If A is smaller or equal, return 1
		ret
		

;subrouting for swapping
;Assumption, parameters are in A and B registers
;A needs to be stored at memory pointed by HL pair
;and B at one location before HL pair
swap:
	MOV M,A
	DCX H
	MOV M,B
	INX H
	ret