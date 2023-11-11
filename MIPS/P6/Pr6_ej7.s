.data
CONTROL:                .word32 0x10000
DATA:                   .word32 0x10008

cero:                   .byte 0x3F
                        .byte 0x06
                        .byte 0x5B
                        .byte 0x4F
                        .byte 0x66
                        .byte 0x6D
                        .byte 0x7D
                        .byte 0x07
                        .byte 0x7F
                        .byte 0x6F

.text
                        lwu $s0, CONTROL($zero)
                        lwu $s1, DATA($zero)

inicio:                 daddi $t0, $zero, 9 #Codigo leer entero

                        sw $t0, 0($s0)  #Cargo codigo en CONTROL
                        lbu $s2, 0($s1) #Traigo valor leido

                        daddi $s2, $s2, -48 #Convierto de ASCII a valor numerico
                        daddi $s4, $zero, 0x1 #Mascara para identificar segmentos
                        
                        dsll $s2, $s2, 3    #Equivale a multiplicar por 8

                        lbu $s3, cero($s2)  #Segmentos del numero leido (expresados en bits)

                        and $t1, $s3, $s4   #Aplico mascara 1h al numero leido (corrobora segmento "a")
                        beqz $t1, segmento_b

                        daddi $a0, $zero, 2 #Coordenada X
                        daddi $a1, $zero, 8 #Coordenada Y
                        jal dibujar_horizontal

segmento_b:             dsll $s4, $s4, 1
                        and $t1, $s3, $s4
                        beqz $t1, segmento_c

                        daddi $a0, $zero, 5
                        daddi $a1, $zero, 5
                        jal dibujar_vertical

segmento_c:             dsll $s4, $s4, 1
                        and $t1, $s3, $s4
                        beqz $t1, segmento_d

                        daddi $a0, $zero, 5
                        daddi $a1, $zero, 2
                        jal dibujar_vertical

segmento_d:             dsll $s4, $s4, 1
                        and $t1, $s3, $s4
                        beqz $t1, segmento_e

                        daddi $a0, $zero, 2
                        daddi $a1, $zero, 1
                        jal dibujar_horizontal

segmento_e:             dsll $s4, $s4, 1
                        and $t1, $s3, $s4
                        beqz $t1, segmento_f

                        daddi $a0, $zero, 1
                        daddi $a1, $zero, 2
                        jal dibujar_vertical

segmento_f:             dsll $s4, $s4, 1
                        and $t1, $s3, $s4
                        beqz $t1, segmento_g

                        daddi $a0, $zero, 1
                        daddi $a1, $zero, 5
                        jal dibujar_vertical

segmento_g:             dsll $s4, $s4, 1
                        and $t1, $s3, $s4
                        beqz $t1, fin

                        daddi $a0, $zero, 2
                        daddi $a1, $zero, 5
                        jal dibujar_horizontal

fin:                    daddi $t2, $zero, 9 #Espera tecla para continuar
                        sw $t2, 0($s0)

                        daddi $t2, $zero, 7 #Limpia pantalla grafica
                        sw $t2, 0($s0)

                        j inicio



dibujar_vertical:       daddi $t0, $zero, 0 #RGBA = negro
                        daddi $t1, $zero, 5 #Codigo dibujar pixel
                        daddi $t2, $zero, 3 #Largo segmento
                        

loop1:                  sw $t0, 0($s1)  #Cargo color
                        sb $a0, 5($s1)  #Cargo coordenada X
                        sb $a1, 4($s1)  #Cargo coordenada Y
                        sw $t1, 0($s0)
                        daddi $a1, $a1, 1
                        daddi $t2, $t2, -1
                        bnez $t2, loop1

                        jr $ra


dibujar_horizontal:     daddi $t0, $zero, 0
                        daddi $t1, $zero, 5
                        daddi $t2, $zero, 3

loop2:                  sw $t0, 0($s1)
                        sb $a0, 5($s1)
                        sb $a1, 4($s1)
                        sw $t1, 0($s0)
                        daddi $a0, $a0, 1
                        daddi $t2, $t2, -1
                        bnez $t2, loop2

                        jr $ra