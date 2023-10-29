PIC         EQU 20H
EOI         EQU 20H
N_F10       EQU 10
N_CLK       EQU 11
TIMER       EQU 10H

            ORG 40
IP_F10      DW RUT_F10

            ORG 44
IP_CLK      DW RUT_CLK

            ORG 3000H
RUT_F10:    PUSH AX
            
            MOV CL, 1
            MOV AL,0
            OUT TIMER, AL
            MOV AL,EOI
            OUT PIC, AL
            POP AX
            IRET

            ORG 4000H
RUT_CLK:    PUSH AX
            PUSH BX

            CMP CL,1
            JZ RESET
            DEC SEG+1
            CMP SEG+1, 2FH
            JNZ IMPRIMIR
            MOV SEG+1, 39H
            DEC SEG
            CMP SEG, 2FH
            JNZ IMPRIMIR

RESET:      MOV SEG+1, 3AH
            MOV SEG, 32H
            MOV CL, 0
            MOV BX, OFFSET AVISO
            MOV AL, OFFSET FIN2 - OFFSET AVISO

IMPRIMIR:   INT 7

FINAL:      MOV AL, 0
            OUT TIMER, AL
            MOV AL, EOI
            OUT PIC, AL
            POP BX
            POP AX
            IRET

            ORG 1000H
SEG         DB 32H
            DB 3AH
            DB "  "
FIN1        DB ?
AVISO       DB 0AH,"Posesion perdida",0AH
FIN2        DB ?

            ORG 2000H
            CLI
            MOV AL, 0FCH 
            OUT PIC+1, AL
            MOV AL, N_F10
            OUT PIC+4, AL
            MOV AL, N_CLK
            OUT PIC+5, AL
            MOV AL, 1
            OUT TIMER+1, AL
            MOV AL, 0
            OUT TIMER, AL
            MOV CL,0
            MOV BX, OFFSET SEG
            MOV AL, OFFSET FIN1 - OFFSET SEG
            STI
LAZO:       JMP LAZO

END
