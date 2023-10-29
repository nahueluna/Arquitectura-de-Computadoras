.data
A: .word 1
B: .word 2

.code

ld r1, A(r0)
ld r2, B(r0)
sd r2, A(r0)
sd r1, B(r0)

halt 

;Ejecutarlo en el simulador con la opción Configure/Enable Forwarding deshabilitada. Analizar paso a paso su
;funcionamiento, examinar las distintas ventanas que se muestran en el simulador y responder:
;- ¿Qué instrucción está generando atascos (stalls) en el cauce (ó pipeline) y por qué?
;- ¿Qué tipo de ‘stall’ es el que aparece?
;- ¿Cuál es el promedio de Ciclos Por Instrucción (CPI) en la ejecución de este programa bajo esta configuración?

;La instrucción que genera atascos es sd r2, A(r0). Esto se debe a que accede a r2 en la etapa ID, pues se guardará
;su valor en A. Sin embargo, el valor de r2 está siendo escrito por la instrucción anterior y estará disponible en la
;etapa WB de la misma.

;El tipo de stall que aparece es RAW (Read After Write) debido a que se intenta leer un operando que debe ser escrito
;por una instrucción anterior. El compilador introduce retardos para evitar leerlo antes de escribirlo.

;El promedio de ciclos por instrucción (CPI) actual es de 2,2.

;Una forma de solucionar los atascos por dependencia de datos es utilizando el Adelantamiento de Operandos o Forwarding.
;Ejecutar nuevamente el programa anterior con la opción Enable Forwarding habilitada y responder:
;- ¿Por qué no se presenta ningún atasco en este caso? Explicar la mejora.
;- ¿Qué indica el color de los registros en la ventana Register durante la ejecución?
;- ¿Cuál es el promedio de Ciclos Por Instrucción (CPI) en este caso? Comparar con el anterior.

;El forwarding provee un mecanismo para el adelantamiento de operandos. Implementado en hardware, añade
;buffers para poder obtener el dato en la etapa en la que es calculado, evitando esperar hasta WB. Además,
;las etapas que lo requieran podrán avanzar en el cauce hasta que efectivamente lo necesiten (antes lo 
;requerian obligatoriamente en ID). En EX y MEM es donde se implementan los buffers para el adelantamiento.

;El color del registro en ventana Register con forwarding activado indica la etapa de segmentación en la
;cual el valor está listo para ser adelantado. Ej: si r1 está en verde durante una instrucción ld, indica
;que en la estapa MEM ya se tiene el valor para hacer forwarding

;El CPI en este caso es de 1,8. Inferior al 2,2 sin forwarding.