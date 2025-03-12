.model	tiny
.486
.data
dis1	db		22h,0,22h,'$'
.code
.startup
		mov		ah,08h
		int		21h
		mov		cl,al
		and		cl,0fh
		mov		ah,08h
		int		21h
		and		al,0fh
		sub		cl,al
		or		cl,30h
		mov		[dis1+1],cl
		lea		dx,dis1
		mov		ah,09h		
		int		21h
.exit
end