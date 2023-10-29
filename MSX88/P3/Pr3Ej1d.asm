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

          INC CL
          MOV AL, CL
          OUT PB, AL

          MOV AL, 0
          OUT TIMER, AL
          MOV AL, EOI
          OUT PIC, AL
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

LOOP:     CMP CL, 0FFH
          JNZ LOOP

          INT 0
END        