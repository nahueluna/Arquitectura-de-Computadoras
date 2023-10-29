CA        EQU 32H
CB        EQU 33H
PA        EQU 30H
PB        EQU 31H


          ORG 2000H
          ;configuracion CA
          MOV AL, 0FFH; FF (1111 1111) es entrada
          OUT CA, AL
          ;configuracion CB
          MOV AL, 00H ;0 es salida
          OUT CB, AL
  
LOOP:     IN AL, PA
          OUT PB, AL
          JMP LOOP
          
END        