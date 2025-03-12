.model	tiny
.486
.data
fil1	db		'lab1.txt',0
han1	dw		?
clr		db		?
mem1	db		?
mem2	db		?
.code
.startup

		mov		ah,08h
		int		21h
		and		al,0fh
		mov		clr,al
		
		mov		ah,3dh
		mov		al,2
		lea		dx,fil1
		int		21h
		mov		han1,ax
		
		mov		ah,42h
		mov		al,0
		mov		bx,han1
		mov		cx,0
		mov		dx,4
		int		21h
		
		mov		ah,3fh
		mov		bx,han1
		mov		cx,1
		lea		dx,mem1
		int		21h
		
		mov		ah,42h
		mov		al,0
		mov		bx,han1
		mov		cx,0
		mov		dx,9
		int		21h
		
		mov		ah,3fh
		mov		bx,han1
		mov		cx,1
		lea		dx,mem2
		int		21h
		
		mov		bx,han1
		mov		ah,3eh
		int		21h
		
		mov		ah,00
		mov		al,3
		int		10h
		
		mov		ah,02h
		mov		dh,0
		mov		dl,0
		mov		bh,0
		int		10h
		
		mov		ah,09h
		mov		al,mem1
		mov		bl,clr
		mov		bh,0
		mov		cx,1
		int		10h
		
		mov		ah,02h
		mov		dh,24
		mov		dl,79
		mov		bh,0
		int		10h
		
		mov		ah,09h
		mov		al,mem2
		mov		bl,clr
		mov		bh,0
		mov		cx,1
		int		10h
		
xn:		mov		ah,08h
		int		21h
		cmp		al,'@'
		jnz		xn
.exit
end