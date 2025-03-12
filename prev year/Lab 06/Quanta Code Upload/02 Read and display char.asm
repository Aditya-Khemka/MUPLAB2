;Read one char from keyboard and display
.model tiny
.186
.data
userData db ? 
.code
.startup
mov ah,1
int 21H
mov userData,al
mov dl,userData
mov ah,2
int 21H
.exit
end