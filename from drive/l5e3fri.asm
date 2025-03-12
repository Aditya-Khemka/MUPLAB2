.model	tiny
.486
.data
fil1	db		"lab.txt",0
fil2	db		"tab.txt",0
dat1	db		5 dup(0)
han1	dw		?
han2	dw		?
.code
.startup
		lea		dx,fil1
		mov		al,2
		mov		ah,3dh
		int 	21h
		mov		han1,ax
		mov		ah,42h
		mov		al,2
		mov		dx,0fffbh
		mov		cx,0ffffh
		mov		bx,han1
		int		21h
		mov		ah,3fh
		mov		bx,han1
		mov		cx,5
		lea		dx,dat1
		int		21h
		mov		ah,3eh
		mov		bx,han1
		int		21h
		lea		dx,fil2
		mov		al,2
		mov		ah,3dh
		int 	21h
		mov		han2,ax
		mov		ah,42h
		mov		al,2
		mov		dx,0h
		mov		cx,0h
		mov		bx,han2
		int		21h
		mov		ah,40h
		mov		bx,han2
		mov		cx,5
		lea		dx,dat1
		int		21h
		mov		ah,3eh
		mov		bx,han1
		int		21h
.exit
end