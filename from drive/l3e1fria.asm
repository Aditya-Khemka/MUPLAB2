.model	tiny
.486
.data
arr1	db		45h,82h,91h,73h,13h
arr2	db		20h,7fh,33h,8eh,45h
arr3	dw		5 dup(0)
.code
.startup
		lea		si,arr1
		lea		bx,arr2
		lea		di,arr3
		mov		cx,5
x1:		lodsb
		movzx	ax,al
		mov		dl,[bx]
		movzx	dx,dl
		add		ax,dx
		stosw
		inc		bx
		loop	x1
.exit
end