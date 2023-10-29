.data
cadena:             .asciiz "mUrcieLAgO"
tabla:              .asciiz "AaEeIiOoUu"
res:                .word 0

.text
                    daddi $sp, $0, 0x400

                    daddi $a1, $0, cadena

                    jal contar_voc

                    sd $v1, res($0)
                    halt

# $a1 parámetro entrada: direccion cadena
# $v1 parámetro salida: cantidad vocales
contar_voc:         daddi $sp, $sp, -8
                    sd $ra, 0($sp)

                    daddi $v1, $0, 0
lazo:               lbu $a0, 0($a1)
                    beqz $a0, fin1
                    jal es_vocal
                    beqz $v0, seguir
                    daddi $v1, $v1, 1
seguir:             daddi $a1, $a1, 1
                    j lazo

fin1:               ld $ra, 0($sp)
                    daddi $sp, $sp, 8

                    jr $ra

# $a0 parámetro entrada: vocal
# $v0 parámetro salida: indica vocal (1) o no (0)
es_vocal:           daddi $v0, $0, 0
                    daddi $s0, $0, 0    # no quiero perder posicion
loop:               lbu $t0, tabla($s0)
                    beqz $t0, fin2
                    beq $a0, $t0, vocal
                    daddi $s0, $s0, 1
                    j loop

vocal:              daddi $v0, $0, 1
fin2:               jr $ra