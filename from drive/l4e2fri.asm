.model	tiny
.486
.data
.code
.startup
x1:		mov		ah,08h
		int		21h
		cmp		al,'#'
		jz		x2
		sub		al,20h
		mov		dl,al
		mov		ah,02h		
		int		21h
		jmp		x1
x2:
.exit
end