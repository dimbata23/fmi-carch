; Checks a word if it's a palindrome (up to 10 symbols)

masm
model	small
.data
msg     db "Enter a word up to 10 characters to test if it's a palindrome: ",10,13,"$"
msg_yes db "It's a palindrome$"
msg_no  db "It's not a palindrome$"
buffer  db 10 dup ('?')
.stack	256
.code
main:
    ; setting up data segment
    mov	ax, @data
    mov ds, ax

    ; printing out initial message
    mov ah, 09h
    lea dx, msg
    int 21h

    ; zero out bx
    xor bx, bx
    ; reading characters and storing them
    ; breaks out of the loop when enter is pressed
reading:
    mov ah, 01h
    int 21h
    cmp al, 0dh
    je exitReading
    mov buffer[bx], al
    push ax
    inc bx
    jmp reading

exitReading:
    ; bx is the length of our word
    mov cx, bx
    xor bx, bx
comparing:
    pop ax
    cmp al, buffer[bx]
    jne printNo
    inc bx
    loop comparing

printYes:
    mov ah, 09h
    lea dx, msg_yes
    int 21h
    jmp exit

printNo:
    mov ah, 09h
    lea dx, msg_no
    int 21h
    jmp exit

exit:
    mov ax, 4c00h
    int 21h

end main
