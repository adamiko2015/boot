gdt_start:

gdt_null:
    dd 0
    dd 0

gdt_code:
    ; base = 0, limit = 0xfffff 
    ; first flags: (present)1 (privilige)00 (desc type)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; second flags: (gran)1 (32bit)1 (64bit)0 (avl)0 -> 1100b

    dw 0xffff ; first 16 bits of limit
    dw 0      ; 16 +
    db 0      ; 8 = 24 bits of base
    db 0b10011010 ; first flags, type (note: figure had it reverse order)
    db 0b11001111 ; second flags, last 4 bits of limit 
    db 0

gdt_data:
    ; base = 0, limit = 0xfffff
    ; first flags: (present)1 (privilige)00 (desc type)1 -> 1001b
    ; type flags: (code)0 (direction)0 (writeable)1 (accessed)0 -> 0010b
    ; second flags: (gran)1 (32bit)1 (64bit)0 (avl)0 -> 1100b

    dw 0xffff ; first 16 bits of limit
    dw 0      ; 16 +
    db 0      ; 8 = 24 bits of base
    db 0b10010010 ; first flags, type (note: figure had it reverse order)
    db 0b11001111 ; second flags, last 4 bits of limit 
    db 0

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of gdt, 1 less than true size
    dd gdt_start                ; start address of gdt

; constants
; these describe the address of the code and data descriptors relative to 
; the start of the gdt. when in protected mode, the cs and ds registers will
; contain these constants. their new role in real mode is to point to the correct 
; descriptor in the gdt, where the exact segment is described.

code_seg equ gdt_code - gdt_start
data_seg equ gdt_data - gdt_start
