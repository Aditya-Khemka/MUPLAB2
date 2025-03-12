.model	tiny
.486
.data





marks	db  "2020A3PS0132G A", "2021A7PS0002G B"
		db	"2020A8B30127G C", "2021A7PS0008G D" 
		db	"2020A3PS0134G A", "2021A7PS0009G B"
		db	"2020A8B30129G E", "2021A7PS0008G C"
count	db	8
acnt	db	0
bcnt	db	0
ccnt	db	0
dcnt	db	0
ecnt	db	0
.code
.startup
		lea		di,marks
		movzx	cx,count
		mov		dl,0
x1:		add		di,14
		mov		al,'A'
		scasb
		jne		x2
		inc		dl
x2:		loop 	x1
		mov		acnt,dl
		lea		di,marks
		movzx	cx,count
		mov		dl,0
x3:		add		di,14
		mov		al,'B'
		scasb
		jne		x4
		inc		dl
x4:		loop	x3
		mov		bcnt,dl
		lea		di,marks
		movzx	cx,count
		mov		dl,0
x5:		add		di,14
		mov		al,'C'
		scasb
		jne		x6
		inc		dl
x6:		loop	x5
		mov		ccnt,dl
		lea		di,marks
		movzx	cx,count
		mov		dl,0
x7:		add		di,14
		mov		al,'D'
		scasb
		jne		x8
		inc		dl
x8:		loop	x7
		mov		dcnt,dl
		lea		di,marks
		movzx	cx,count
		mov		dl,0
x9:		add		di,14
		mov		al,'E'
		scasb
		jne		x10
		inc		dl
x10:	loop	x9
		mov	ecnt,dl
		
.exit
end