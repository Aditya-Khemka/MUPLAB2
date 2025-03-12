;Write an 8086 assembly program to store
;20H and 30H in the data memory and add them
;and store the result back in memory
.model tiny
.186
.data
data1 db 20H
data2 db 30H
result db ? 
.code
.startup
lea bx,data1 ;for register relative addressing
mov al,data2 ;Get the second data to al
add al,[bx]  ;Add with first data indirectly
mov result,al;Store the result in memory
.exit
end




