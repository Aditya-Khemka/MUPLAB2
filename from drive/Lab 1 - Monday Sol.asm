.model	tiny
.486
.data
dat1	dw		4567h,2345h,6789h,1234h,9abcdh
.code
.startup
		lea		di,dat1
		mov		cx,5
x1:		mov		ax,[di]
		xchg	al,ah
		stosw
		loop	x1
.exit
end