ORG 1000H
cadena db "jkmhi9h8",00h
caracter db "H"
resul db ?

ORG 2000H
mov al,caracter
mov bx,offset cadena
push ax
push bx
call CONTAR_CAR
mov resul,cl
pop ax  ;vacío pila
pop ax
hlt

;ax parametro entrada por valor y pila. Caracter a buscar
;bx parametro entrada por referencia y pila. Direccion inicio cadena
;cl parametro salida por valor y registro. Conteo caracter
ORG 3000H
CONTAR_CAR: mov cl,0
mov bx, sp
add bx,4  ;me muevo en la pila hasta ax
mov ax,[bx]
sub bx,2  ;me muevo en pila hasta bx
mov bx,[bx]
dec bx  ;para inc en el siguiente y ahorrar jmps
CONTEO: inc bx
cmp byte ptr [bx],00h
jz FIN
cmp byte ptr [bx],al
jnz CONTEO
inc cl
jmp CONTEO
FIN:ret
end