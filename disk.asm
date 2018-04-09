; Load number of sectors in dh from drive in dl into es:bx.
disk_load:
    pusha
    ; dx will be overwritten before used so save to stack.
    push dx

    mov ah, 0x02 ; Interrupt 0x13 register. 0x02 is read.
    mov al, dh ; Number of sectors to read.
    mov cl, 0x02 ; Starting sector. 0x01 is boot sector.
    mov ch, 0x00 ; Cylinder number.
    ; Drive number is set by caller in dl.
    mov dh, 0x00 ; Head number.

    int 0x13 ; BIOS disk interrupt.
    jc disk_error ; Carry bit set if error.

    ; BIOS sets al to the number of sectors read.
    pop dx
    cmp al, dh ; Compare actual sectors read with expected.
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print_string
    call print_newline
    mov dh, ah ; Move error code to dh, dl has disk number that errored.
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print_string

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error.", 0
SECTORS_ERROR: db "Incorrect number of sectors read.", 0
