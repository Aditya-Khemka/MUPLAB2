.model	tiny
.486
.data
fil1	db		'lab1.txt',0
han1	dw		?
clr		db		?
clr1	db		?
mem1	db		00101111b
mem2	db		01011111b
cnt		db		25
.code
.startup
		mov		ah,08h
		int		21h
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
		mov		dx,11
		int		21h
		mov		ah,3fh
		mov		bx,han1
		mov		cx,1
		lea		dx,clr1
		int		21h
		mov		al,clr
		cmp		al,clr1
		jz		x1
		not		mem1
		not		mem2
x1:		mov		bx,han1
		mov		ah,3eh
		int		21h
		mov		ah,00
		mov		al,3
		int		10h
		mov		dh,0
x2:		mov		ah,02h
		mov		dl,0
		mov		bh,0
		int		10h
		mov		ah,09h
		mov		al,20h
		mov		bl,mem1
		mov		bh,0
		mov		cx,80
		int		10h
		inc		dh
		dec		cnt
		jz		xn
		mov		ah,02h
		mov		dl,0
		mov		bh,0
		int		10h
		mov		ah,09h
		mov		al,20h
		mov		bl,mem2
		mov		bh,0
		mov		cx,80
		int		10h
		inc		dh
		dec		cnt
		jnz		x2
xn:		mov		ah,08h
		int		21h
		cmp		al,'@'
		jnz		xn
.exit
end