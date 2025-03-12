.model	tiny
.486
.code
.startup
		mov		ah,08h
		int		21h
		and		al,0fh
		movzx	cx,al
		mov		dl,'$'
x1:		mov		ah,02h		
		int		21h
		loop	x1
.exit
end