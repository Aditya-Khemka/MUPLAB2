.model	tiny
.486
.data
dat1	db		'!'
dat2	db		'?'
cnt1	db		5
row		db		0
.code
.startup
		mov		ah,00
		mov		al,3
		int		10h
x1:		mov		dh,row
		mov		dl,0
		mov		bh,0
		mov		ah,02h
		int		10h
		inc		row
		mov		ah,09h
		mov		al,dat1
		mov		bh,0
		mov		cx,10
		mov		bl,00001110b
		int 	10h
		mov		dh,row
		mov		dl,0
		mov		bh,0
		mov		ah,02h
		int		10h
		inc		row
		mov		ah,09h
		mov		al,dat2
		mov		bh,0
		mov		cx,10
		mov		bl,00001001b
		int 	10h
		dec 	cnt1
		jnz		x1
x2:		mov		ah,08h
		int		21h
		cmp 	al,'.'
		jnz		x2
.exit
end