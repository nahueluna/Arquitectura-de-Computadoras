.data
cant:       .word 8
datos:      .word 1, 2, 3, 4, 5, 6, 7, 8
res:        .word 0

.text
            dadd r1, r0, r0
            ld r2, cant(r0)
loop:       ld r3, datos(r1)
            daddi r2, r2, -1
            dsll r3, r3, 1
            sd r3, res(r1)
            daddi r1, r1, 8
            bnez r2, loop
            nop
halt

;¿Qué efecto tiene habilitar la opción Delay Slot (salto retardado)?. 
La técnica Delay Slot permite solucionar (en algunos casos) los Branch Taken Stall ejecutando siempre la instrucción siguiente al salto (ya sea
;que salte o no). Esto cambia la forma de programar, pues implica que se debe incluir luego del salto una instrucción que deba ser ejecutada
;siempre, sin importar si se efectúa o no el salto. A veces no es posible utilizarla.

;¿Con qué fin se incluye la instrucción NOP? ¿Qué sucedería si no estuviera?.
;La instrucción NOP se incluye luego del salto para que el Delay Slot ejecute esta (la cual no tiene efecto en el programa) siempre, salte o no.
;Si no estuviera, el Delay Slot ejecutaría el halt y terminaría el programa, aún cuando deba saltar.

;Tomar nota de la cantidad de ciclos, la cantidad de instrucciones y los CPI luego de ejecutar el programa. 
;Ciclos: 63 - Instrucciones: 59 - CPI: 1,068

