; using assembly instructions to represent
; neg(a or b) and (a xor c) xor c
; Warning: This program doesn't actually do anything
;          except for representing the expression!

masm
model	small
.data
a       db 1
b       db 0
c       db 1
.stack	256
.code
main:
    ; setting up data segment
    mov	ax, @data
    mov ds, ax

    mov dl, a
    or dl, b
    not dl

    mov dh, a
    xor dh, c
    
    and dl, dh
    xor dl, c

    mov ax, 4c00h
    int 21h
end main
