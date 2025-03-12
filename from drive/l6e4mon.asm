.model	tiny
.486
.data
fil1	db		'lab.txt',0
fil2	db		'tab.txt',0
han1	dw		?
han2	dw		?
mem1	db		65 dup(0)
mem2	db		65 dup(0)
.code
.startup
		mov		ah,3dh
		mov		al,2
		lea		dx,fil1
		int		21h
		mov		han1,ax
		mov		ah,3fh
		mov		bx,han1
		mov		cx,65
		lea		dx,mem1
		int		21h
		mov		ah,3dh
		mov		al,2
		lea		dx,fil2
		int		21h
		mov		han2,ax
		mov		ah,3fh
		mov		bx,han2
		mov		cx,65
		lea		dx,mem2
		int		21h
		mov		ah,42h
		mov		al,0
		mov		bx,han1
		mov		cx,0
		mov		dx,0
		int		21h
		mov		ah,40h
		mov		bx,han1
		mov		cx,65
		lea		dx,mem2
		int		21h
		mov		bx,han1
		mov		ah,3eh
		int		21h
		mov		ah,42h
		mov		al,0
		mov		bx,han2
		mov		cx,0
		mov		dx,0
		int		21h
		mov		ah,40h
		mov		bx,han2
		mov		cx,65
		lea		dx,mem1
		int		21h
		mov		bx,han2
		mov		ah,3eh
		int		21h
.exit
end