.data
peso:           .double 55.5
altura:         .double 1.85
IMC:            .double 0
estado:         .word 0
tabla:          .double 18.5, 25.0, 30.0

.text
                l.d f1, peso(r0)
                l.d f2, altura(r0)

                mul.d f2, f2, f2    #altura^2
                div.d f1, f1, f2    #peso/altura

                daddi $t1, r0, 0

                l.d f3, tabla($t1)
                c.lt.d f1, f3
                bc1t infrapeso

                daddi $t1, $t1, 8
                l.d f3, tabla($t1)
                c.lt.d f1, f3
                bc1t normal

                daddi $t1, $t1, 8
                l.d f3, tabla($t1)
                c.lt.d f1, f3
                bc1t sobrepeso

                daddi $t0, r0, 4
                j fin

infrapeso:      daddi $t0, r0, 1
                j fin

normal:         daddi $t0, r0, 2
                j fin

sobrepeso:      daddi $t0, r0, 3
                j fin

fin:            s.d f1, IMC(r0)
                sd $t0, estado(r0)
                halt
