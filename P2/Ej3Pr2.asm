ORG 1000h
mayus db 41h
minus db 61h

ORG 2000h
mov cl,26
mov al,1
LOOP: mov bx,offset mayus
int 7
inc byte ptr [bx]
mov bx, offset minus
int 7
inc byte ptr [bx]
dec cl
jnz LOOP
int 0
end