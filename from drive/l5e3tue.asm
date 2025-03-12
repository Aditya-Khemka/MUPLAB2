.model	tiny
.486
.data
dat1	db		13
dat2	db		?
fil1	db		14 dup(0)
fil2	db		'test1.txt',0
.code
.startup
		mov		ah,0Ah
		lea		dx,dat1
		int		21h
		lea		di,fil1
		mov		bl,dat2
		xor 	bh,bh
		mov		[di+bx],bh
		lea		dx,fil1
		lea		di,fil2
		mov		ah,56h		
		int		21h
.exit
end