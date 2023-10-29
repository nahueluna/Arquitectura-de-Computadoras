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
            PUSH BX
           ;imprimo el mensaje. Leo e imprimo numeros ingresados
           ;imprimo salto de linea
            MOV BX, OFFSET MSJ
            MOV AL, OFFSET FIN2 - OFFSET MSJ
            INT 7
            MOV BX, OFFSET SEG
            INT 6
            INC BX
            INT 6
            MOV BX, OFFSET SEG
            MOV AL, OFFSET FIN1 - OFFSET SEG
            INT 7
            MOV BX, OFFSET LF
            MOV AL, 1
            INT 7
            ;desenmascaro el timer y enmascaro el F10 para que no se vuelva a presionar
            MOV AL,0FDH
            OUT PIC+1, AL
            MOV AL, 0
            OUT TIMER, AL
            MOV AL,EOI
            OUT PIC, AL
            POP BX
            POP AX
            IRET

            ORG 4000H
RUT_CLK:    PUSH AX
            PUSH BX
; Comprueba que el segundero no baje de 0 en ninguno de sus dos digitos
; si es la unidad, la setea en 9 y decrementa la decena. Si es la decena,
; termina la cuenta
            DEC SEG+1
            CMP SEG+1, 2FH
            JNZ IMPRIMIR
            MOV SEG+1, 39H
            DEC SEG
            CMP SEG, 2FH
            JNZ IMPRIMIR
; si no salté, enmascaro el timer y desenmascaro el F10
; imprimo un salto de linea para la proxima impresión del mensaje
            MOV AL, 0FEH
            OUT PIC+1, AL
            
            MOV BX, OFFSET LF
            MOV AL, 1
            INT 7
            
            JMP FINAL
; Imprime los segundos
IMPRIMIR:   MOV BX, OFFSET SEG
            MOV AL, OFFSET FIN1 - OFFSET SEG
            INT 7
; Reinicia el contador del timer
FINAL:      MOV AL, 0
            OUT TIMER, AL
            MOV AL, EOI
            OUT PIC, AL
            POP BX
            POP AX
            IRET

            ORG 1000H
SEG         DB ?
            DB ?
            DB "  "
FIN1        DB ?
MSJ         DB "Ingrese un numero: "
FIN2        DB ?
LF          DB 0AH

            ORG 2000H
            CLI
            MOV AL, 0FEH  ;enmascaro el timer porque no me interesa contar al principio
            OUT PIC+1, AL
            MOV AL, N_F10
            OUT PIC+4, AL
            MOV AL, N_CLK
            OUT PIC+5, AL
            MOV AL, 1
            OUT TIMER+1, AL
            MOV AL, 0
            OUT TIMER, AL
            STI
LAZO:       JMP LAZO

END
            