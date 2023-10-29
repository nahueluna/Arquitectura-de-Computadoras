TIMER       EQU 10H
PIC         EQU 20H
EOI         EQU 20H
N_CLK       EQU 10

            ORG 40
IP_CLK      DW RUT_CLK

            ORG 1000H
SEG         DB 35H
            DB 39H
            DB ":"
            DB 30H
            DB 30H
LF          DB 0AH
FIN         DB ?

            ORG 3000H
RUT_CLK:    PUSH AX

            INC SEG+3  ;decena de segundo
            CMP SEG+3, 36H  ;si no llego a 6 salto
            JNZ RESET
            MOV SEG+3, 30H  ;devuelvo decena de segundo a 0
            
            INC SEG+1  ;incremento unidad de minuto
            CMP SEG+1, 3AH  ;si no llego a 10 salto 
            JNZ RESET
            MOV SEG+1, 30H  ;devuelvo unidad de minuto a 0
            INC SEG  ;incremento decena de minuto
            CMP SEG, 36H  ;si no llego a 6 salto
            JNZ RESET
            MOV SEG, 30H  ;devuelvo decena de minuto a 0, por lo que llegue a 59:59
            
RESET:      INT 7
            MOV AL, 0
            OUT TIMER, AL
            MOV AL, EOI
            OUT PIC, AL
            POP AX
            IRET
            
            ORG 2000H
            CLI
            MOV AL, 0FDH
            OUT PIC+1, AL ; PIC: registro IMR
            MOV AL, N_CLK
            OUT PIC+5, AL ; PIC: registro INT1
            MOV AL, 10
            OUT TIMER+1, AL ; TIMER: registro COMP
            MOV AL, 0
            OUT TIMER, AL ; TIMER: registro CONT
            MOV BX, OFFSET SEG
            MOV AL, OFFSET FIN-OFFSET SEG
            STI
LAZO:       JMP LAZO

END