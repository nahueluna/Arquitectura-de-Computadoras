.data
tabla:          .word 5, 8, 13, 15, 22, 0
res:            .word 0

.text
                daddi $sp, $0, 0x400
                
                daddi $a0, $0, tabla
                
                jal cont_impar

                sd $v0, res($0)
                halt

cont_impar:     daddi $sp, $sp, -8
                sd $ra, 0($sp)

                daddi $v0, $0, 0    #preparo parametro salida de sub1
loop:           ld $a1, 0($a0)
                beqz $a1, fin
                jal es_impar
                beqz $v1, seguir
                daddi $v0, $v0, 1

seguir:         daddi $a0, $a0, 8
                j loop

fin:            ld $ra, 0($sp)
                daddi $sp, $sp, 8

                jr $ra

es_impar:       daddi $v1, $0, 0    #preparo parametro salida de sub2
                andi $t0, $a1, 1
                beqz $t0, no_impar
                daddi $v1, $0, 1

no_impar:       jr $ra        