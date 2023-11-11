.data
CONTROL:            .word32 0x10000
DATA:               .word32 0x10008
msj:                .asciiz "Ingrese un numero:\n"

CERO:               .asciiz "CERO" 
UNO:                .asciiz "UNO"
DOS:                .asciiz "DOS"
TRES:               .asciiz "TRES"
CUATRO:             .asciiz "CUATRO"
CINCO:              .asciiz "CINCO"
SEIS:               .asciiz "SEIS"
SIETE:              .asciiz "SIETE"
OCHO:               .asciiz "OCHO"
NUEVE:              .asciiz "NUEVE"

.text
                    daddi $sp, $0, 0x400
                    lwu $s0, DATA($0)
                    lwu $s1, CONTROL($0)

                    dadd $a0, $0, $s0
                    dadd $a1, $0, $s1
                    jal ingreso

                    dadd $a0, $0, $v0
                    dadd $a1, $0, $s0
                    dadd $a2, $0, $s1
                    jal muestra

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

muestra:            dsll $t0, $a0, 3    #equivalente a multiplicar por 8
                    daddi $t1, $0, 4

                    daddi $t2, $t0, CERO    #calculo palabra a imprimir
                    sd $t2, 0($a1)
                    sd $t1, 0($a2)

                    jr $ra

