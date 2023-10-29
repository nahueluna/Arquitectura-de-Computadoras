;Escribir un programa para MSX88 que primero solicite el ingreso por teclado 
;de un número X. Posteriormente, el programa debe pedir el ingreso de X caracteres 
;por teclado y, una vez finalizado el ingreso, los envié a la impresora utilizando 
;el Handshake. La comunicación se debe establecer por consulta de estado (polling).

DATO            EQU 40H
ESTADO          EQU 41H

                ORG 1000H
MSJ             DB "INGRESE UN NUMERO: "
FIN             DB ?
NUM             DB ?
CADENA          DB ?

                ORG 3000H
LEER:           PUSH BX
                PUSH CX
                
                MOV BX, OFFSET CADENA
                
LOOP:           INT 6
                INC BX
                DEC CL
                JNZ LOOP

                POP CX
                POP BX
                RET

                ORG 3500H
POLL:           PUSH AX

CONSULTA:       IN AL, ESTADO
                AND AL, 1
                JNZ CONSULTA

                POP AX
                RET

                ORG 2000H
                MOV BX, OFFSET MSJ
                MOV AL, OFFSET FIN - OFFSET MSJ
                INT 7

                MOV BX, OFFSET NUM
                INT 6

                MOV AL, 1
                INT 7

                MOV CL, NUM
                SUB CL, 30H

                CALL LEER
                MOV BX, OFFSET CADENA

IMPRIMIR:       CALL POLL
                MOV AL,[BX]
                OUT DATO, AL
                INC BX
                DEC CL
                JNZ IMPRIMIR

                INT 0
END