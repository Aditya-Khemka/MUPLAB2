.MODEL TINY
.DATA
STRING	DB	"myfile.txt",0
STRING1	DB	"d:\myfile.txt",0
fileString DB "Hello world"
yay db "successful$"
no db "error$"
HANDLE DW ?
.CODE
.STARTUP
mov ah, 3dh ;Open an existing file
mov al,1 ;Open file for writing
lea dx, STRING ;File name reference
int 21h ;Call int to open file
jc l1 ;If carry is set open failed
lea dx, yay ;else open success
call print
mov HANDLE,AX ;Save the handle in memory
mov ah,40h ;For writing to file
mov bx,HANDLE
mov cx,11 ;Number of bytes to be written
lea dx,fileString;Starting addr of data
int 21H;
jc l1;If carry file writing failed
lea dx, yay;else file write success
call print
mov ah,3eh; to close a file
mov bx,HANDLE
int 21H
.exit
l1: lea dx, no
call print
.EXIT
;subroutine to print a string
;assumes the starting address of the string is stored in dx register
print:
	push ax
	mov ah,9h
	int 21h
	pop ax
	ret

;subrouting to read a string from keyboard
;assumes dx is already loaded with max size variable	
scan:
	push ax
	push bx
	push si
	mov ah,0AH
	int 21H
	mov bx,dx
	inc bx
	mov si,[bx]
	and si,00ffh
	mov byte ptr [bx+si+1],'$'
	pop si
	pop bx
	pop ax
	ret
END