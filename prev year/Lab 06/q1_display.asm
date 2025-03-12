.model tiny
.186
.data
in1 db 21              ; 20 characters + enter
in2 db ?
in3 db 22 dup('$')     ; 20 characters + enter + '$'
disnl db 0DH,0AH,'$'

.code
.startup
LEA DX,in1
mov AH,0AH
int 21H

LEA DX,disnl
mov AH,09H
int 21H

LEA DX,in3
mov AH,09H
int 21H

.exit
end