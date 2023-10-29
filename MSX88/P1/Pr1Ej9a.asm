ORG 1000H
byte1 db 94h

ORG 2000H
mov al,byte1
call ROTARIZQ
hlt

;al parametro entrada con byte
ORG 3000H
ROTARIZQ:add al,al
adc al,0
mov byte1,al
ret
end