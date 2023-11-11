.data
CONTROL:                .word32 0x10000
DATA:                   .word32 0x10008

.text
                        lwu $s0, DATA($0)
                        lwu $s1, CONTROL($0)

                        daddi $t0, $0, 8
                        sd $t0, 0($s1)
                        l.d f0, 0($s0) #Base
                        mfc1 $a0, f0

                        sd $t0, 0($s1)
                        ld $a1, 0($s0)  #Exponente

                        jal potencia

                        daddi $t0, $0, 3
                        mtc1 $v0, f0
                        s.d f0, 0($s0)
                        sd $t0, 0($s1)

                        halt

potencia:               mtc1 $a0, f0
                        
                        daddi $t0, $0, 1
                        mtc1 $t0, f1
                        cvt.d.l f1, f1

loop:                   beqz $a1, fin
                        mul.d f1, f1, f0
                        daddi $a1, $a1, -1
                        j loop

fin:                    mfc1 $v0, f1
                        jr $ra