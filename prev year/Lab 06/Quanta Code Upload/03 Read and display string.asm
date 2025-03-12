;Read one char from keyboard and display
.model tiny
.186
.data
userData db 20 dup(?) 
.code
.startup
;----------------------------
mov cx,20 ;loop control
lea bx,userData
here:mov ah,1
int 21H
mov [bx],al
inc bx
loop here
;----------------------------
mov dl,0dh
mov ah,2
int 21H
mov dl,0Ah
mov ah,2
int 21H
;----------------------------
mov cx,20 ;loop control
lea bx,userData
there:mov dl,[bx]
mov ah,2
int 21H
inc bx
loop there
.exit
end