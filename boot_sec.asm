[org 0x7C00] ; Set origin address to the expected bootloader address.

mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string_rm

call switch_to_32
jmp $       ; Should never get here.

%include "realmode_print.asm"
%include "32bit_gdt.asm"
%include "32bit_print.asm"
%include "32bit_switch.asm"

[bits 32]
begin_32:
    mov ebx, MSG_32BIT_MODE
    call print_string_32
    jmp $

MSG_REAL_MODE: db "Started in 16-bit real mode", 0
MSG_32BIT_MODE: db "Loaded 32-bit protected mode", 0

; Bootsector.
times 510-($-$$) db 0
dw 0xAA55
