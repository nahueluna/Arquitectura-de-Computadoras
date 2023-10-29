ORG 1000H
num1 db 7
num2 db 3
res db ?

ORG 2000H
mov ah,num1
mov al,num2
mov bx,offset res
call RESTO
hlt

ORG 3000H
RESTO: cmp al,0  ;averiguo si divisor es 0
jz FIN
DIVISION: sub ah,al
jz FIN  ;si es divisible el resto es 0 y debo saltar inmediatamente
cmp ah,al
jns DIVISION  ;si ah es mayor a al, aun se puede seguir dividiendo
FIN:  mov [bx],ah
ret
end