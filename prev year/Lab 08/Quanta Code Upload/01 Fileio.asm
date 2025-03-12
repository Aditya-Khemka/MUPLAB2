.MODEL TINY
.DATA
STRING	DB	"myfile.txt",0
STRING1	DB	"d:\myfile.txt",0
yay db "successful$"
no db "error$"
.CODE
.STARTUP
mov ah, 3ch
mov cl, 0h
lea dx, STRING ; no error
;lea dx, STRING1 ; error
int 21h
jc l1
lea dx, yay
call print
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