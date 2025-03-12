#org 1000H
#db 04H      ;Store 4 at address 1000H to test the code
#org 0H      ;Start the program from address 0
#begin

main:        ;main program
LXI H,1000H
MOV A,M         ;Load the number from address 1000H
CPI 2H          ;Check whether the number is 0 or 1. For that compare with 2
JNC continue     ;Carry flag is set if A < 2 (~number is 0 or 1)
MVI A,1         ;If 0 or 1, store 1 in A as the final result and
HLT             ;halt
continue:       ;Number is >= 1
    MOV B,A     ;Copy the number to B register
    DCR B       ;Decrement 1 from A, since factorial requires n*n-1
    call_mult:        
        call mult    ;Call mult procedure. arguments are in A and B and result in A
        DCR B        ;Decrement number by 1
        JNZ call_mult;If not zero, again multiply
HLT                  ;Once B becomes zero, halt


;Subrouting for multiplication
;assumption parameters are in A and B
;result is in A
;Don't modify other registers. If modifying, restore before
;returning
mult:
    CPI 0H   ;Check if A is 0, if yes return 0
    rz        
    PUSH B   ;
    MOV C,A  ;Since C is used as backup, push BC pair to stack so that C can be restored
    MVI A,0H  ;clear the acc to store result. Remember initial A is already backed up in C
    loop:
        ADD B ;Add multiplier to accumulator
        DCR C ;Decrement loop control variable. Once it exhaust, exist
    JNZ loop
    POP B    ;Before returning, restore BC pair
    ret