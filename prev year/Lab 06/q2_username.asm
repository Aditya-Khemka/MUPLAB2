.model tiny
.data
str1 db 'Enter User Name$'
str2 db 'arjun_shah' 		; sample username
str3 db 'Enter Password$' 
str4 db '12345678',0DH		; sample password + enter
str5 db 'Hello $'
disnl db 0DH,0AH,'$'

userNameMaxLength db 11		; 10 characters + enter
userNameLength db ?
userName db 12 dup('$')     ; 12 characters + enter + '$'

password db 10 dup('$')     ; 12 characters + enter + '$'
.code
.startup

LEA DX,str1		; Print "Enter User Name"
MOV AH,09H
INT 21H
	
LEA DX,disnl	; Print <newline>
MOV AH,09H
INT 21H

LEA DX,userNameMaxLength	; Input userName
MOV AH,0AH
INT 21H

LEA DI,userName		; Check if (userName == str2)
LEA SI,str2
MOV CL,0AH

label1:
	MOV AL,[DI]
	cmp AL,[SI]
	JNE stop		; If (userName != str2)	stop
	INC SI
	INC DI
	LOOP label1

LEA DX,disnl	; Print <newline>
MOV AH,09H
INT 21H

LEA DX,str3		; Print "Enter Password"
MOV AH,09H
INT 21H

LEA DX,disnl		; Print <newline>
MOV AH,09H
INT 21H

LEA BX,password		; Input password
MOV CX,09H
inp:
	MOV AH,08H
	INT 21H
	MOV [BX],AL
	INC BX
	
	MOV DL,2AH		; Print '*'
	MOV AH,02H
	INT 21H
	
	LOOP inp
	
LEA DI,password	; Check if (password == str4)
LEA SI,str4
MOV CL,09H

label2:
	MOV AL,[DI]
	cmp AL,[SI]
	JNE stop	; if (password != str4)	stop
	INC SI
	INC DI
	LOOP label2

LEA DX,disnl	; Print <newline>
MOV AH,09H
INT 21H

LEA DX,str5		; Print "Hello "
MOV AH,09H
INT 21H

LEA DX,userName		; Print <userName>
MOV AH,09H
INT 21H

stop:
	MOV AX,0H
	INT 21H

.exit
end