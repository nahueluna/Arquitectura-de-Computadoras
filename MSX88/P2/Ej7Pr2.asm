UNO           EQU 31h
              
              ORG 1000h
msj           db "Ingrese dos numeros: "
fin           db ? 
num1          db ?
num2          db ?
resul         db ?
SIGNO_SUMA    db " + "
SIGNO_IGUAL   db " = "

              ORG 2000h
              mov bx,offset msj
              mov al, offset fin - offset msj
              int 7
              ;Leo numeros e imprimo
              mov bx,offset num1
              mov al,1
              int 6
              int 7
              mov bx, offset SIGNO_SUMA
              mov al, 3
              int 7
              mov bx, offset num2
              mov al, 1
              int 6
              int 7
              ;Convierto de ASCII a numero
              sub byte ptr [bx],30h
              dec bx
              sub byte ptr [bx],30h
              ;sumo los numeros
              mov ah,num2
              add ah,[bx]

              mov bx, offset SIGNO_IGUAL
              mov al,3
              int 7
              mov bx,offset resul
              mov al, 1
              ;verifico si tiene dos cifras
              cmp ah,10
              js IMPRESION
              ;si tiene dos cifras, imprimo el 1 primero
              mov resul,UNO
              int 7
              sub ah,10  ;resto 10 para quedarme con la cifra de unidad
              

IMPRESION:    add ah,30h
              mov resul,ah
              int 7

              int 0
end