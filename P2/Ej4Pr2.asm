ORG 1000H
MSJ DB "INGRESE UN NUMERO:"
FIN DB ?

ORG 1500H
NUM DB ?

ORG 2000H
MOV BX, OFFSET MSJ
MOV AL, OFFSET FIN-OFFSET MSJ
INT 7
MOV BX, OFFSET NUM
INT 6
MOV AL, 1
INT 7
MOV CL, NUM
INT 0
END

;a) Para la interrupción INT 7, se almacena en BX la dirección de comienzo de la
;cadena de caracteres que se quiere imprimir y en AL la cantidad de caracteres que
;se imprimiran

;b) Para la interrupción INT 6, se almacena en BX la dirección donde se guardará
;el caracter ingresado (en hexadecimal segun el codigo ASCII)

;c) En el programa propuesto, la segunda interrupción INT 7 imprime el caracter
;que acaba de ser ingresado. En el registro CL queda el codigo ASCII del caracter
;ingresado (ya sea un símbolo, letra o número)
