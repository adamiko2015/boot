printhex: ; prints the number stored in dx
    pusha
    mov si, hextable

    mov bx, dx
    shr bx, 12
    and bx, 0b1111
    mov al, [si+bx]
    mov [final + 2], al

    mov bx, dx
    shr bx, 8
    and bx, 0b1111
    mov al, [si+bx]
    mov [final + 3], al

    mov bx, dx
    shr bx, 4
    and bx, 0b1111
    mov al, [si+bx]
    mov [final + 4], al

    mov bx, dx
    and bx, 0b1111
    mov al, [si+bx]
    mov [final + 5], al

    mov si, final
    call print
    popa
    ret

final: db "0x....", 0
hextable: db "0123456789abcdef"