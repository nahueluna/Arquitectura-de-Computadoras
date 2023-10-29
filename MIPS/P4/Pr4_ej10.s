#Escribir un programa que cuente la cantidad de veces que un determinado caracter aparece en una cadena de texto. Observar
#cómo se almacenan en memoria los códigos ASCII de los caracteres (código de la letra “a” es 61H). Utilizar la instrucción lbu
#(load byte unsigned) para cargar códigos en registros. La inicialización de los datos es la siguiente:
#.data
#cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
#car: .asciiz "d" ; caracter buscado
#cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena

.data
cadena:             .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
car:                .asciiz "d" ; caracter buscado
cant:               .word 0 ; cantidad de veces que se repite el caractercar en cadena

.text
                    daddi r4, r0, 0 #indice
                    ld r2, car(r0)  #caracter buscado
                    ld r3, cant(r0) #cantidad de veces hallado
                    

loop:               lbu r1, cadena(r4)   #copia en r1 el ascii del caracter sin extensión de signo (1 byte)
                    bne r1, r2, distinto
                    daddi r3, r3, 1

distinto:           daddi r4, r4, 1
                    bnez r1, loop

                    sd r3, cant(r0)

                    halt
