switch_to_pm:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0    ; moving the cr0 reg to eax
    or eax, 0x1     ; setting first bit
    mov cr0, eax    ; moving it back

    ; issue a far jump
    ; by issuing a far jump (a jump to a different segment), the cpu flushes all
    ; instructions in the pipeline, thus making sure that all future instructions
    ; will be performed in the correct mode (32 bits). additionally, it automatically
    ; updates the cs register to point to the code segment descriptor in the gdt. 
    jmp code_seg:init_pm

bits 32
init_pm:
    mov ax, data_seg    ; initializing all segment registers (except cs)
    mov ds, ax           ; to point to the gdt's data descriptor
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000    ; moving stack base to top of free space
    mov esp, ebp

    call begin_pm