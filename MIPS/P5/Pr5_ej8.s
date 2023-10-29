.data
cad1:           .asciiz "tormenta"
cad2:           .asciiz "tormento"
res:            .word 0

.text
                daddi $a0, $0, cad1
                daddi $a1, $0, cad2

                jal cmp_cadena

                sd $v0, res($0)
                halt

cmp_cadena:     daddi $v0, $0, -1
loop:           lbu $t0, 0($a0)  #cadena 1
                lbu $t1, 0($a1)  #cadena 2
                beqz $t0, evaluar

                bne $t0, $t1, distintas
                daddi $a0, $a0, 1
                daddi $a1, $a1, 1
                j loop

evaluar:        beqz $t1, fin             

distintas:      dadd $v0, $0, $a0
fin:            jr $ra  