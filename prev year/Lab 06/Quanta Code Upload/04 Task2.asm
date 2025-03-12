;Write an 8086 assembly program which asks the user to
;enter his/her name. Once name is entered, it should display
;'Welcome user_name'
.model tiny
.186
.data
string1 db 'Enter your name:$'
newLine db 0AH,'$'
string2 db 'Welcome $'
max1 db 32
act db ?
inp db 32 dup(?)
.code
.startup
lea dx,string1
call print

lea dx,max1
call scan

lea dx,newLine
call print

lea dx,string2
call print

lea dx,inp
call print
.exit
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
	
end