.data
CONTROL:                .word32 0x10000
DATA:                   .word32 0x10008
msj:                    .asciiz "Ingrese una clave:\n"
bienvenido:             .asciiz "Bienvenido"
error:                  .asciiz "ERROR\n"
clave:                  .asciiz "abcd"
psw:                    .asciiz "...."

.text
                        lwu $s0, DATA($0)
                        lwu $s1, CONTROL($0)

ingresar:               daddi $s2, $0, 4    #cant para iterar y codigo imprimir cadena
                        daddi $s3, $0, 0    #indice para guardar clave
                        daddi $t1, $0, msj
                        sd $t1, 0($s0)
                        sd $s2, 0($s1)
                        #Pasaje argumentos, dir DATA y CONTROL
                        dadd $a0, $0, $s0
                        dadd $a1, $0, $s1

loop:                   jal char
                        sb $v0, psw($s3)
                        daddi $s3, $s3, 1
                        daddi $s2, $s2, -1
                        bnez $s2, loop

                        daddi $a0, $0, psw
                        dadd $a1, $0, $s0
                        dadd $a2, $0, $s1
                        jal respuesta
                        bnez $v0, ingresar  #salta si las claves no eran iguales

                        halt

char:                   daddi $t0, $0, 9
                        sd $t0, 0($a1)
                        lbu $v0, 0($a0)

                        jr $ra

respuesta:              ld $t0, 0($a0)
                        ld $t1, clave($0)

                        daddi $t2, $0, 4
                        bne $t0, $t1, incorrecto

                        daddi $t3, $0, bienvenido
                        daddi $v0, $0, 0
                        j impresion

incorrecto:             daddi $t3, $0, error
                        daddi $v0, $0, 1

impresion:              sd $t3, 0($a1)
                        sd $t2, 0($a2)

                        jr $ra