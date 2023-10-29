HNDSHK        EQU 40H

              ORG 1000H
MSJ           DB "INGENIERIA E INFORMATICA"
FIN           DB ?

              ORG 3000H
CONFIG_HNDSHK:PUSH AX

              IN AL, HNDSHK+1
              AND AL, 7FH  ;apaga las interrupciones
              OUT HNDSHK+1, AL

              POP AX
              RET

              ORG 3500H
POLL:         IN AL, HNDSHK+1
              AND AL, 1
              JNZ POLL
              RET

              ORG 2000H
              MOV BX, OFFSET MSJ
              MOV CL, OFFSET FIN - OFFSET MSJ
              CALL CONFIG_HNDSHK
              
LOOP:         CALL POLL
              MOV AL, [BX]
              OUT HNDSHK, AL
              INC BX
              DEC CL
              JNZ LOOP

              INT 0
END