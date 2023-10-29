.data
M:              .word 11
tabla:          .word 5, 13, 2, 15
long:           .word 4
res:            .word 0

.text
                ld $a0, M($0)
                daddi $a1, $0, tabla
                ld $a2, long($0)

                jal mayores

                sd $v0, res($0)

                halt

mayores:        daddi $v0, $0, 0
loop:           beqz $a2, fin
                ld $t0, 0($a1)  #$a1 tiene dirección de tabla
                slt $t1, $a0, $t0
                beqz $t1, no_cumple
                daddi $v0, $v0, 1
no_cumple:      daddi $a1, $a1, 8
                daddi $a2, $a2, -1
                j loop

fin:            jr $ra