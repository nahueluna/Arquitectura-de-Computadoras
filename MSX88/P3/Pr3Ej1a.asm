CB      EQU 33H
PB      EQU 31H

        ORG 2000H
        ;configuracion CB
        MOV AL, 00H ;0 es salida
        OUT CB, AL
        ;configuracion PB
        MOV AL, 0C3H; 1100 0011
        OUT PB, AL
        INT 0
END        