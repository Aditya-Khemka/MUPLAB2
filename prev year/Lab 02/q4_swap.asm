#org 0
#begin

main:      ;main program
LXI B,1234 ;store 1234 in BC pair
LXI H,5678 ;store 5678 in HL pair
push B     ;push BC pair to stack
push H     ;push HL pair to stack
pop B      ;When poping, last data will come first ie.HL. But it is now stored in BC
pop H
hlt