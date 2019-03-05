data    segment para public 'data'
message db  'Hello World!$'
data    ends

stk segment stack
    db  256 dup ('?')
stk ends

code    segment para public 'code'

    assume cs:code, ds:code, ss:stk

main:
    mov ax, data
    mov ds, ax
    mov dx, offset message
    mov ah, 09h
    int 21h

mov ax, 4c00h
    int 21h

code    ends

end main
