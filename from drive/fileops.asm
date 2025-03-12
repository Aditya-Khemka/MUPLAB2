.model tiny 
.486
.data 

    filen db "data.txt",0
	handle dw ?
	nxl db 0dh,0ah
    dat1 db "This is a secret string stored in this file. You have now unlocked the secret key to a better universe."
    dat2 db "operation done. "
    STR1 DB 20
    STR2 DB ?
    STR3 DB 20 DUP($)

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

    mov si,offset dat1
    mov cx, 103 

X1: mov al,[si]
    cmp al,20h 
    jz X2 
    mov ah,40h 
	mov dx,si  
	mov cx,1
	mov bx,handle 
	int 21h 
    jmp X3 

X2: mov ah,40h 
	mov dx,nxl   
	mov cx,2
	mov bx,handle 
	int 21h 

X3: inc si 
    loop x1 

mov ah,09h ; display on console 
lea dx, dat2 
int 21h  

.exit 
end 
