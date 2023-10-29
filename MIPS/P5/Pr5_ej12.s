.data
valor:              .word 10
result:             .word 0

.text
                    daddi $sp, $0, 0x400

                    ld $a0, valor($0)
                    daddi $a1, $0, 1    #ya que será recursivo, le paso el 1 en el programa principal

                    jal factorial

                    sd $v0, result($0)
                    halt

                    #push de $ra y valor del num pasado
factorial:          daddi $sp, $sp, -16
                    sd $ra, 0($sp)
                    sd $a0, 8($sp)

                    #si es 1, llegué al caso base
                    beq $a0, $a1, ult_factor
                    daddi $a0, $a0, -1  #si no es 1, resto uno y paso como parámetro
                    jal factorial
                    #se ejecuta cuando comienza a volver de los llamados
                    ld $a0, 8($sp)  #recupero el valor de este llamado
                    dmul $v0, $a0, $v0  #multiplico con el valor acumulado en $v0
                    j fin

ult_factor:         ld $v0, 8($sp)  #guardo el 1 en $v0

fin:                ld $ra, 0($sp)  #recupero direccion retorno
                    daddi $sp, $sp, 16  #reestablezco sp a como estaba antes del llamado
                    jr $ra

# No es posible escribir la rutina factorial (que funcione para todos los casos) sin la pila.
# Esto se debe a que $a0 contiene el valor para hacer factorial y, por cada llamado recursivo,
# este factor debe pasarse decrementado. Esto implica modificar el registro $a0, pero no debo
# perder el valor original, pues al volver del llamado deberé utilizarlo para calcular.
# El uso de más registros para pasar los parámetros no es una opción, puesto que en una subrutina
# recursiva, el código debe ser genérico para cualquier valor del número, es decir, es un mismo
# registro el que se pasa como parámetro (no podría pasar un registro distinto en cada llamado,
# el codigo de la subrutina es el mismo, sin importar la etapa de recursión).
# No queda otra opción que guardar el valor de $a0 en cada etapa recursiva, para luego recuperarlo
# al volver y operar.