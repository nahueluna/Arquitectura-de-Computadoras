ORG 1000H
num1 dw 0F871h,0A765h
num2 dw 0A876h,00FFh
resul dw ?,?

ORG 2000H
mov cl,2
mov bx,offset num1
APILAR: add bx,2 ;apilo los dos numeros, parte baja y alta
mov ax,[bx]
push ax
sub bx,2
mov ax,[bx]
push ax
add bx,4
dec cl
cmp cl,0
jnz APILAR
mov bx,offset resul+2
push bx
sub bx, 2
push bx
call SUM32
mov cl,6
DESAPILAR: pop ax  ;desapilo para vaciar pila
dec cl
jnz DESAPILAR
hlt

;num1 ocupa 4 celdas de memoria (desde final de pila)
;num2 ocupa las siguientes 4 celdas
;offset resul ocupa las siguientes 4 celdas
SUM32: mov bx,sp
;parte baja
add bx,6
mov ax,[bx]
add bx,4
add ax,[bx]
pushf
sub bx,8
push bx
mov bx,[bx]  ;paso a bx la direccion de resul (que esta en la pila)
mov [bx],ax
pop bx
;parte alta
add bx,6
mov ax,[bx]
add bx,4
popf
adc ax,[bx]
sub bx,8
mov bx,[bx]
mov [bx],ax

ret
end