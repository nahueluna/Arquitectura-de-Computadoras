#Escribir un programa que recorra una TABLA de diez números enteros y determine cuántos elementos son mayores que X.
#El resultado debe almacenarse en una dirección etiquetada CANT. El programa debe generar además otro arreglo llamado RES
#cuyos elementos sean ceros y unos. Un ‘1’ indicará que el entero correspondiente en el arreglo TABLA es mayor que X,
#mientras que un ‘0’ indicará que es menor o igual.

.data
tabla:          .word 2, 7, 5, 19, 8, 1, 0, 4, 15, 3
long:           .word 10
num:            .word 5
cant:           .word 0
res:            .space 10

.text
                ld r2, num(r0) #numero a comparar
                ld r6, long(r0) #longitud de tabla
                daddi r3, r0, 0 #registro para cant
                daddi r4, r0, 0 #registro índice

loop:           ld r1, tabla(r4) #registro para elementos de tabla
                slt r5, r2, r1  #r5 para evaluar menor. Setea 1 si r1 > r2 (tabla > num)
                beqz r5, menor
                daddi r3, r3, 1
                sd r5, res(r4)

menor:          daddi r4, r4, 8
                daddi r6, r6, -1
                bnez r6, loop

                sd r3, cant(r0) #guardo cantidad de numeros mayores

                halt