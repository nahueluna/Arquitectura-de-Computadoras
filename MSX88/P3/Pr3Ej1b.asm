CB        EQU 33H
PB        EQU 31H

          ORG 1000H
MSJ1      DB "LLAVE PRENDIDA"
FIN1      DB ?
MSJ2      DB "LLAVE APAGADA"
FIN2      DB ?

          ORG 2000H
          ;configuracion CB
          MOV AL, 00H ;0 es salida
          OUT CB, AL
          ;configuracion PB
          MOV AL, 0C3H; 1100 0011
          OUT PB, AL
  
          IN AL, PB
          AND AL, 80H  ;80H solo deja bit mas significativo (7)
          CMP AL, 80H
          JNZ APAGADO
          MOV BX, OFFSET MSJ1
          MOV AL, OFFSET FIN1 - OFFSET MSJ1
          JMP IMPRIMIR

APAGADO:  MOV BX, OFFSET MSJ2
          MOV AL, OFFSET FIN2 - OFFSET MSJ2

IMPRIMIR: INT 7

          INT 0
END        