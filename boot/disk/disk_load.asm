disk_load:
    mov ah, 0x02
    mov al, dh
    mov dh, 0
    mov ch, 0
    mov cl, 2
    int 0x13

    jc .disk_read_error
    jmp .end
.disk_read_error:
    mov si, disk_read_err_msg
    call print
    jmp $
.end:
    ret

disk_read_err_msg: db "Error reading from disk!", 0