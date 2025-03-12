.model tiny
.186
.data
FILENAME DB "TEST.TXT",00H
HANDLE DW ?
FILEDATA DB 20 DUP('$')		; num_1,' ',num_2,' ',num_3,' ',num_4,' ',num_5,'$'
FILESIZE DB ?
NUM DB 5 DUP(0)
BUFFER DB '000$'
DISNL DB 0DH,0AH,'$'
.code
.startup
	MOV AX,3D00H		; Open file 
	LEA DX,FILENAME
	INT 21H
	MOV HANDLE,AX		; Store file handle in memory "HANDLE"
	
	MOV AH,3FH			; Read file
	MOV BX,HANDLE
	MOV CX,19			; Maximum characters that can be stored in TEST.TXT
	LEA DX,FILEDATA		; Store file contents in memory staring from "FILEDATA"
	INT 21H
	MOV FILESIZE,AL		; Store number of bytes read in FILESIZE
	
	LEA DX,FILEDATA		; display FILEDATA on screen
	CALL PRINT
	
	LEA DX,DISNL		; display <newline>
	CALL PRINT
	
	LEA SI,FILEDATA		; SI = address of FILEDATA
	LEA DI,NUM			; DI = address of location to store the number
	MOV CX,5			; CX = count of numbers 

read_loop:
		CALL READ_NUM	; read the 5 numbers and store them in memory staringfrom location NUM
		INC SI
		INC DI
		LOOP read_loop
	
	; Now we compare and find the maximum number
	LEA DI,NUM			; DI will iterate over the array
	MOV SI,DI			; SI will store address of maximum number 
	MOV AL,[DI]			; AL stores maximum number
	INC DI
	MOV CX,4H			; CX is count of number of comparisions

compare_loop:
	CMP AL,[DI]			; if current number is below the maximum number, then iterate
	JAE iterate
	MOV AL,[DI]			; else maximum number = current number
	MOV SI,DI
	iterate:
	INC DI
	LOOP compare_loop
	
	CALL PRINT_NUM		; print the max number on screen
.exit

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

; Requies SI to have address of the number and DI to have address of location to store the number
; Modifies SI to the address after the number being read (address of the ' ' after the current number or address of '$')
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
		JE exit_loop1
		CMP BYTE PTR [SI],'$'	; if [SI] == '$', then exit loop
		JNE loop1
	exit_loop1:
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
	MOV AH,09H
	INT 21H
	POP AX
	RET

; Subroutine to print a single character on DOSBOX
; Requies DL to contain the data to be printed	
PRINT_CHAR:
	PUSH AX
	MOV AH,02H
	INT 21H
	POP AX
	RET
end	