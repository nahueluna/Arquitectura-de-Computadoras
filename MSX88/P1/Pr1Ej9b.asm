ORG 1000H
byte1 db 94h
N db 2

ORG 2000H
mov al,byte1
mov ah,N
call ROTARIZQ_N
hlt

;al parametro entrada por valor con byte
;ah parametro entrada por valor con cantidad rotaciones
ORG 3000H
ROTARIZQ_N: cmp ah,0
jz FIN
call ROTARIZQ
dec ah
jmp ROTARIZQ_N
FIN:ret

;al parametro entrada por valor con byte
ORG 4000H
ROTARIZQ:adc al,al
adc al,0
mov byte1,al
ret
end