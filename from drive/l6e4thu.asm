.model	tiny
.486
.data
fil1	db		'lab.txt',0
han1	dw		?
mem1	db		?
mem2	db		120 dup(0)
.code
.startup
		mov		ah,08h
		int		21h
		mov     mem1,al
		mov		ah,3dh
		mov		al,2
		lea		dx,fil1
		int		21h
		mov		han1,ax
		mov		ah,42h
		mov		al,0
		mov		bx,han1
		mov		cx,0
		mov		dx,9
		int		21h
		mov		ah,3fh
		mov		bx,han1
		mov		cx,120
		lea		dx,mem2
		int		21h
		mov		ah,42h
		mov		al,0
		mov		bx,han1
		mov		cx,0
		mov		dx,9
		int		21h
		mov		ah,40h
		mov		bx,han1
		mov		cx,121
		lea		dx,mem1
		int		21h
		mov		bx,han1
		mov		ah,3eh
		int		21h
.exit
end