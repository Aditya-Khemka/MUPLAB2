.model	tiny
.486
.data
dat1	db		67h,85h,89h,34h,0abh,45h,23h,78h,34h,0cdh
cnt1	dw		0ah
.code
.startup
		lea		di,dat1
		mov		cx,cnt1
x1:		mov		al,[di]
		rol		al,7
		jnc		x2
		neg		byte ptr[di]
x2:		inc		di
		loop	x1
.exit
end