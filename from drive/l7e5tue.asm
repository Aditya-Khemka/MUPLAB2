.model	tiny
.486
.data
cnt1	db		0
cnt2	db		8
cnt3	db		17
.code
.startup
		mov		ah,00
		mov		al,3
		int		10h
x1:		mov		dh,cnt1
		mov		dl,0
		mov		bh,0
		mov		ah,02h
		int		10h
		mov		ah,09h
		mov		al, 20h
		mov		bh,0
		mov		cx,8*80
		mov		bl,01000000b
		int 	10h
		mov		dh,cnt2
		mov		dl,0
		mov		bh,0
		mov		ah,02h
		int		10h
		mov		ah,09h
		mov		al,20h
		mov		bh,0
		mov		cx,9*80
		mov		bl,01110000b
		int 	10h
		mov		dh,cnt3
		mov		dl,0
		mov		bh,0
		mov		ah,02h
		int		10h
		mov		ah,09h
		mov		al,20h
		mov		bh,0
		mov		cx,8*80
		mov		bl,00100000b
		int 	10h
x2:		mov		ah,08h
		int		21h
		cmp 	al,'>'
		jnz		x2
.exit
end