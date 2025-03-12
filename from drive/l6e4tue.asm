.model	tiny
.486
.data
fil1	db		'lab.txt',0
fil2	db		'tab.txt',0
mem1	db		?
han1	dw		?
han2	dw		?
dat1	db		?
dat2	db		?
.code
.startup
		mov		ah,08h
		int		21h
		and		al,0fh
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
		mov		dh,0
		mov		dl,mem1
		int		21h
		mov		ah,3fh
		mov		bx,han1
		mov		cx,1
		lea		dx,dat1
		int		21h
		mov		ah,3dh
		mov		al,2
		lea		dx,fil2
		int		21h
		mov		han2,ax
		mov		ah,42h
		mov		al,0
		mov		bx,han2
		mov		cx,0
		mov		dh,0
		mov		dl,mem1
		int		21h
		mov		ah,3fh
		mov		bx,han2
		mov		cx,1
		lea		dx,dat2
		int		21h
		mov		ah,42h
		mov		al,0
		mov		bx,han1
		mov		cx,0
		mov		dh,0
		mov		dl,mem1
		int		21h
		mov		ah,40h
		mov		bx,han1
		mov		cx,1
		lea		dx,dat2
		int		21h
		mov		ah,42h
		mov		al,0
		mov		bx,han2
		mov		cx,0
		mov		dh,0
		mov		dl,mem1
		int		21h
		mov		ah,40h
		mov		bx,han2
		mov		cx,1
		lea		dx,dat1
		int		21h
		mov		bx,han1
		mov		ah,3eh
		int		21h
		mov		bx,han1
		mov		ah,3eh
		int		21h
.exit
end