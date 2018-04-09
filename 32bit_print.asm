[bits 32]

VIDEO_MEM equ 0xB8000
WHITE_ON_BLACK equ 0x0F

print_string_32:
    pusha
    mov edx, VIDEO_MEM

print_string_32_loop:
    mov ah, WHITE_ON_BLACK
    mov al, [ebx]

    jz print_string_32_done

    mov [edx], ax
    inc ebx         ; Next character.
    add edx, 2      ; Next video memory position.

    jmp print_string_32_loop

print_string_32_done:
    popa
    ret
