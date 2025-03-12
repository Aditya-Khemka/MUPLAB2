LXI H,3000H
MVI A,8H
call fibo
call myPop 
HLT

fibo:
    push PSW
    CPI 2H  
    JNC recCall
    MVI A,1H
    call myPush
    pop PSW
    ret
    recCall:
        SUI 1H  
        call fibo
        SUI 1H
        call fibo
        call myPop
        MOV B,A
        call myPop
        ADD B
        call myPush 
        pop PSW
        ret

myPush:
    DCX H
    MOV M,A
    ret
    
   
myPop:
    MOV A,M
    INX H
    ret