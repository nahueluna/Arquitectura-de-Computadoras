.data
base:       .double 5.85
altura:     .double 13.47
mitad:      .double 0.5
res:        .double 0.0

.text
            l.d f1, base(r0)
            l.d f2, altura(r0)
            l.d f3, mitad(r0)

            mul.d f4, f1, f2
            mul.d f4, f4, f3 #multiplicar por 0.5 = dividor por 2

            s.d f4, res(r0)
            halt