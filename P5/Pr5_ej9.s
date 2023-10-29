.data
caracter:           .ascii "U"
tabla:              .asciiz "AaEeIiOoUu"
res:                .word 0

.text
                    ld $a0, caracter($0)

                    jal es_vocal

                    sd $v0, res($0)
                    halt

es_vocal:           daddi $v0, $0, 0
                    daddi $s0, $0, 0    # no quiero perder posicion
loop:               lbu $t0, tabla($s0)
                    beqz $t0, fin
                    beq $a0, $t0, vocal
                    daddi $s0, $s0, 1
                    j loop

vocal:              daddi $v0, $0, 1
fin:                jr $ra