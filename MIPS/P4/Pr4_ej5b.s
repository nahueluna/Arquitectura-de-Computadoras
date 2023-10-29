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
            bnez r2, loop
            daddi r1, r1, 8
halt

;Ciclos: 55 - Instrucciones: 51 - CPI: 1,078 --> actual
;Ciclos: 63 - Instrucciones: 59 - CPI: 1,068 --> anterior

;El CPI se incrementó ligeramente, pero se redujeron en 8 la cantidad de ciclos e instrucciones. A menor cantidad de instrucciones, el CPI puede
;tender a aumentar, pero que hayan menos implica una ejecución más veloz en general (no por instrucción).