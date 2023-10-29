TIMER     EQU 10H
PIC       EQU 20H
EOI       EQU 20H
CB        EQU 33H
PB        EQU 31H
N_CLK     EQU 10

          ORG 40
IP_CLK    DW RUT_CLK

          ORG 3000H
RUT_CLK:  PUSH AX
          PUSH DX

          MOV AL, 1  ;AL inicializado en 1 (prende bit 0)
          MOV DL, CL  ;contador en DL para no perderlo
          
          ;mientras contador no sea 0, roto el bit de AL 
          ;tantas veces como para obtener un 1 en el bit N 
          ;(siendo N el valor del contador CL (0-7))
ROTAR:    CMP DL, 0
          JZ PRENDER
          ADD AL, AL
          DEC DL
          JMP ROTAR

PRENDER:  OUT PB, AL  ;prendo la luz correspondiente

          INC CL  ;incremento contador
          CMP CL, 8  ;si sobrepasé 7 (cantidad de luces) vuelvo a 0
          JNZ FIN_SUBR
          MOV CL, 0

FIN_SUBR: MOV AL, 0
          OUT TIMER, AL
          MOV AL, EOI
          OUT PIC, AL
          
          POP DX
          POP AX
          IRET

          ORG 2000H
          CLI
          ;configuracion CB
          MOV AL, 00H ;0 es salida
          OUT CB, AL
          ;configuracion PB inicial
          MOV AL, 00H
          OUT PB, AL  ;empiezan luces apagadas
          ;configuracion PIC
          MOV AL, 0FDH
          OUT PIC+1, AL  ;IMR
          MOV AL, N_CLK 
          OUT PIC+5, AL  ;INT1
          ;configuracion Timer
          MOV AL, 1
          OUT TIMER+1, AL
          MOV AL, 0
          OUT TIMER, AL
          MOV CL, 0
          STI

LOOP:     JMP LOOP

END        