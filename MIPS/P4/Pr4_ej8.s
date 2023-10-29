#Escribir un programa que multiplique dos números enteros utilizando sumas repetidas (similar a Ejercicio 6 o 7 de la Práctica
#1). El programa debe estar optimizado para su ejecución con la opción Delay Slot habilitada.

.data
A:          .word 5
B:          .word 3

.text
            ld r1, A(r0)    #r1 = 5
            ld r2, B(r0)    #r2 = 3
            daddi r3, r0, 0 #r3 = resultado
            
            beqz r1, fin
            beqz r2, fin 

mul:        daddi r2, r2, -1
            bnez r2, mul
            dadd r3, r3, r1

fin:        halt
            