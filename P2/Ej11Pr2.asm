PIC         EQU 20h
EOI         EQU 20h
N_F10       EQU 10

            ORG 40
POS_F10     dw RUT_F10
            
            ORG 1000h
letra       db ?

            ORG 2000h
            ;configuración PIC
            CLI
            mov al,0FEh
            OUT PIC+1,al  ;IMR (21h)
            mov al,N_F10
            OUT PIC+4,al  ;INT0 (24h)
            mov dl,1
            STI
            
REINICIAR:  mov ah,41h ;ASCII de A
LOOP:       inc ah
            cmp ah,5Ah  ;ASCII de Z
            jz REINICIAR
            cmp dl,0
            jnz LOOP

            int 0

            ORG 3000h
RUT_F10:    push bx
            push ax
            dec dl
            mov letra,ah
            mov bx,offset letra
            mov al,1
            int 7
            mov al,EOI
            OUT EOI,al  ;EOI (20h)
            pop ax
            pop bx
            iret
end
            
            