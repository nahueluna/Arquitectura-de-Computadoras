                ORG 1000h
msj             db "Ingrese clave: "
fin1            db  ?
clave           db "y5F?"
clave_leida     db ?,?,?,?
permitido       db "Acceso permitido"
fin2            db ?
denegado        db "Acceso denegado"
fin3            db ?
refresh         db 8Ch

                ORG 2000h
                mov bx, offset msj
                mov al, offset fin1 - offset msj
                int 7
                ;ingreso clave
                mov cl,4
                mov bx, offset clave_leida-1
INGRESO:        inc bx
                int 6
                dec cl
                jnz INGRESO

                mov bx, offset clave
                push bx
                mov bx, offset clave_leida
                push bx
                call EVALUAR_CLAVE
                int 0

                ;bx como parámetro de entrada por referencia por pila
                ORG 3000h
EVALUAR_CLAVE:  mov bx,sp
                push ax
                push dx

                add bx,2  ;accedo a posicion en la pila de offset clave_leida
                push bx  ;guardo esa posicion
                mov bx,[bx]  ;muevo offset clave_leida
                mov dx,[bx]  ;muevo parte baja de clave_leida a dx
                pop bx  ;recupero posicion de offset clave_leida
                add bx,2  ;voy a posicion en la pila de offset clave
                push bx  ;guardo esa posicion
                mov bx,[bx]  ;muevo offset clave a bx
                cmp dx,[bx]  ;comparo parte baja de clave_leida con parte baja de clave
                pop bx  ;recupero posicion en la pila de offset clave (aca por si salto en el siguiente jnz)
                jnz INCORRECTO  ;si no fueron iguales salto
                
                sub bx,2  ;voy a posicion en la pila de offset clave_leida
                add byte ptr [bx],2  ;incremento en 2 offset clave_leida para pasar a parte alta
                push bx  ;guardo posicion de la pila de offset clave_leida+2
                mov bx,[bx]  ;muevo offset clave_leida+2 a bx
                mov dx,[bx]  ;muevo parte alta de clave_leida a dx
                pop bx  ;recupero posicion de la pila de offset clave_leida+2
                add bx,2  ;voy a posicion en la pila de offset clave
                add byte ptr [bx],2  ;incremento en 2 offset clave para pasar a parte alta
                mov bx,[bx] ;muevo a bx offset clave+2
                cmp dx,[bx]  ;comparo partes altas de clave_leida y clave
                jnz INCORRECTO  ;si no fueron iguales salto

                mov bx,offset permitido  ;si no salté imprimo acceso permitido
                mov al,offset fin2 - offset permitido
                int 7
                jmp TERMINAR  ;termino rutina

INCORRECTO:     mov bx,offset denegado  ;si salte en alguna de las dos instancias, imprimo acceso denegado
                mov al,offset fin3 - offset denegado
                int 7

TERMINAR:       pop dx
                pop ax
                ret
                
                end