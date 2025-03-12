.model	tiny
.486
.data
cnt1	db		25
.code
.startup

		; set video mode
		mov		ah,00
		mov		al,3
		int		10h

		; set cursor position
		mov		dh,0
		mov		dl,0
		mov		bh,0
		mov		ah,02h
		int		10h
		
		; write '*' top strip
		mov		ah,09h
		mov		al,'*'
		mov		bh,0
		mov		cx,80
		mov		bl,00001110b
		int 	10h
		
		; set cursor pos to bottm
		mov		dh,24
		mov		dl,0
		mov		bh,0
		mov		ah,02h
		int		10h
		
		; fill bottom strip
		mov		ah,09h
		mov		al,'*'
		mov		bh,0
		mov		cx,80
		mov		bl,00001110b
		int 	10h
		
		; set cursor pos
		mov		dh,0
		mov		dl,0
x1:		mov		bh,0
		mov		ah,02h
		int		10h
		; write across
		mov		ah,09h
		mov		al,'*'
		mov		bh,0
		mov		cx,1
		mov		bl,0001110b
		int 	10h
		inc		dh
		add		dl, 3
		dec		cnt1
		jnz		x2
		jz		x3
		
		; set cursor pos
x2:		mov		bh,0
		mov		ah,02h
		int		10h
		; write across
		mov		ah,09h
		mov		al,'*'
		mov		bh,0
		mov		cx,1
		mov		bl,0001110b
		int 	10h
		inc		dh
		add		dl, 4
		dec		cnt1
		jnz		x1
		
		
x3:		mov		ah,08h
		int		21h
		cmp 	al,'?'
		jnz		x3
.exit
end