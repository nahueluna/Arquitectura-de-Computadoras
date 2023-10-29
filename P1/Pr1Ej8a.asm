ORG 1000H
cadena db "abcdef",00h
resultado dw ?

ORG 2000H
mov bx, offset cadena
call LONGITUD
mov resultado,cx
hlt

;bx parámetro de entrada. Referencia de inicio de cadena
;cx parámetro de salida por valor. Contador de caracteres
ORG 3000H
LONGITUD: mov cx,0
COMP: cmp byte ptr [bx], 00h
jz FIN
inc cx  ;incrementa contador
inc bx  ;pasa a siguiente posicion de la cadena
jmp COMP
FIN: ret
end
