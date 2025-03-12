.model	tiny
.486
.data
arr1	db		01h,02h,03h,04h,05h,06h,07h,08h,09h,10h
arr2	db		11h,12h,13h,14h,15h,16h,17h,18h,19h,20h
tmp1	db 		10 dup(?)
.code
.startup
		mov		cx,10
		lea		si,arr1
		lea		di,arr2
x1:		mov		al,[di]
		xchg	al,[si]
		stosb
		inc		si
		loop	x1
.exit
end