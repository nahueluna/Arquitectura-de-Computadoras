HAND          EQU 40H

              ORG 1000H
MSJ           DB ?

              ORG 3000H
CONFIG_HAND:  PUSH AX

              IN AL, HAND+1
              AND AL, 7FH  ;apago interrupcion
              OUT HAND+1, AL

              POP AX
              RET

              ORG 3500H
LEER:         MOV BX, OFFSET MSJ
              MOV CL, 0

LECTURA:      INT 6
              INC BX
              INC CL
              CMP CL, 5
              JNZ LECTURA

              RET

              ORG 4000H
POLL:         IN AL, HAND+1
              AND AL, 1
              JNZ POLL

              RET

              ORG 2000H
              CALL CONFIG_HAND
              
              CALL LEER  ;leo los caracteres
              MOV BX, OFFSET MSJ  ;vuelvo a la direccion de primer letra
              PUSH CX

LOOP1:        CALL POLL  ;imprimo en orden ingresado
              MOV AL, [BX]
              OUT HAND, AL
              INC BX
              DEC CL
              JNZ LOOP1

              POP CX  ;recupero cantidad de caracteres para contador
              DEC BX  ;sino se pasa por una direccion

LOOP2:        CALL POLL  ;imprimo en orden inverso
              MOV AL, [BX]
              OUT HAND, AL
              DEC BX
              DEC CL
              JNZ LOOP2

              INT 0
END