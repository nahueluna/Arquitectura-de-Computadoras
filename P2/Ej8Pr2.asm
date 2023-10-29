              ORG 1000h
msj           db "Ingrese dos numeros: "
fin           db ?
signo_mas     db " + "
signo_menos   db " - "
signo_igual   db " = "
num1          db ?
num2          db ?
resul         db ?

              ORG 2000h
              ;imprimir mensaje
              mov bx,offset msj
              mov al, offset fin - offset msj
              int 7
              ;leer e imprimir numeros
              mov bx,offset num1
              mov al,1
              int 6
              int 7
              mov bx,offset signo_menos
              mov al,3
              int 7
              mov bx, offset num2
              mov al,1
              int 6
              int 7
              mov bx, offset signo_igual
              mov al, 3
              int 7
              ;resta de numeros
              mov ah,num1
              sub ah,num2
              js NEGATIVO
              ;si es positivo imprimo "+"
              mov bx,offset signo_mas
              int 7
              jmp IMPRIMIR
              ;si es negativo calculo ca2 e imprimo "-"
NEGATIVO:     neg ah
              mov bx, offset signo_menos
              int 7
              ;imprimo resultado
IMPRIMIR:     add ah,30h
              mov resul, ah
              mov bx, offset resul
              mov al,1
              int 7

              int 0
end