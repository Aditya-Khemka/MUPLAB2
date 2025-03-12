.MODEL TINY
.186
.DATA
STR1 DB 'The dividend is: $'
STR2 DB 'The divisor is: $'
DISNL DB 0DH,0AH,'$'

FILENAME DB "test.txt",00H
HANDLE DW ?
FILESIZE DB ?
FILEDATA DB 7 DUP (' ')
SPACE DB ' '

DIVIDEND DB ?
DIVISOR DB ?

QUOTIENT DB ?
REMAINDER DB ?

BUFFER DB '000$'		; used in PRINT_NUM subroutine

.CODE
.STARTUP
	MOV AX,3D00H		; Open the file
	LEA DX,FILENAME
	INT 21H
	MOV HANDLE,AX		; Store file handle in memory "HANDLE"
	
	MOV AH,3FH			; Read file
	MOV BX,HANDLE
	MOV CX,7			; Maximum characters that can be stored in TEST.TXT
	LEA DX,FILEDATA		; Store file contents in memory staring from "FILEDATA"
	INT 21H
	MOV FILESIZE,AL		; Store number of bytes read in FILESIZE
	
	LEA SI,FILEDATA
	LEA DI,DIVIDEND
	CALL READ_NUM		; DIVIDEND stores the dividend in hex
	
	INC SI
	LEA DI,DIVISOR
	CALL READ_NUM		; DIVISOR stores the divisor in hex
	
	LEA DX, STR1		; display "The dividend is: "
	CALL PRINT
	
	LEA SI,DIVIDEND		; display the value of the dividend
	CALL PRINT_NUM
	
	LEA DX,DISNL		; display <new line>
	CALL PRINT
	
	LEA DX, STR2		; display "The divisor is: "
	CALL PRINT
	
	LEA SI,DIVISOR		; display the value of the divisor
	CALL PRINT_NUM
	
	LEA DX,DISNL		; display <new line>
	CALL PRINT
	
	MOV AL,DIVIDEND
	MOV AH,0
	MOV BL, DIVISOR
	DIV BL				; AH-AL = remainder-quotient of the division (here remainder is not the decimal value to be printed)
	
	MOV QUOTIENT,AL		; store the value of the quotient in QUOTIENT
	
	MOV AL,AH
	MOV AH,0			
	MOV BL,100			; multiply the remainder obtained above by 100 
	MUL BL				; (in order to extract the first 2 decimal remainder digits)
	
	MOV BL, DIVISOR		; divide the above value by the divisor
	DIV BL				; the quotient of this division stores the first 2 remainder decimal digits
	
	MOV REMAINDER,AL	; store the value of remainder in REMAINDER
	
	LEA SI,QUOTIENT		; display the quotient on screen
	CALL PRINT_NUM
	
	MOV DL,'.'			; display '.'
	MOV AH,02H
	INT 21H
	
	LEA SI,REMAINDER	; display the remainder on screen
	CALL PRINT_NUM
	
.EXIT

; Requies: SI to have address of the byte to be printed on screen
; Prints a number stored in memory [SI] on screen
PRINT_NUM:
	PUSHA
	LEA DI,BUFFER
	ADD DI,3			; DI = address of '$' (of BUFFER)
	MOV AH,0H
	MOV AL,[SI]			; AX = number to be printed on screen
	MOV BL,10			; BX = 10
	
loop3:
		DEC DI			; DI stores the memory location where the current digit will be stored
		DIV BL			; extract the units digit (= remainder stored in AH)
		ADD AH,'0'		; convert decimal digit to ASCII
		MOV [DI],AH		; store ASCII value in memory
		MOV AH,0H		
		CMP AX,0H
		JA loop3		; repeat the process until quotient becomes 0
	
	MOV DX,DI			; display the number on screen
	CALL PRINT
	POPA
	RET

; Read number stored at SI (in ASCII) terminated by ' ' and store it at DI (in hex)
; Modifies SI to the address of the space character after the number
READ_NUM:
	PUSH AX
	PUSH BX
	
	MOV BX,0H					; BX will store the number in decimal
loop1:
		MOV AL,[SI]				; copy the ASCII of the number to AL
		SUB AL,'0'				; convert ASCII to decimal
		SHL BX,4H
		ADD BL,AL				; left shift BX by a 4 bits and add the decimal number to it
		INC SI					; go to the next ASCII number
		CMP BYTE PTR [SI],' '	; if [SI] == ' ', then exit loop
		JNE loop1
	CALL DEC_TO_HEX				; Convert decimal number in BX to hexadecimal and store it in BL
	MOV [DI],BL					; Store the hexadecimal number in [DI]
	
	POP BX
	POP AX
	RET

; Converts decimal number in BX to hexadecimal number and stores it in BL
DEC_TO_HEX:
	PUSH AX
	MOV AX,BX			; copy the number to AX
	MOV BX,0			; BX will store thenumber in hexadecimal
loop2:
		SUB AX,1H		; decrement AX
		DAS				; Convert hex number to BCD number 
		INC BL			; increment (hexadecimal) counter
		CMP AX,0H		; if AX == 0, then return
		JA loop2
	POP AX
	RET
	
; Subroutine to print on DOSBOX
; Requies DX to contain address of data to be printed
PRINT:
	PUSH AX
	MOV AH,09H		; display <DX> on screen
	INT 21H
	POP AX
	RET

; Subroutine to print on DOSBOX, followed by a new line
; Requies DX to contain address of data to be printed
PRINTLN:
	PUSH AX
	PUSH DX
	MOV AH,09H		; display <DX> on screen
	INT 21H
	LEA DX,DISNL	; display <newline> on screen
	MOV AH,09H
	INT 21H
	POP DX
	POP AX
	RET
END