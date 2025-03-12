.model	tiny
.486
.data
dis1	db		"Microprocessor$"
dis2	db		"Interfacing$"
dis3	db		"######$"
.code
.startup
		mov		ah,08h
		int		21h
		lea		dx,dis3
		cmp		al,'a'
		jne		x1
		lea		dx,dis1
x1:		cmp		al,'b'
		jne		x2
		lea		dx,dis2
x2:		mov		ah,09h		
		int		21h
.exit
end