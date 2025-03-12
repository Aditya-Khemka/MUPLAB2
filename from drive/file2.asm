.model tiny 
.486 
.data 

	filen db "mybio.txt",0
	handle dw ?
	dat1 db "Ah4 214 "
	nxl db 0dh,0ah
	cnt dw 8 
	disp db 11 dup('$')
.code 
.startup 

	mov ah,3dh  ; opening an existing file 
	lea dx, filen
	mov al,2 
	int 21h 
	mov handle, ax
	
	mov ah,42h ; moving file pointer to EOF 
	mov al,2 
	mov bx, handle
	mov cx,0 
	mov dx,0
	int 21h	
	
	mov ah,40h  ; taking file pointer to next line from existing EOF and printing new info 
	lea dx,nxl 
	mov cx,2 
	mov bx,handle 
	int 21h 
	
	mov ah,40h 
	lea dx,dat1 
	mov cx,cnt 
	mov bx,handle 
	int 21h
	
	mov ah,42h ; move to start of file 
	mov al,0 
	mov bx, handle
	mov cx,0 
	mov dx,0
	int 21h	
	
	mov ah, 3fh 
	mov bx, handle 
	mov cx, 10
	lea dx,disp 
	int 21h 
	
	mov ah,3eh 
	mov bx,handle 
	int 21h 
	
	mov ah,09h ; display on console 
	lea dx, disp
	int 21h 
	
	
	
.exit 
end 

	