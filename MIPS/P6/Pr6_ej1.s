.data
CONTROL:            .word32 0x10000
DATA:               .word32 0x10008
cadena:             .asciiz "............"

.text
                    lwu $s0, CONTROL($s0)
                    lwu $s1, DATA($0)

                    daddi $t0, $0, 9    #codigo leer caracter
                    daddi $t1, $0, 0    #indice para guardar cadena
                    daddi $t2, $0, 12   #cantidad caracteres

loop:               sd $t0, 0($s0)
                    lbu $t3, 0($s1)
                    sb $t3, cadena($t1)
                    daddi $t1, $t1, 1
                    daddi $t2, $t2, -1
                    bnez $t2, loop

                    daddi $t0, $0, 4
                    daddi $t1, $0, cadena
                    sd $t1, 0($s1)
                    sd $t0, 0($s0)
                    halt