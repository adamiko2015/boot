vidmem equ 0xb8000 ; address of video memory

print32:
    pusha
    mov edx, vidmem
.loop:
    mov al, [ebx]
    mov ah, 0x0f
    
    cmp al, 0
    je .done

    mov [edx], ax ; store the character (al,ah) in vidmem (edx)
    add ebx, 1    ; move to next character
    add edx, 2    ; move to next video cell

    jmp .loop
.done:
    popa
    ret