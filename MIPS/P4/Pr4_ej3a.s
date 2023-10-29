.data
        A: .word 1
        B: .word 3

.text
        ld r1, A(r0)
        ld r2, B(r0)
loop:   dsll r1, r1, 1
        daddi r2, r2, -1
        bnez r2, loop
halt

;a) Ejecutar el programa con Forwarding habilitado y responder:
;- ¿Por qué se presentan atascos tipo RAW?
;- Branch Taken es otro tipo de atasco que aparece. ¿Qué significa? ¿Por qué se produce?
;- ¿Cuántos CPI tiene la ejecución de este programa? Tomar nota del número de ciclos, cantidad de instrucciones y CPI.

;Se presentan atascos de tipo RAW porque la instrucción daddi r2, r2, -1 tiene listo el registro r2 en la etapa EX. Sin embargo, la instrucción
;de salto bnez requiere leer el registro r2 en ID (los saltos realizan la mayor parte de su tarea en dicha etapa). Es por ello que incluso con
;forwarding el operando no está listo a tiempo y hay un stall RAW.

;Un Branch Taken Stall se produce cuando el procesador capta la instrucción siguiente de un salto, pero dicho salto se efectúa y la instrucción 
;captada debe ser descartada. Por lo tanto, esto produce un atasco por la rama tomada erróneamente (conlleva tiempo descartar lo que había siendo
;previamente captado y comenzado a decodificar, para tomar la instrucción efectivamente correspondiente).

;Se tienen 21 ciclos con 12 instrucciones (teniendo en cuenta las veces que se repite el bucle). Un CPI de 1,75.

;b) Ejecutar ahora el programa deshabilitando el Forwarding y responder:
;- ¿Qué instrucciones generan los atascos tipo RAW y por qué? ¿En qué etapa del cauce se produce el atasco en cada caso y
;durante cuántos ciclos?
;- Los Branch Taken Stalls se siguen generando. ¿Qué cantidad de ciclos dura este atasco en cada vuelta del lazo ‘loop’?
;Comparar con la ejecución con Forwarding y explicar la diferencia.
;- ¿Cuántos CPI tiene la ejecución del programa en este caso? Comparar número de ciclos, cantidad de instrucciones y CPI
;con el caso con Forwarding.

;Los RAW Stalls son generados por las instrucciones dsll r1, r1, 1 y bnez r2, loop. La primera debido a que requiere el registro r1 en su etapa
;ID (no hay forwarding) pero este aún no fue escrito por la instrucción que lo carga (produce RAW 1 ciclo). Luego, la instrucción de salto produce
;RAW 2 ciclos un total de 3 veces, pues requiere r2 para evaluar la condición de salto, pero este está siendo escrito por la instrucción daddi
;anterior.

;Los Branch Taken Stalls duran en este caso 3 ciclos, un total de 2 veces. Esto se debe a que la instrucción es captada antes de conocer si se
;efectuará el salto. Sin embargo, debido a los RAW Stalls, el salto se demora y, por lo tanto, la propia instrucción permanece retardada hasta
;ser descartada cuando se decide el salto. Esto si se cuenta la demora producida por los RAW Stalls como demora de Branch Taken. En si, el atasco
;producido por descartar la instrucción (que entró en etapa de decodificación) es de 1 ciclo. Debido a que el retardo adicional es causado por el
;atasco RAW, con el forwarding este se reduce (pasando de 3 ciclos a 2).

;Se tienen 25 ciclos, 12 instrucciones y un CPI de 2,083, superior a los 1,75 anteriores (debido a estos ciclcos de atasco producidos).