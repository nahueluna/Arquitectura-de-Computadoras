;Escribir un programa que lea tres números enteros A, B y C de la memoria de datos y determine cuántos de ellos son iguales
;entre sí (0, 2 o 3). El resultado debe quedar almacenado en la dirección de memoria D. 

.data
A:      .word 5
B:      .word 5
C:      .word 5
D:      .word 0

.text
        ld r1, A(r0)
        ld r2, B(r0)
        ld r3, C(r0)
        daddi r4, r0, 0

        #A!=B
        bne r1, r2, distinto1
        daddi r4, r4, 1

        #A!=C
        distinto1:
        bne r1, r3, distinto2
        daddi r4, r4, 1

        #B!=C
        distinto2:
        bne r2, r3, distinto3
        daddi r4, r4, 1
        
        distinto3:
        #Evaluo si hubieron dos iguales (debo almacenar el 2 en ese caso)
        daddi r5, r0, 1
        bne r4, r5, no_dos_iguales
        daddi r4, r4, 1

        no_dos_iguales:
        sd r4, D(r0)

        halt

