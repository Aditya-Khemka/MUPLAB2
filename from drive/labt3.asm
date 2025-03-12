.model Tiny 
.486
.data 

filen db "mon123.txt",0
str1 db 20
str2 db ?
str3 db 20 dup(?)
str4 db 6 dup(?)
handle dw ? 
.code 
.startup 

lea dx,str1 
mov ah,0ah 
int 21h 

lea si,str3 
lea di,str4 
add di,5 
add si,14
mov cx,6

X2: mov al,[si]
    mov [di],al 
    dec si 
    loop X2 

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

mov ah,40h 
lea dx,str4  
mov cx,6  
mov bx,handle 
int 21h

.exit 
end 
