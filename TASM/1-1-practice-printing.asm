; Using the example code, write a program that outputs "I have $50!" to the console

data    segment para public 'data'
message1 db  'I have $'
message2 db  '50!$'
data    ends

stk segment stack
    db  256 dup ('?')
stk ends

code    segment para public 'code'

    assume cs:code, ds:code, ss:stk

main:
    mov ax, data
    mov ds, ax
    mov dx, offset message1
    mov ah, 09h
    int 21h
    mov dl, '$'
    mov ah, 02h
    int 21h
    mov dx, offset message2
    mov ah, 09h
    int 21h

mov ax, 4c00h
    int 21h

code    ends

end main
