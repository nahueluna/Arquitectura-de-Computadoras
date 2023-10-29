PIO          EQU 30H
PIC          EQU 20H
N_F10        EQU 10

             ORG 40
IP_F10       DW RUT_F10

             ORG 1000H
MSJ          DB "LUCES ACTUALIZADAS",0AH
FIN          DB ?

             ORG 3000H
CONFIG_PIO:  PUSH AX

             MOV AL, 0FFH
             OUT PIO+2, AL  ;CA

             MOV AL, 00H
             OUT PIO+3, AL  ;CB

             OUT PIO+1, AL  ;apago todas las luces

             POP AX
             RET

             ORG 3500H
RUT_F10:     INT 7
             PUSH AX

             IN AL, PIO
             OUT PIO+1, AL

             MOV AL, 20H
             OUT PIC, AL
             POP AX
             IRET


             ORG 2000H
             CLI
             MOV AL, 0FEH
             OUT PIC+1, AL
             MOV AL, N_F10
             OUT PIC+4, AL

             CALL CONFIG_PIO

             MOV BX, OFFSET MSJ
             MOV AL, OFFSET FIN - OFFSET MSJ
             STI

LOOP:        JMP LOOP

END