HAND          EQU 40H
              
              ORG 1000H
CADENA        DB "JAhyOkiR75!e"
FIN           DB ?
VOCALES       DB "AaEeIiOoUu"
FIN_V         DB ?
MSJ           DB "ES VOCAL",0AH
FIN_MSJ       DB ?

              ORG 3000H
CONFIG_HAND:  IN AL, HAND+1
              OR AL, 80H  ;activo interrupciones
              OUT HAND+1, AL

              RET

              ;BX parametro de entrada por referencia por registro. Caracter de cadena
              ;CL parametro de entrada por valor por registro. cantidad de caracteres
              ORG 3500H
IMPRIMIR:     PUSH AX
              PUSH DX
              PUSH BX 
              
              CALL EVAL_VOCAL
              CMP DL, 0FFH
              JNZ NO_VOCAL

              CALL POLL
              MOV AL, [BX]
              OUT HAND, AL

              MOV BX, OFFSET MSJ
              MOV AL, OFFSET FIN_MSJ - OFFSET MSJ
              INT 7

NO_VOCAL:     POP BX
              INC BX
              DEC CL

              POP DX
              POP AX
              RET

              ORG 4000H
POLL:         IN AL, HAND+1
              AND AL, 1
              JNZ POLL
              RET

              ;BX parametro entrada por referencia por registro. Caracter de la cadena
              ;DL parametro salida por valor por registro. FF si es vocal, 00 si no
              ORG 4500H
EVAL_VOCAL:   PUSH AX
              PUSH BX
              
              MOV AL, [BX]
              MOV BX, OFFSET VOCALES
              MOV AH, OFFSET FIN_V - OFFSET VOCALES
              
EVALUAR:      CMP AL, [BX]
              JZ VOCAL
              INC BX
              DEC AH
              JNZ EVALUAR

              MOV DL, 00H
              JMP TERMINAR

VOCAL:        MOV DL, 0FFH

TERMINAR:     POP BX
              POP AX
              RET
              

              ORG 2000H
              CALL CONFIG_HAND
              
              MOV BX, OFFSET CADENA
              MOV CL, OFFSET FIN - OFFSET CADENA

LOOP:         CALL IMPRIMIR
              CMP CL, 0
              JNZ LOOP

              INT 0
END