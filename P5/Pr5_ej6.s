.data
valor1:         .word 16
valor2:         .word 4
result:         .word 0

.text
                ld $a0, valor1($zero)
                ld $a1, valor2($zero)
                jal a_la_potencia
                sd $v0, result($zero)
                halt

a_la_potencia:  daddi $v0, $zero, 1
lazo:           slt $t1, $a1, $zero
                bnez $t1, terminar
                daddi $a1, $a1, -1
                dmul $v0, $v0, $a0
                j lazo
terminar:       jr $ra

#a) El programa realiza la operación matemática de potenciación. El valor 1 es la base y el
# valor 2 el exponente. Está estructurado para funcionar con una subrutina. Se guardan los
# parámetros de entrada en dos registros, con los que se opera en la subrutina y el resultado
# es devuelto en otro registro.

#b) La instrucción jal guarda la dirección de retorno (instrucción siguiente) en $ra (r31) y
# salta a la etiqueta especificada. La instrucción jr salta a la dirección almacenada en un
# registro. Utilizamos $ra en este caso pues allí se guardó la dirección de retorno

#c) $ra almacena la dirección de retorno (instrucción siguiente al salto), producto de la
# ejecución de jal a_la_potencia. Los registros $a0 y $a1 son utilizados como argumentos
# para pasar los datos con los que la subrutina va a operar. El registro $v0 se utiliza
# como parámetro de salida para devolver un valor por parte de la subrutina.

#d) Si se quisiera invocar otra subrutina en "a_la_potencia" (anidamiento de subrutinas)
# se debería guardar la dirección de retorno (que está en $ra) dentro de la pila para,
# luego de volver a la subrutina principal, desapilarla y volver al programa. Apilandola
# evitamos perder la referencia de retorno al programa principal.