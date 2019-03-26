; Reads 3 symbols and outputs them in reverse
masm
model	small
.data
.stack	256
.code
main:

    mov cx, 3   ; looping 3 times
    mov ah, 01h ; reading one char instruction
readlp:
    int 21h     ; excute the instruction
    push ax     ; push the returned value in the stack
loop readlp

    ; printing a new line and a carriage return symbol
    mov ah, 02h ; print one char instruction
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    mov cx, 3   ; looping 3 times
writelp:
    pop dx      ; get a value from the stack
    int 21h     ; execute the print one char instruction
loop writelp

    mov ax, 4c00h
    int 21h

end main
