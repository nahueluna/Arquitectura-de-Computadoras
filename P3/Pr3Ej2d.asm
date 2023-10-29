PA          EQU 30H
PB          EQU 31H
CA          EQU 32H
CB          EQU 33H
PIC         EQU 20H
EOI         EQU 20H
N_F10       EQU 10

            ORG 40
IP_F10      DW RUT_F10

            ORG 1000H
CHAR        DB ?

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

            ORG 5000H
RUT_F10:    MOV DL, 1

            MOV AL, 0FFH
            OUT PIC+1, AL  ;quiero evitar volver a interrumpir
            
            MOV AL, EOI
            OUT PIC, AL
            IRET
            
            ORG 2000H
            CLI
            MOV AL, 0FEH
            OUT PIC+1, AL  ;IMR

            MOV AL, N_F10
            OUT PIC+4, AL  ;INT0

            MOV BX, OFFSET CHAR
            MOV CL, 0
            MOV DL, 0

            CALL CONFIG_PIO
            STI
            
LECTURA:    INT 6
            INC BX
            INC CL
            CMP DL, 1
            JNZ LECTURA

            MOV BX, OFFSET CHAR
            
IMPRESION:  CALL POLL
            
            MOV AL, [BX]
            OUT PB, AL
            
            CALL STROBE0
            CALL STROBE1

            INC BX
            DEC CL
            JNZ IMPRESION
            
            INT 0
END