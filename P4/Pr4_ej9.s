#Escribir un programa que implemente el siguiente fragmento escrito en un lenguaje de alto nivel:
#while a > 0 do
#begin
#    x := x + y;
#    a := a - 1;
#end;
#Ejecutar con la opción Delay Slot habilitada. 

.data
a:          .word 3
x:          .word 0
y:          .word 2

.text
            ld r1, x(r0)
            ld r2, y(r0)
            ld r3, a(r0)
            daddi r4, r0, 0

while:      slt r5, r4, r3  #r3 = a, r4 = 0. r4 < r3 --> r3 > 0, r5 = 1
            beqz r5, fin
            daddi r3, r3, -1    #se modifica aunque no salte. No importa porque la modificación es en el registro, no en la variable en memoria
            dadd r1, r1, r2
            j while

fin:        sd r1, x(r0)
            
            halt