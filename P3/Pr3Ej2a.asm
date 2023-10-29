PA          EQU 30H
PB          EQU 31H
CA          EQU 32H
CB          EQU 33H

            ORG 1000H
CHAR        DB "A"

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
            ;configuro PIO para la impresora
            CALL CONFIG_PIO
            ;consulto si la impresora está ocupada
            CALL POLL
            ;envio caracter
            MOV AL, CHAR
            OUT PB, AL
            ;envío flanco ascendente de Strobe
            CALL STROBE0
            CALL STROBE1
            INT 0
END