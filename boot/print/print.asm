print:
    mov al, [si]
    cmp al, 0
    je .end
    call .printChar
    inc si
    jmp print
.end:
    ret
.printChar:
    mov ah, 0x0e
    int 0x10
    ret