.data
coorX:          .byte 0 ; coordenada X de un punto
coorY:          .byte 0 ; coordenada Y de un punto
color:          .byte 0, 0, 0, 0 ; color: máximo rojo + máximo azul => magenta
CONTROL:        .word32 0x10000
DATA:           .word32 0x10008
msj1:           .asciiz "Ingrese coordenadas:\n"
msj2:           .asciiz "Ingrese RGBA del pixel:\n"

.text
                lwu $s6, CONTROL($zero) ; $s6 = dirección de CONTROL
                lwu $s7, DATA($zero) ; $s7 = dirección de DATA
                
                daddi $t0, $zero, 7 ; $t0 = 7 -> función 7: limpiar pantalla gráfica
                sd $t0, 0($s6) ; CONTROL recibe 7 y limpia la pantalla gráfica
                
                dadd $a0, $0, $s7
                dadd $a1, $0, $s6
                jal coordenadas
                sb $v0, coorX($0)   #coordenada X
                sb $v1, coorY($0)   #coordenada Y

                dadd $a0, $0, $s7
                dadd $a1, $0, $s6
                jal color
                sw $v0, color($0)    #RGBA

                lbu $s0, coorX($zero)
                sb $s0, 5($s7) ; DATA+5 recibe el valor de coordenada X
                
                lbu $s1, coorY($zero)
                sb $s1, 4($s7) ; DATA+4 recibe el valor de coordenada Y
                
                lwu $s2, color($zero)
                sw $s2, 0($s7) ; DATA recibe el valor del color a pintar
                
                daddi $t0, $zero, 5 ; $t0 = 5 -> función 5: salida gráfica
                sd $t0, 0($s6) ; CONTROL recibe 5 y produce el dibujo del punto
                
                halt

coordenadas:    daddi $t0, $0, 4
                daddi $t1, $0, msj1
                sd $t1, 0($a0)
                sd $t0, 0($a1)
                daddi $t0, $0, 8
                
                sd $t0, 0($a1)
                lbu $v0, 0($a0)

                sd $t0, 0($a1)
                lbu $v1, 0($a0)

                jr $ra

color:          daddi $t0, $0, 4
                daddi $t1, $0, msj2
                sd $t1, 0($a0)
                sd $t0, 0($a1)
                daddi $v0, $0, 0    #guardo valores RGBA
                daddi $t0, $0, 8    #codigo para leer
                daddi $t2, $0, 0    #indice de desplazamiento
                daddi $t4, $0, 4    #contador para ingreso

loop:           sd $t0, 0($a1)
                lbu $t3, 0($a0)
                dsllv $t3, $t3, $t2 #desplazo bits porque el primer ingresado corresponde a R (pos 0), el segundo es G y debe ir 1B a la izquierda
                dadd $v0, $v0, $t3
                daddi $t2, $t2, 8
                daddi $t4, $t4, -1
                bnez $t4, loop

                jr $ra


