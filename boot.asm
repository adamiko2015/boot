org 0x7c00
bits 16

section .text:
    global _start

_start:

mov si, boot_msg
call print

call switch_to_pm

jmp $

%include "print.asm"
%include "printhex.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "print32.asm"

bits 32
begin_pm:
    mov ebx, pm_msg
    call print32
    
    jmp $

; DATA
boot_msg db "Switching to 32 bits", 0x0d, 0x0a, 0
pm_msg db "Successfully switched!", 0

times 510-($-$$) db 0
dw 0xaa55