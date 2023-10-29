ORG 1000H
num1 db 6
num2 db 2
resul dw ?

ORG 2000H
mov ah,num1
mov al,num2
push ax
mov ax, 0  ;guardo espacio en la pila para luego mandar el resultado
push ax
call DIV
pop ax  ;desapilo el resultado
mov resul,ax
pop ax  ;desapilo "basura"
hlt

ORG 3000H
DIV: push cx
mov cx,0
mov bx,sp
add bx,6
mov ax,[bx]
cmp al,0  ;que el divisor no sea 0
jz FIN
LOOP: sub ah,al
inc cx
cmp ah,0
jnz LOOP
sub bx,2
FIN:mov [bx],cx
pop cx
ret
end