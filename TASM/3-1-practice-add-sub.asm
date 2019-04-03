; Reads three symbols in the form a+b or a-b and outputs the answer
; (a and b are single digit numbers)

masm
model	small
.data
message     db 'Enter two single digit numbers in the form a+b or a-b: $'
errMsg      db 10,13,'Unsupported command!$'
operation   db ?
num1        db ?
num2        db ?
result      db ?
.stack	256
.code
main:
    ; setting up data segment
    mov	ax, @data
    mov ds, ax

    ; initial message
    mov ah, 09h
    lea dx, message
    int 21h

    ; reading first digit and saving it
    mov ah, 01h
    int 21h
    mov num1, al

    ; reading operation and saving it
    int 21h
    mov operation, al

    ; reading second digit and saving it
    int 21h
    mov num2, al

    ; printing out an equal sign
    mov ah, 02h
    mov dl, '='
    int 21h

    ; jumping to the correct operation
    cmp operation, '-'
    je subtraction
    cmp operation, '+'
    jne error

    ; operation is addition
    ;   adding the two numbers, saving the result
    xor ax, ax
    mov al, [num1]
    add al, num2
    mov result, al
    sub result, '0'
    jmp print

subtraction:
    mov al, [num1]
    sub al, num2
    add al, '0'
    mov result, al
    cmp result, '0'
    jge singleDigitPrint
    ; if the result is lesser than 0
    ; print a '-' and adjust the result
    mov al, '0'
    sub al, result
    mov result, al
    add result, '0'
    mov ah, 02h
    mov dl, '-'
    int 21h
    jmp singleDigitPrint

print:
    cmp result, '9'
    jle singleDigitPrint
    ; if it's greater than 9
    ; print a '1' and remove 10 from the num
    ; then we can print the second digit
    mov dl, '1'
    mov ah, 02h
    int 21h
    sub result, 10
    
singleDigitPrint:
    mov dl, result
    mov ah, 02h
    int 21h

exit:
    mov ax, 4c00h
    int 21h

error:
    mov ah, 09h
    lea dx, errMsg
    int 21h
    jmp exit

end main
