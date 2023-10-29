ORG 1000H
dato1 dw 1234h
dato2 dw 5678h

ORG 2000H
mov ax,offset dato1
mov bx, offset dato2
push ax
push bx
call SWAP
hlt

ORG 3000H
SWAP: mov bx,sp
add bx,4
push bx
mov bx,[bx]
mov bx,[bx]
mov ax,bx
pop bx
sub bx,2
mov bx,[bx]
mov bx,[bx]
mov dato1,bx
mov dato2,ax
ret
end