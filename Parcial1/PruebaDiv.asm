            ORG 1000H
NUM1        DB 5
NUM2        DB 6
RESUL       DB ?
RESTO       DB ?

            ORG 3000H
DIV:        MOV DX, 0
            CMP AL, 0  ;divisor != 0
            JZ TERMINAR

            CMP AH, AL ;divisor > dividendo
            JS TERMINAR

LOOP:       SUB AH, AL
            INC DL
            CMP AH, AL
            JNS LOOP

TERMINAR:   MOV DH, AH
            RET

            ORG 2000H
            MOV AH, NUM1
            MOV AL, NUM2
            
            CALL DIV
            
            MOV RESUL, DL
            MOV RESTO, DH

            INT 0
END         