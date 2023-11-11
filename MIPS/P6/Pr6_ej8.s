.data
CONTROL:                .word32 0x10000
DATA:                   .word32 0x10008

pelota1:                .word32 0x00FF0000 ; Azul
                        .byte 23           ; Coordenada X
                        .byte 1            ; Coordenada Y
                        .word 1            ; Desplazamiento X
                        .word 1            ; Desplazamiento Y

pelota2:                .word32 0x000000FF ; Rojo
                        .byte 37           ; Coordenada X
                        .byte 5            ; Coordenada Y
                        .word -1           ; Desplazamiento X
                        .word 1            ; Desplazamiento Y

pelota3:                .word32 0x0000FF00 ; Verde
                        .byte 15           ; Coordenada X
                        .byte 15           ; Coordenada Y
                        .word -1           ; Desplazamiento X
                        .word -1           ; Desplazamiento Y

pelota4:                .word32 0x00000000 ; Negro
                        .byte 21           ; Coordenada X
                        .byte 9            ; Coordenada Y
                        .word 1            ; Desplazamiento X
                        .word -1           ; Desplazamiento Y

pelota5:                .word32 0x00D30094 ; Violeta
                        .byte 19           ; Coordenada X
                        .byte 19           ; Coordenada Y
                        .word 1            ; Desplazamiento X
                        .word 1            ; Desplazamiento Y

color_fondo:            .word32 0x00FFFFFF ; Blanco

.text
                        daddi $sp, $zero, 0x400

                        lwu $a0, CONTROL($zero)
                        lwu $a1, DATA($zero)

loop:                   daddi $a2, $zero, pelota1
                        jal mostrar

                        daddi $a2, $zero, pelota2
                        jal mostrar
                        
                        daddi $a2, $zero, pelota3
                        jal mostrar

                        daddi $a2, $zero, pelota4
                        jal mostrar

                        daddi $a2, $zero, pelota5
                        jal mostrar

                        daddi $t0, $zero, 500 ; Hace una demora para que el rebote no sea tan rápido.
demora:                 daddi $t0, $t0, -1 ; Esto genera una infinidad de RAW y BTS pero...
                        bnez $t0, demora ; ¡hay que hacer tiempo igualmente!

                        j loop 



mostrar:                daddi $sp, $sp, -56
                        sd $s0, 48($sp)
                        sd $s1, 40($sp)
                        sd $s2, 32($sp)
                        sd $s3, 24($sp)
                        sd $s4, 16($sp)
                        sd $s5, 8($sp)
                        sd $s6, 0($sp)

                        lwu $s0, 0($a2) # RGBA
                        lbu $s1, 8($a2) # Coordenada X
                        lbu $s2, 16($a2) # Coordenada Y
                        ld $s3, 24($a2) # Desplazamiento X
                        ld $s4, 32($a2) # Desplazamiento Y
                        lwu $s5, color_fondo($zero)
                        daddi $s6, $zero, 5 # Comando para imprimir

                        sw $s5, 0($a1) ; Borra la pelota
                        sb $s1, 4($a1)
                        sb $s2, 5($a1)
                        sd $s6, 0($a0)

                        dadd $s1, $s1, $s3 ; Mueve la pelota en la dirección actual
                        dadd $s2, $s2, $s4
                        daddi $t1, $zero, 48 ; Comprueba que la pelota no esté en la columna de más
                        slt $t0, $t1, $s1 ; a la derecha. Si es así, cambia la dirección en X.
                        dsll $t0, $t0, 1
                        dsub $s3, $s3, $t0
                        
                        slt $t0, $t1, $s2 ; Comprueba que la pelota no esté en la fila de más arriba.
                        dsll $t0, $t0, 1 ; Si es así, cambia la dirección en Y.
                        dsub $s4, $s4, $t0
                        
                        slti $t0, $s1, 1 ; Comprueba que la pelota no esté en la columna de más
                        dsll $t0, $t0, 1 ; a la izquierda. Si es así, cambia la dirección en X.
                        dadd $s3, $s3, $t0
                        
                        slti $t0, $s2, 1 ; Comprueba que la pelota no esté en la fila de más abajo.
                        dsll $t0, $t0, 1 ; Si es así, cambia la dirección en Y.
                        dadd $s4, $s4, $t0
                        
                        sw $s0, 0($a1) ; Dibuja la pelota.
                        sb $s1, 4($a1)
                        sb $s2, 5($a1) 
                        sd $s6, 0($a0)
                        
                        sb $s1, 8($a2) # Coordenada X
                        sb $s2, 16($a2) # Coordenada Y
                        sd $s3, 24($a2) # Desplazamiento X
                        sd $s4, 32($a2) # Desplazamiento Y

                        ld $s0, 48($sp)
                        ld $s1, 40($sp)
                        ld $s2, 32($sp)
                        ld $s3, 24($sp)
                        ld $s4, 16($sp)
                        ld $s5, 8($sp)
                        ld $s6, 0($sp)
                        daddi $sp, $sp, 56

                        jr $ra