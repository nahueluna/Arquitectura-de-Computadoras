.data
n1:         .double 9.13
n2:         .double 6.58
res1:       .double 0.0
res2:       .double 0.0

.code
            l.d f1, n1(r0)
            l.d f2, n2(r0)
            nop #agregada por inciso e)
            add.d f3, f2, f1
            mul.d f1, f2, f1    #agregada por inciso d)
            mul.d f4, f2, f1
            s.d f3, res1(r0)
            s.d f4, res2(r0)
            halt 

#a) Ciclos: 16 - Instrucciones: 7 - CPI: 2,286

#b) Hay 4 atascos RAW:
#   - La instrucción add.d f3, f2, f1 requiere leer f2 al momento de ejecución, pero este aún no fue escrito
# por l.d f2, n2(r0)
#   - La instrucción s.d f3, res1(r0) tiene dos atascos RAW en momento de ejecución, ya que debe leer f3 pero este
# está siendo escrito por la instrucción add.d f3, f2, f1 (lo que produce RAW en dos ciclos hasta que se termina la suma)
#   - La instrucción s.d f4, res2(r0) tiene un atasco RAW pues debe leer f4, pero este está siendo escrito por mul.d f4, f2, f1

#c) Los atascos estructurales se producen cuando dos instrucciones quieren acceder a la misma etapa del cauce a la vez. Esto
# sucede únicamente cuando se involucran operaciones con múltiples etapas (para punto flotante) ya que, debido a su duración
# variable entre ellas, puede que dos instrucciones terminen la etapa de ejecución (en distintas ALU) al mismo tiempo y quieran
# pasar a MEM. Ocurre en la etapa EX del pipeline, generados por las instrucciones s.d f3, res1(r0) y s.d f4, res2(r0), debido a
# las instrucciones add.d f3, f2, f1 y mul.d f4, f2, f1 respectivamente. Se deja pasar a la siguiente etapa a la instrucción más antigüa

#d) El atasco WAR implica que un operando puede ser potencialmente escrito antes de que una instrucción anterior lo lea. En este caso,
# mul.d f1, f2, f1 escribirá sobre f1, pero la instrucción anterior, add.d f3, f2, f1, lo lee. Aunque para este caso no sucederá una escritura
# antes de la lectura, el programa atasca la instrucción al menos un ciclo por precaución de esto. Se produce ya que ambas son operaciones
# de ejecución que abarcan múltiples ciclos.

#e) El NOP retrasa un ciclo el comienzo de la instrucción add.d f3, f2, f1, lo que permitr que la instrucción l.d f2, n2(r0) termine de
# escribir f2 y, por lo tanto, no haya un atasco RAW. Esto permite que el add.d se ejecute con normalidad y, por lo tanto, el compilador
# no prevenga de un posible WAR con la instrucción siguiente (mul.d f1, f2, f1).