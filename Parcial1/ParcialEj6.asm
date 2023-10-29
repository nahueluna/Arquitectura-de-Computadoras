;Escriba un programa que dada una cadena de caracteres almacenada en la memoria,
;imprima a través de la impresora solamente sus caracteres mayúscula, en el orden en
;que aparecen. Para ello, deberá implementar y utilizar una subrutina SELECCIONADO
;que reciba un caracter como parametro y devuelva verdadero(1) si el caracter era 
;mayuscula y falso(0) de lo contrario. El programa debe esperar a que se hayan
;enviado todos los caracteres a imprimir para finalizar.
;HANDSHAKE Y POLLING

HAND          EQU 40H  ; REGISTRO DATO

              ORG 1000H
CADENA        DB "7)Elzxkf hY6HW)3213!SF%!J"
FIN           DB ?

              ;recibe BX parametro de entrada por referencia por registro
              ;devuelve AL parametro de salida por valor por registro
              ORG 3000H
SELECCIONADO: CMP BYTE PTR [BX], 41H  ;ASCII "A"
              JS TERMINAR
              CMP BYTE PTR [BX], 5BH  ;ASCII siguiente de "Z"
              JNS TERMINAR
              MOV AL, 1
              JMP FINAL

TERMINAR:     MOV AL, 0
FINAL:        RET

              ORG 3500H
POLL:         IN AL, HAND+1  ;REGISTRO ESTADO
              AND AL, 1
              JNZ POLL

              RET
              

              ORG 2000H
              MOV BX, OFFSET CADENA
              MOV CL, OFFSET FIN - OFFSET CADENA
              
EVALUAR:      CALL SELECCIONADO
              CMP AL, 1
              JNZ NO_MAYUS

              CALL POLL
              MOV AL, [BX]
              OUT HAND, AL

NO_MAYUS:     INC BX
              DEC CL
              JNZ EVALUAR

              INT 0
END              