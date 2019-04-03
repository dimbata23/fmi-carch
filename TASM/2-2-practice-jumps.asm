; Reads a symbol and outputs a message 
; wheter it's a letter, number or neither

masm
model	small
.data
message   db 10,13,'You have entered $'
msgLetter db 'a letter.$'
msgNumber db 'a number.$'
msgOther  db 'something else.$'
.stack	256
.code
main:
    ; getting the data segment ready
    mov	ax, @data
    mov ds, ax

    mov ah, 01h ; read one char instruction
    int 21h     ; execute the instruction

    ; comparing the read character
    ; and jumping to a specific point
    cmp al, 'a'
    jge greaterThanSmallA
    cmp al, 'A'
    jge greaterThanBigA
    cmp al, '0'
    jge greaterThan0
    jmp other

greaterThanBigA:
    cmp al, 'Z'
    jle isLetter
    jmp other

greaterThanSmallA:
    cmp al, 'z'
    jle isLetter
    jmp other

greaterThan0:
    cmp al, '9'
    jle isNumber
    jmp other

isLetter:
    mov ah, 09h ; print a $ terminated string instruction
    lea dx, message ; loads the address of message
    int 21h     ; print the message
    lea dx, msgLetter
    int 21h
    jmp exit

isNumber:
    mov ah, 09h
    lea dx, message
    int 21h
    lea dx, msgNumber
    int 21h
    jmp exit

other:
    mov ah, 09h
    lea dx, message
    int 21h
    lea dx, msgOther
    int 21h

exit:
    mov ax, 4c00h
    int 21h

end main