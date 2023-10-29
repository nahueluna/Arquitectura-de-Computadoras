ORG 1000H
num1 dw 0F871h,0A765h
num2 dw 0A876h,00FFh
resul dw ?,?

ORG 2000H
mov ax,num1
add ax,num2
mov resul,ax
mov ax,num1+2
adc ax,num2+2
mov resul+2,ax
hlt
end