.model tiny 
.486 
.data 

	filen db "mybio.txt",0
	handle dw ?
	dat1 db "NISHIL KULKARNI 2021AAPS2499G "
	nxl db 0dh,0ah
	cnt dw 30 
.code 
.startup 

	mov ah,3ch
	lea dx,filen
	mov cl,20h  
	int 21h 
	mov handle,ax
	
	
	mov ah,3dh 
	lea dx, filen
	mov al,2 
	int 21h 
	mov handle, ax 
	 
	 
	mov ah,40h 
	lea dx,dat1 
	mov cx,cnt 
	mov bx,handle 
	int 21h 
	 
	
	mov ah,40h 
	lea dx,nxl 
	mov cx,2 
	mov bx,handle 
	int 21h 
	
	
	mov ah,40h 
	lea dx,dat1 
	mov cx,cnt 
	mov bx,handle 
	int 21h
	
.exit 
end 

	
	
	
	
	