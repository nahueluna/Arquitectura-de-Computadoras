PIC         EQU 20H
EOI         EQU 20H
N_F10       EQU 10

            ORG 40
IP_F10      DW RUT_F10

             ORG 2000H
             CLI
             MOV AL, 0FEH
             OUT PIC+1, AL ; PIC: registro IMR
             MOV AL, N_F10
             OUT PIC+4, AL ; PIC: registro INT0
             MOV DX, 0
             STI
LAZO:        JMP LAZO

             ORG 3000H
RUT_F10:     PUSH AX
             INC DX
             MOV AL, EOI
             OUT EOI, AL ; PIC: registro EOI
             POP AX
             IRET
 END

 ;a) 
 ;- ISR: dirección 23h. Indica la interrupción en servicio (segun el bit en 1)
 ;- IRR: dirección 22h. Indica lo/s pedidos de atención de interrrupciones, según el bit en 1
 ;- IMR: dirección 21h. Indica las interrupciones enmascaradas (no serán atendidas). Se enmascara con 1 y se permite con 0.
 ;- INT0-INT7: dirección 24h a 2Bh. Registros que representan las conexiones a los dispositivos capaces de hacer un pedido 
 ;interrupción por hardware. En ellos se almacena la posicion (no dirección de memoria) del vector de interrupciones 
 ;correspondiente a cada uno. Van de 0 (más prioritario) a 7 (menos prioritario).

 ;b)
 ;El IMR es programable para controlar el enmascaramiento de los pedidos de interrupción. Los registros INT0-INT7 son
 ;modificables para indicar la posicion del vector de interrupciones (deberemos setearlo en base a la dirección escogida
 ;en el programa). ISR e IRR no son programables, sino que indican el estado de las interrupciones (servicio/pedido).
 ;La instrucción OUT transfiere datos del procesador (registro de la CPU) a "memoria" E/S (es un OUT desde el punto de
 ;vista de la CPU).

 ;c)
 ;La instrucción CLI desactiva las interrupciones mediante el IF (interruption flag), enmascarandolas. STI las habilita.
 ;Se utiliza para desactivar las interrupciones mientras se configura el PIC (y evitar un llamado mientras no se han
 ;configurado sus posiciones).