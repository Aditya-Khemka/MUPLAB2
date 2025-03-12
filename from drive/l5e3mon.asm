.model	tiny
.486
.data
fil1	db		"lab.txt",0
pnt		dw		?
handle	dw		?
dat1	db		?
.code
.startup
		mov		ah,08h
		int		21h
		mov		ah,0
		and		al,0fh
		mov		cl,10
		mul		cl
		mov		pnt,ax
		lea		dx,fil1
		mov		al,2
		mov		ah,3dh
		int 	21h
		mov		handle,ax
		mov		ah,42h
		mov		al,0
		mov		dx,pnt
		mov		cx,0
		mov		bx,handle
		int		21h
		mov		ah,3fh
		mov		bx,handle
		mov		cx,1
		lea		dx,dat1
		int		21h
		mov		ah,3eh
		mov		bx,handle
		int		21h
		mov		dl,dat1
x2:		mov		ah,02h		
		int		21h
.exit
end