ORG 1000h
carac db ?
msj1 db "INGRESE UN NUMERO: "
FIN1 db ?
msj2 db " - CARACTER NO VALIDO"
FIN2 db ?
resul db ?

ORG 2000h
mov bx, offset msj1
mov al, offset FIN1 - offset msj1
int 7
mov bx, offset carac
int 6
mov al, 1
int 7
call ES_NUM
mov resul,al
int 0

;bx parametro entrada por referencia. Dirección de caracter ingresado
;al parametro salida por valor. Codigo de funcionamiento del proceso
ORG 3000h
ES_NUM: 
cmp byte ptr [bx],30h
js NO_NUM
cmp byte ptr [bx],3Ah
jns NO_NUM
mov al,0FFh
jmp FINAL
NO_NUM: mov bx,offset msj2
mov al, offset FIN2 - offset msj2
int 7
mov al,00h
FINAL: ret
end