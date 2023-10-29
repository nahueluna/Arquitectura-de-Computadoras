ORG 1000H
vocales db "AaEeIiOoUu",00h
cadena db "a0?*ihpU",00h
resul dw ?

ORG 2000H
mov bx, offset cadena
call CONTAR_VOC
mov resul,cx
hlt

;bx parametro entrada. Referencia de cadena
;cx parametro salida por valor. Contador de vocales
ORG 3000H
CONTAR_VOC: push dx
push ax
mov cx,0
LOOP1: cmp byte ptr [bx],00h
jz FIN1
mov al,[bx]
call ES_VOCAL
cmp dx,0FFh
jnz RECORRER
inc cx
RECORRER: inc bx
jmp LOOP1
FIN1: pop ax
pop dx
ret

;al parametro entrada por valor. Caracter de cadena
;dx parametro salida por valor. Indicador vocal o no
ORG 4000H
ES_VOCAL: push bx
mov bx, offset vocales
LOOP2: cmp byte ptr [bx],00h
jz NO_VOCAL
cmp al,[bx]
jz VOCAL
inc bx
jmp LOOP2
NO_VOCAL: mov dx,00h
jmp FIN2
VOCAL: mov dx,0FFh
FIN2: pop bx
ret
end