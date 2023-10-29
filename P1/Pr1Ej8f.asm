ORG 1000H
cadena db "gojeokpo",00h
original db "o"
reemplazo db "x"

ORG 2000H
mov ah,original
mov al,reemplazo
mov bx, offset cadena
push ax
push bx
call REEMPLAZAR_CAR
pop ax
pop ax
hlt

ORG 3000H
REEMPLAZAR_CAR: mov bx,sp
add bx,4
mov ax,[bx]
sub bx,2
mov bx,[bx]
dec bx
LOOP: inc bx
cmp byte ptr [bx],00h
jz FIN
cmp [bx],ah
jnz LOOP
mov [bx],al
jmp LOOP
FIN:ret
end