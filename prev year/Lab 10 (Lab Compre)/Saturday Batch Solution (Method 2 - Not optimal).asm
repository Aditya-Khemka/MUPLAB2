.model tiny
.186
.data
FILENAME DB "TEST.TXT",00H
HANDLE DW ?
SPACE DB ' '
FILEDATA DB 20 DUP('$')		; ' ',num_1,' ',num_2,' ',num_3,' ',num_4,' ',num_5,'$'
FILESIZE DB ?
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
	
	LEA SI,FILEDATA
	MOV AL,FILESIZE
	MOV AH,0
	ADD SI,AX			; SI = addx of last character of num_5 + 1
	
	MOV AX,30H
	MOV BX,0H			; BL-AH-AL stores max_num which is initialized to 0
	MOV BP,05H			; BP stores count of numbers
	
	LOOP1:
		DEC SI			; go to character before ' '
		
		CALL READ_NUM	; DL-CH-CL stores new_number
		CALL COMPARE	; if BL-AH-AL > DL-CH-CL, then DI = 1, else DI = 0
		
		CMP DI,1H
		JE itr			; if BL-AH-AL (max_num) > num, then iterate
		MOV AX,CX		; else store num in max_num
		MOV BX,DX
		itr:
		DEC BP
		JNZ LOOP1
	
	CMP BL,0			; print the number on screen character by character
	JE skipBL
	MOV DL,BL
	CALL PRINT_CHAR
	
	skipBL:
	CMP AH,0
	JE skipAH
	MOV DL,AH
	CALL PRINT_CHAR
	
	skipAH:
	MOV DL,AL
	CALL PRINT_CHAR
.exit

; Requies SI to have addx of unit's digit 
; Modifies SI to the addx of the character before the number (address of the ' ' before the current number)
; Stores number in DL-CH-CL
READ_NUM:
	MOV DX,0
	MOV CX,0
	
	MOV CL,[SI]				; store unit's digit in CL register
	DEC SI
	CMP BYTE PTR [SI],' '
	JE next					; if one's digit does not exist then return
	
	MOV CH,[SI]				; store one's digit in CH register
	DEC SI
	CMP BYTE PTR [SI],' '
	JE next					; if hundred's digit does not exist then return
	
	MOV DL,[SI]				; store hundred's digit in DL register
	DEC SI
	
	next:
	RET

; Compares BL-AH-AL and DL-CH-CL
; Modifies DI to 1H if BL-AH-AL > DL-CH-CL, else DI = 0H
COMPARE:
	CMP BL,DL
	JA yes
	JB no
	CMP AH,CH
	JA yes
	JB no
	CMP AL,CL
	JA yes
	no:
		MOV DI,0H
		RET
	yes:
		MOV DI,1H
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