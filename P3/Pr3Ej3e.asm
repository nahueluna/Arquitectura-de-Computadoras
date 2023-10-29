PIC        EQU 20H
HAND       EQU 40H
N_HAND     EQU 10

           ORG 40
IP_HAND    DW RUT_HAND

           ORG 1000H
MSJ        DB "UNIVERSIDAD NACIONAL DE LA PLATA"
FIN        DB ?

           ORG 3000H
CONF_HAND: PUSH AX

           IN AL, HAND+1
           OR AL, 80H  ;activo las interrupciones 1000 0000
           OUT HAND+1, AL

           POP AX
           RET

           ORG 3500H
RUT_HAND:  PUSH AX

           MOV AL, [BX]
           OUT HAND, AL
           INC BX
           DEC CL

           CMP CL, 0
           JNZ VOLVER
           MOV AL, 0FFH
           OUT PIC+1, AL

VOLVER:    MOV AL, 20H ;EOI
           OUT PIC, AL
           POP AX
           IRET

           ORG 2000H
           MOV BX, OFFSET MSJ
           MOV CL, OFFSET FIN - OFFSET MSJ
           CLI
           MOV AL, 0FBH
           OUT PIC+1, AL  ;IMR 1111 1011
           MOV AL, N_HAND
           OUT PIC+6, AL  ;INT2

           CALL CONF_HAND
           STI

LOOP:      CMP CL, 0
           JNZ LOOP

           INT 0
END