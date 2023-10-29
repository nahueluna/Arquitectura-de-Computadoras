SALTO_POS   EQU 6

            ORG 1000h
CERO        db "CERO  "
            db "UNO   "
            db "DOS   "
            db "TRES  "
            db "CUATRO"
            db "CINCO "
            db "SEIS  "
            db "SIETE "
            db "OCHO  "
            db "NUEVE "
msj1        db "Ingrese un numero: "
FIN1        db ?
msj2        db "Caracter no valido",0Ah
FIN2        db ?
digito      db ?
LF          db 0Ah

            ORG 2000h
REINICIAR:  mov cl,0  ;Lo uso de contador para las veces que aparece el 0
INGRESO:    mov bx, offset msj1
            mov al, offset FIN1 - offset msj1
            int 7
            mov bx, offset digito
            int 6
            
            call ES_NUM  ;verifica que el caracter ingresado es un numero
            cmp al, 00h  ;si no lo es, pide ingresar nuevamente
            jz INGRESO
            
            call CALC_POS  ;las cadenas de los numeros ocupan 6 bytes. La subrutina calcula su posicion
            mov bx, offset CERO
            add bl, digito ;el valor de digito me indica el valor de la parte baja de la posicion de memoria del numero correspondiente
            mov al,6
            int 7
            ;Salta linea, imprime LF
            mov bx, offset LF
            mov al,1
            int 7
            
            cmp digito, 0
            jnz REINICIAR
            inc cl
            cmp cl,2
            jnz INGRESO
            
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
NO_NUM:     mov bx,offset msj2
            mov al, offset FIN2 - offset msj2
            int 7
            mov al,00h
FINAL:      ret

;Multiplica el número ingresado por 6 para saber su ubicacion
            ORG 4000h
CALC_POS:   push cx
            push ax
            push dx
            mov dl,0
            mov al, digito
            sub al,30h
            cmp al,0
            jz F_SR
            mov cl,SALTO_POS
MUL:        add dl,al
            dec cl
            jnz MUL
F_SR:       mov digito,dl
            pop dx
            pop ax
            pop cx
            ret
end