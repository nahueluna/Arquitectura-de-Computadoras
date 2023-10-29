ORG 1000H
byte1 db 94h
N db 6

ORG 2000H
mov al,byte1
mov ah,N
call ROTARDER_N
hlt

;PARAMETROS ENTRADA
;al por valor, cadena de bits
;ah por valor, cantidad de rotaciones a la derecha
ORG 3000H
ROTARDER_N: push dx
mov dl,8
sub dl,ah
mov ah,dl
LOOP1: cmp ah,0
jz FIN
adc al, al
adc al,0
dec ah
jmp LOOP1
FIN: mov byte1,al
pop dx
ret
end

;Se observa que sin subrutinas que realicen las rotaciones
;el código pierde legibilidad. El uso de subrutinas, además
;facilita tareas al programador (por el enfoque en el que cada
;modulo realiza una tarea especifica)