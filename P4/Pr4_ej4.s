.data
tabla:      .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num:        .word 7
long:       .word 10

.text
            ld r1, long(r0)
            ld r2, num(r0)
            dadd r3, r0, r0
            dadd r10, r0, r0
loop:       ld r4, tabla(r3)
            beq r4, r2, listo
            daddi r1, r1, -1
            daddi r3, r3, 8
            bnez r1, loop
            j fin
listo:      daddi r10, r0, 1

fin:        halt

;Tabla tiene una sucesión de numeros. Num tiene el numero a buscar, long es la longitud de la tabla.
;El programa carga en r1 long, en r2 num, usa r3 como índice para recorrer la tabla y r10 como indicador si el numero se encontró (1) o no (0).
;Carga en r4 el valor de la tabla sobre el que está. Si es iguala num, salta, pone 1 en r10 y finaliza. Sino, resta 1 a la longitud, pasa a la
;siguiente posicion de la tabla, verifica que no se haya terminado la misma (a través de la longitud). Si terminó finaliza el programa, sino
;carga el siguiente elemento de la tabla y comienza nuevamente el bucle.

;El Branch Target Buffer es un método para evitar los Branch Taken Stall, que consiste en una tabla (buffer) que almacena la acción tomada por
;cada salto condicional la última vez que se ejecutó, y la utiliza como predicción para la próxima vez que aparezca.
;Primero, llega a una instrucción de salto que no se ejecutó anteriormente y capta la instrucción siguiente. Si no salta, continúa normal.
;Si salta, toma un ciclo para añadir una entrada a la tabla, en la cual almacena la dirección del salto, el flag de salto (1 si salta, 0 si no)
;y la dirección de la instrucción de salto (es decir, individualiza cada salto por la línea del programa donde se encuentra).
;Esto le permite que, en la próxima ejecución del bucle, capte la instrucción donde se saltó (para eso guarda la dirección) utilizando el 
;historial de salto de dicha instrucción, evitando captar una erróneamente. De igual forma, al final del bucle habrá otro Branch Taken Stall,
;pues allí no deberá saltar.
;La técnica de BTB en un bucle produce un total de 4 Branch Stall (dos Branch Taken y dos Branch Misprediction). Uno la primera vez que
;falla y otro al añadir el salto al buffer. Otro cuando debe salir y el último al actualizar la tabla para este salto fallido.
;En este caso no hay Branch Misprediction porque el bucle posee dos saltos condicionales para los cuales nunca se salta exceptuando una ocasión

;Confeccionar una tabla que compare número de ciclos, CPI, RAWs y Branch Taken Stalls para los dos casos anteriores. 
;          | Sin BTB       | Con BTB
; Ciclos   | 71            | 67
; CPI      | 1,651         | 1,558
; RAWs     | 16            | 16
; BTS      | 8             | 4