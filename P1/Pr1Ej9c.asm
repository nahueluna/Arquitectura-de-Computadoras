ORG 1000H
byte1 db 94h
N db 6

ORG 2000H
mov al,byte1
mov ah,N
call ROTARDER_N
hlt

ORG 3000H
ROTARDER_N: push dx
mov dl,8
sub dl,ah
mov ah,dl
call ROTARIZQ_N
pop dx
ret

;al parametro entrada por valor con byte
;ah parametro entrada por valor con cantidad rotaciones
ORG 4000H
ROTARIZQ_N: cmp ah,0
jz FIN
call ROTARIZQ
dec ah
jmp ROTARIZQ_N
FIN:ret

;al parametro entrada por valor con byte
ORG 5000H
ROTARIZQ:adc al,al
adc al,0
mov byte1,al
ret
end