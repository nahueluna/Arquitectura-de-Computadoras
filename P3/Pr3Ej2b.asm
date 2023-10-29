PA          EQU 30H
PB          EQU 31H
CA          EQU 32H
CB          EQU 33H

            ORG 1000H
CADENA      DB "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS"
FIN         DB ?

            ORG 3000H
            ;configuro CA. Busy entrada, Strobe salida
CONFIG_PIO: PUSH AX
            MOV AL, 01H
            OUT CA, AL
            ;configuro CB. Todos bits de salida
            MOV AL, 00H
            OUT CB, AL
            POP AX
            RET

            ORG 3500H
            ;pongo bit de Strobe en 0
STROBE0:    PUSH AX
            IN AL, PA
            AND AL, 0FDH
            OUT PA, AL
            POP AX
            RET

            ORG 4000H
            ;pongo bit de Strobe en 1
STROBE1:    PUSH AX
            IN AL, PA
            OR AL, 02H
            OUT PA, AL
            POP AX
            RET

            ORG 4500H
            ;consulto estado de Busy
POLL:       PUSH AX
POLLING:    IN AL, PA
            AND AL, 1
            JNZ POLLING
            POP AX
            RET

            ORG 2000H
            CALL CONFIG_PIO
            
            MOV BX, OFFSET CADENA
            MOV CL, OFFSET FIN - OFFSET CADENA
            
LOOP:       CALL POLL
            MOV AL, [BX]
            OUT PB, AL
            
            CALL STROBE0
            CALL STROBE1
            
            INC BX
            DEC CL
            JNZ LOOP
            
            INT 0
END