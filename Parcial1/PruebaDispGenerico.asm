PB            EQU 31H
CB            EQU 33H
PIC           EQU 20H
TIMER         EQU 10H
N_F10         EQU 10
N_TIMER       EQU 11

              ORG 40
IP_F10        DW RUT_F10

              ORG 44
IP_TIMER      DW RUT_TIMER

              ORG 1000H
CADENA        DB "aBcDe"
FIN           DB ?

              ORG 3000H
RUT_F10:      PUSH AX

              MOV CL, 0

              MOV AL, 0FFH
              OUT PIC+1, AL
              MOV AL, 20H
              OUT PIC, AL
              POP AX
              RET

              ORG 3500H
RUT_TIMER:    PUSH AX

              MOV AL, [BX]
              OUT PB, AL
              INC BX
              DEC CL

              MOV AL, 0
              OUT TIMER, AL

              MOV AL, 20H
              OUT PIC, AL
              POP AX
              RET

              ORG 2000H
              CLI
              MOV AL, 0FCH
              OUT PIC+1, AL ;IMR
              MOV AL, N_F10
              OUT PIC+4, AL  ;INT0
              MOV AL, N_TIMER
              OUT PIC+5, AL  ;INT1

              MOV AL, 00H
              OUT CB, AL

              MOV AL, 5
              OUT TIMER+1, AL
              MOV AL, 0
              OUT TIMER, AL

              MOV BX, OFFSET CADENA
              MOV CL, OFFSET FIN - OFFSET CADENA
              STI

LOOP:         CMP CL, 0
              JNZ LOOP

              INT 0

END