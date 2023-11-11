.data                    
DATA:               .word32 0x10008
CONTROL:            .word32 0x10000

msj:                .asciiz "Ingrese un numero:\n"

.text               
                    lwu $s0, DATA($0)
                    lwu $s1, CONTROL($0)

                    dadd $a0, $0, $s0
                    dadd $a1, $0, $s1
                    
                    jal ingreso
                    dadd $s2, $0, $v0

                    jal ingreso
                    dadd $s3, $0, $v0
                    
                    dadd $a0, $0, $s2
                    dadd $a1, $0, $s3
                    dadd $a2, $0, $s0
                    dadd $a3, $0, $s1
                    jal resultado
                    halt

ingreso:            daddi $t0, $0, msj  #direccion msj
                    daddi $t1, $0, 4    #numero para imprimir cadena
                    sd $t0, 0($a0)
                    sd $t1, 0($a1)

                    daddi $t1, $0, 8
lectura:            sd $t1, 0($a1)  #Envio codigo para leer entero
                    ld $t0, 0($a0)  #Traigo entero
                    slti $t2, $t0, 10
                    beqz $t2, lectura

                    slti $t2, $t0, 0
                    bnez $t2, lectura

                    dadd $v0, $0, $t0
                    jr $ra


resultado:          daddi $t0, $0, 1

                    dadd $t1, $a0, $a1

                    sd $t1, 0($a2)
                    sd $t0, 0($a3)

                    jr $ra