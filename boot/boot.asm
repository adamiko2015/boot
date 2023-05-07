org 0x7c00
bits 16

kernel_offset equ 0x1000 ; memory offset of kernel (-Ttext 0x1000)

mov [boot_drive], dl ; drive stored in dl
mov sp, bp           ; set up stack

mov si, boot_msg
call print

call load_kernel

call switch_to_pm

jmp $

%include "print/print.asm"
%include "print/printhex.asm"
%include "disk/disk_load.asm"
%include "pm/gdt.asm"
%include "pm/switch_to_pm.asm"
%include "pm/print32.asm"

bits 16
load_kernel:
    mov si, load_kernel_msg
    call print

    mov bx, kernel_offset
    mov dh, 15              ; read 15 sectors
    mov dl, [boot_drive]    ; from boot drive
    call disk_load

    ret

bits 32
begin_pm:
    mov ebx, pm_msg
    call print32
    
    call kernel_offset

    jmp $

; DATA
boot_drive db 0
boot_msg db "Booting in real mode, switching to PM", 0x0d, 0x0a, 0
pm_msg db "Successfully switched!", 0x0d, 0x0a, 0
load_kernel_msg db "Loading kernel...", 0x0d, 0x0a, 0

times 510-($-$$) db 0
dw 0xaa55