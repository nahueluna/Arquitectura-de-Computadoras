;entre a=97 y z=122
ORG 1000H
cadena db "aBCd7f?",00h
resultado dw ?

ORG 2000H
mov bx, offset cadena
call CONTAR_MIN
mov resultado, cx
hlt

;bx parámetro de entrada. Referencia de inicio de cadena
;cx parámetro salida por valor. Contador de minúsculas
ORG 3000H
CONTAR_MIN: mov cx,0
COMP: cmp byte ptr [bx],00h  ;comparacion para final cadena
jz FIN
cmp byte ptr [bx],97  ;valor de a en ASCII
js PASAR  ;si es menor a 97 no me sirve y salta
cmp byte ptr [bx],123
jns PASAR  ;si es mayor igual a 123 no me sirve y salta
inc cx
PASAR: inc bx
jmp COMP
FIN: ret
end